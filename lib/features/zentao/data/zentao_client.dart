import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../core/text/html_format.dart';

import '../domain/models/zentao_bug.dart';
import '../domain/models/zentao_bug_attachment.dart';
import '../domain/models/zentao_bug_comment.dart';
import '../domain/models/zentao_bug_detail.dart';
import '../domain/models/zentao_product.dart';
import '../domain/models/zentao_task.dart';

/// Thrown when a Zentao request comes back 401/403 — signals the caller
/// (the repository) that the session token has expired and a fresh login
/// should be retried once, rather than surfacing as a generic failure.
class ZentaoAuthException implements Exception {
  ZentaoAuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract class ZentaoClient {
  Future<String> login({
    required String domain,
    required String account,
    required String password,
  });

  Future<List<ZentaoProduct>> fetchProducts({
    required String domain,
    required String token,
  });

  /// Walks Projects -> Executions -> Tasks under [productId] and filters the
  /// combined result to tasks whose `assignedTo.account` equals [account].
  Future<List<ZentaoTask>> fetchAssignedTasks({
    required String domain,
    required String token,
    required int productId,
    required String account,
  });

  Future<ZentaoTask> fetchTask({
    required String domain,
    required String token,
    required int taskId,
  });

  /// Bugs under [productId] assigned to [account] — confirmed directly
  /// against a real instance (`products/:id/bugs?browseType=assignedtome`),
  /// unlike tasks this has no Projects -> Executions fallback walk since
  /// bugs hang directly off the product.
  Future<List<ZentaoBug>> fetchAssignedBugs({
    required String domain,
    required String token,
    required int productId,
    required String account,
  });

  Future<ZentaoBug> fetchBug({
    required String domain,
    required String token,
    required int bugId,
  });

  /// Full bug view — the base bug fields plus its action/comment history
  /// (`actions`) and attachments (`files`), off the same `bugs/:id` response.
  Future<ZentaoBugDetail> fetchBugDetail({
    required String domain,
    required String token,
    required int bugId,
  });

  /// Downloads the raw bytes of attachment [attachmentId] (an authenticated
  /// request — the file endpoint requires the session token like every other
  /// call).
  Future<Uint8List> downloadFile({
    required String domain,
    required String token,
    required int attachmentId,
  });
}

/// Talks to the real Zentao REST API v1
/// (`{domain}/api.php/v1/...`), following `weather_client.dart`'s style:
/// plain `http` package, manual statusCode/JSON null-checking, throws a
/// plain `Exception` (or [ZentaoAuthException] for 401/403) with a
/// descriptive message on failure. Stateless — every method takes
/// `domain`/`token` explicitly; no cached auth state here (that's
/// `ZentaoRepositoryImpl`'s job).
@LazySingleton(as: ZentaoClient)
class ZentaoRestClient implements ZentaoClient {
  static const _apiPath = 'api.php/v1';
  static const _requestTimeout = Duration(seconds: 15);

  // Hard cap on how many task pages to walk per execution — protects
  // against a runaway loop if a paginated response's `total`/`limit` fields
  // are ever malformed. Comfortably above any realistic single-execution
  // task count.
  static const _maxPagesPerExecution = 50;

  static final _trailingApiPathPattern = RegExp(
    r'/api\.php/v1/?$',
    caseSensitive: false,
  );

  Uri _uri(String domain, String path, [Map<String, String>? query]) {
    // Defensive: a stored/typed domain might already include the
    // `api.php/v1` suffix (e.g. a user pasted the full endpoint they were
    // given) — strip it so it isn't appended twice.
    var trimmed = domain.replaceFirst(_trailingApiPathPattern, '');
    if (trimmed.endsWith('/')) {
      trimmed = trimmed.substring(0, trimmed.length - 1);
    }
    return Uri.parse('$trimmed/$_apiPath/$path').replace(
      queryParameters: query,
    );
  }

  Map<String, String> _authHeaders(String token) => {'Token': token};

  void _checkAuth(http.Response response) {
    if (response.statusCode == 401 || response.statusCode == 403) {
      throw ZentaoAuthException(
        'Zentao request unauthorized (status ${response.statusCode})',
      );
    }
  }

  /// Zentao often serializes a PHP associative array as a JSON *object*
  /// keyed by id (e.g. `{"1": {...}, "2": {...}}`) rather than a plain
  /// array, depending on the endpoint and whether the underlying collection
  /// has non-sequential keys. Accept either shape rather than assuming a
  /// `List`.
  List<dynamic> _asItemList(dynamic value) {
    if (value is List) return value;
    if (value is Map<String, dynamic>) return value.values.toList();
    return const [];
  }

  int _asInt(dynamic value) => value is int ? value : (value as num).toInt();

  /// Like [_asInt] but tolerant: null, empty strings, and unparseable values
  /// come back null instead of throwing. Zentao serializes numeric fields
  /// inconsistently (int, numeric string, or empty string), so priority-style
  /// fields go through this.
  int? _asIntOrNull(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    final text = value.toString().trim();
    if (text.isEmpty) return null;
    return int.tryParse(text);
  }

  String? _asNonEmptyString(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  /// Like [_asNonEmptyString] but flattens Zentao's HTML-formatted fields
  /// (bug steps/description, action comments) to readable plain text.
  String? _asHtmlPlainText(dynamic value) {
    final raw = _asNonEmptyString(value);
    if (raw == null) return null;
    final text = htmlToPlainText(raw);
    return text.isEmpty ? null : text;
  }

  double? _asDoubleOrNull(dynamic value) {
    if (value == null) return null;
    return value is double ? value : (value as num).toDouble();
  }

  DateTime? _asDateOrNull(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    // Zentao renders "unset" dates/deadlines as a zero-date string.
    if (text.isEmpty || text.startsWith('0000-00-00')) return null;
    return DateTime.tryParse(text);
  }

  @override
  Future<String> login({
    required String domain,
    required String account,
    required String password,
  }) async {
    final uri = _uri(domain, 'tokens');
    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'account': account, 'password': password}),
        )
        .timeout(_requestTimeout);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        'Zentao login failed with status ${response.statusCode}',
      );
    }

    final body = json.decode(response.body) as Map<String, dynamic>;
    final token = body['token'] as String?;
    if (token == null) {
      throw Exception('Zentao login response missing token');
    }
    return token;
  }

  @override
  Future<List<ZentaoProduct>> fetchProducts({
    required String domain,
    required String token,
  }) async {
    final response = await http
        .get(_uri(domain, 'products'), headers: _authHeaders(token))
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao products request failed with status ${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final rawList = decoded is Map<String, dynamic>
        ? decoded['products']
        : decoded;
    if (rawList == null) {
      throw Exception('Zentao products response missing a products list');
    }
    final list = _asItemList(rawList);

    return [
      for (final item in list)
        if (item is Map<String, dynamic> &&
            item['id'] != null &&
            item['name'] != null)
          ZentaoProduct(
            id: _asInt(item['id']),
            name: item['name'] as String,
            // Zentao's product-ordering field is `order` (falls back to
            // `line`); used as the "product priority" for sorting bugs.
            priority: _asIntOrNull(item['order'] ?? item['line']),
          ),
    ];
  }

  @override
  Future<List<ZentaoTask>> fetchAssignedTasks({
    required String domain,
    required String token,
    required int productId,
    required String account,
  }) async {
    final headers = _authHeaders(token);

    // Confirmed live against a real instance: `products/:id/bugs
    // ?browseType=assignedtome` server-side filters to items assigned to
    // the logged-in account. Try the analogous `products/:id/tasks` shortcut
    // first — a single call instead of walking Projects -> Executions. Only
    // fall back to the walk if this Zentao version doesn't have it (404).
    final tasks = await _fetchTasksDirectFromProduct(domain, headers, productId) ??
        await _fetchTasksByWalkingProduct(domain, headers, productId);

    // Dedupe (the same task can surface more than once across pages/walks)
    // and keep only tasks assigned to this account — a defensive safety net
    // even when the server already filtered via browseType=assignedtome.
    final byId = <int, ZentaoTask>{};
    for (final task in tasks) {
      if (task.assignedToAccount == account) byId[task.id] = task;
    }
    return byId.values.toList();
  }

  /// Tries `GET /products/:id/tasks?browseType=assignedtome` directly.
  /// Returns `null` (rather than throwing) on a 404, signaling the caller to
  /// fall back to the Projects -> Executions walk instead.
  Future<List<ZentaoTask>?> _fetchTasksDirectFromProduct(
    String domain,
    Map<String, String> headers,
    int productId,
  ) async {
    final probe = await http
        .get(
          _uri(domain, 'products/$productId/tasks', {
            'browseType': 'assignedtome',
            'page': '1',
          }),
          headers: headers,
        )
        .timeout(_requestTimeout);
    if (probe.statusCode == 404) return null;

    return _paginatedTasks(
      domain,
      headers,
      'products/$productId/tasks',
      {'browseType': 'assignedtome'},
      firstPageResponse: probe,
    );
  }

  Future<List<ZentaoTask>> _fetchTasksByWalkingProduct(
    String domain,
    Map<String, String> headers,
    int productId,
  ) async {
    final projectIds = await _fetchProjectIds(domain, headers, productId);

    final tasks = <ZentaoTask>[];
    for (final projectId in projectIds) {
      final executionIds = await _fetchExecutionIds(domain, headers, projectId);
      for (final executionId in executionIds) {
        tasks.addAll(
          await _paginatedTasks(domain, headers, 'executions/$executionId/tasks', const {}),
        );
      }
    }
    return tasks;
  }

  Future<List<int>> _fetchProjectIds(
    String domain,
    Map<String, String> headers,
    int productId,
  ) async {
    // The exact query-param shape for product-scoped projects isn't 100%
    // pinned down against a real Zentao instance — try the flat query form
    // first and fall back to the nested product-scoped path on a 404.
    var response = await http
        .get(
          _uri(domain, 'projects', {'product': '$productId'}),
          headers: headers,
        )
        .timeout(_requestTimeout);

    if (response.statusCode == 404) {
      response = await http
          .get(_uri(domain, 'products/$productId/projects'), headers: headers)
          .timeout(_requestTimeout);
    }

    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao projects request failed with status ${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final rawList = decoded is Map<String, dynamic>
        ? (decoded['projects'] ?? decoded['data'])
        : decoded;
    final list = _asItemList(rawList);

    return [
      for (final item in list)
        if (item is Map<String, dynamic> && item['id'] != null)
          _asInt(item['id']),
    ];
  }

  Future<List<int>> _fetchExecutionIds(
    String domain,
    Map<String, String> headers,
    int projectId,
  ) async {
    final response = await http
        .get(_uri(domain, 'projects/$projectId/executions'), headers: headers)
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao executions request failed with status '
        '${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final rawList = decoded is Map<String, dynamic>
        ? (decoded['executions'] ?? decoded['data'])
        : decoded;
    final list = _asItemList(rawList);

    return [
      for (final item in list)
        if (item is Map<String, dynamic> && item['id'] != null)
          _asInt(item['id']),
    ];
  }

  /// Walks every page of a `{page, total, limit, <listKey>: [...]}` endpoint
  /// at `path` (e.g. `executions/:id/tasks`, `products/:id/tasks`, or
  /// `products/:id/bugs`), merging [extraQuery] into each page's query
  /// string and parsing each raw item via [parseItem]. If [firstPageResponse]
  /// is given, it's used for page 1 instead of making a redundant request
  /// (a direct-shortcut probe may have already fetched it).
  Future<List<T>> _paginatedItems<T>(
    String domain,
    Map<String, String> headers,
    String path,
    Map<String, String> extraQuery, {
    required String listKey,
    required T Function(Map<String, dynamic>) parseItem,
    http.Response? firstPageResponse,
  }) async {
    final items = <T>[];
    var page = 1;
    while (page <= _maxPagesPerExecution) {
      final response = page == 1 && firstPageResponse != null
          ? firstPageResponse
          : await http
                .get(
                  _uri(domain, path, {...extraQuery, 'page': '$page'}),
                  headers: headers,
                )
                .timeout(_requestTimeout);
      _checkAuth(response);
      if (response.statusCode != 200) {
        throw Exception(
          'Zentao $listKey request failed with status ${response.statusCode}',
        );
      }

      final body = json.decode(response.body) as Map<String, dynamic>;
      if (body[listKey] == null) {
        throw Exception('Zentao $listKey response missing a $listKey list');
      }
      final rawItems = _asItemList(body[listKey]);

      for (final item in rawItems) {
        if (item is Map<String, dynamic>) items.add(parseItem(item));
      }

      final total = body['total'];
      final limit = body['limit'];
      if (total == null || limit == null || rawItems.isEmpty) break;
      final totalCount = _asInt(total);
      final pageSize = _asInt(limit);
      if (pageSize <= 0 || page * pageSize >= totalCount) break;
      page++;
    }
    return items;
  }

  Future<List<ZentaoTask>> _paginatedTasks(
    String domain,
    Map<String, String> headers,
    String path,
    Map<String, String> extraQuery, {
    http.Response? firstPageResponse,
  }) => _paginatedItems(
    domain,
    headers,
    path,
    extraQuery,
    listKey: 'tasks',
    parseItem: _parseTask,
    firstPageResponse: firstPageResponse,
  );

  Future<List<ZentaoBug>> _paginatedBugs(
    String domain,
    Map<String, String> headers,
    String path,
    Map<String, String> extraQuery, {
    http.Response? firstPageResponse,
  }) => _paginatedItems(
    domain,
    headers,
    path,
    extraQuery,
    listKey: 'bugs',
    parseItem: _parseBug,
    firstPageResponse: firstPageResponse,
  );

  @override
  Future<ZentaoTask> fetchTask({
    required String domain,
    required String token,
    required int taskId,
  }) async {
    final response = await http
        .get(_uri(domain, 'tasks/$taskId'), headers: _authHeaders(token))
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao task request failed with status ${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final body = decoded is Map<String, dynamic>
        ? (decoded['task'] as Map<String, dynamic>? ?? decoded)
        : throw Exception('Zentao task response was not an object');
    return _parseTask(body);
  }

  ZentaoTask _parseTask(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final status = json['status'];
    if (id == null || name == null || status == null) {
      throw Exception('Zentao task response missing id/name/status');
    }

    final assignedTo = json['assignedTo'];
    String? assignedToAccount;
    String? assignedToRealName;
    if (assignedTo is Map<String, dynamic>) {
      assignedToAccount = assignedTo['account'] as String?;
      assignedToRealName = assignedTo['realname'] as String?;
    } else if (assignedTo is String && assignedTo.isNotEmpty) {
      // Some Zentao responses shorthand assignedTo as a bare account string
      // instead of an object.
      assignedToAccount = assignedTo;
    }

    return ZentaoTask(
      id: _asInt(id),
      name: name as String,
      status: status as String,
      assignedToAccount: assignedToAccount,
      assignedToRealName: assignedToRealName,
      estimate: _asDoubleOrNull(json['estimate']),
      consumed: _asDoubleOrNull(json['consumed']),
      left: _asDoubleOrNull(json['left']),
      deadline: _asDateOrNull(json['deadline']),
    );
  }

  @override
  Future<List<ZentaoBug>> fetchAssignedBugs({
    required String domain,
    required String token,
    required int productId,
    required String account,
  }) async {
    final headers = _authHeaders(token);

    final bugs = await _paginatedBugs(
      domain,
      headers,
      'products/$productId/bugs',
      const {'browseType': 'assignedtome'},
    );

    // Defensive safety net even though the server already filtered via
    // browseType=assignedtome — mirrors fetchAssignedTasks.
    final byId = <int, ZentaoBug>{};
    for (final bug in bugs) {
      if (bug.assignedToAccount == account) byId[bug.id] = bug;
    }
    return byId.values.toList();
  }

  @override
  Future<ZentaoBug> fetchBug({
    required String domain,
    required String token,
    required int bugId,
  }) async {
    final response = await http
        .get(_uri(domain, 'bugs/$bugId'), headers: _authHeaders(token))
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao bug request failed with status ${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final body = decoded is Map<String, dynamic>
        ? (decoded['bug'] as Map<String, dynamic>? ?? decoded)
        : throw Exception('Zentao bug response was not an object');
    return _parseBug(body);
  }

  ZentaoBug _parseBug(Map<String, dynamic> json) {
    final id = json['id'];
    // Zentao's schema conventionally uses `title` for bugs (vs `name` for
    // tasks) — unconfirmed against a real bug response, fall back to `name`
    // defensively in case this instance shapes it differently.
    final title = json['title'] ?? json['name'];
    final status = json['status'];
    if (id == null || title == null || status == null) {
      throw Exception('Zentao bug response missing id/title/status');
    }

    final assignedTo = json['assignedTo'];
    String? assignedToAccount;
    String? assignedToRealName;
    if (assignedTo is Map<String, dynamic>) {
      assignedToAccount = assignedTo['account'] as String?;
      assignedToRealName = assignedTo['realname'] as String?;
    } else if (assignedTo is String && assignedTo.isNotEmpty) {
      assignedToAccount = assignedTo;
    }

    return ZentaoBug(
      id: _asInt(id),
      title: title as String,
      status: status as String,
      // Zentao bugs carry repro steps in `steps`; some instances/exports use
      // `desc`/`description`. Prefer whichever is present. These come back as
      // HTML, so flatten to readable plain text.
      description: _asHtmlPlainText(
        json['steps'] ?? json['desc'] ?? json['description'],
      ),
      priority: _asIntOrNull(json['pri']),
      assignedToAccount: assignedToAccount,
      assignedToRealName: assignedToRealName,
      severity: _asIntOrNull(json['severity']),
      deadline: _asDateOrNull(json['deadline']),
    );
  }

  @override
  Future<ZentaoBugDetail> fetchBugDetail({
    required String domain,
    required String token,
    required int bugId,
  }) async {
    final response = await http
        .get(_uri(domain, 'bugs/$bugId'), headers: _authHeaders(token))
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao bug detail request failed with status ${response.statusCode}',
      );
    }

    final decoded = json.decode(response.body);
    final body = decoded is Map<String, dynamic>
        ? (decoded['bug'] as Map<String, dynamic>? ?? decoded)
        : throw Exception('Zentao bug response was not an object');

    return ZentaoBugDetail(
      bug: _parseBug(body),
      comments: _parseBugComments(body['actions']),
      attachments: _parseBugAttachments(body['files']),
    );
  }

  /// Parses the `actions` history log — kept only for entries that actually
  /// carry a written comment, most-recent last (Zentao returns them in
  /// chronological order). Tolerates both a JSON array and an id-keyed object
  /// shape via [_asItemList].
  List<ZentaoBugComment> _parseBugComments(dynamic actions) {
    final result = <ZentaoBugComment>[];
    for (final item in _asItemList(actions)) {
      if (item is! Map<String, dynamic>) continue;
      final comment = _asHtmlPlainText(item['comment']);
      if (comment == null) continue;
      final actor = item['actor'];
      result.add(
        ZentaoBugComment(
          id: _asIntOrNull(item['id']),
          actor: actor is Map<String, dynamic>
              ? _asNonEmptyString(actor['realname'] ?? actor['account'])
              : _asNonEmptyString(actor),
          date: _asDateOrNull(item['date']),
          comment: comment,
        ),
      );
    }
    return result;
  }

  List<ZentaoBugAttachment> _parseBugAttachments(dynamic files) {
    final result = <ZentaoBugAttachment>[];
    for (final item in _asItemList(files)) {
      if (item is! Map<String, dynamic>) continue;
      final id = _asIntOrNull(item['id']);
      if (id == null) continue;
      result.add(
        ZentaoBugAttachment(
          id: id,
          title:
              _asNonEmptyString(item['title'] ?? item['pathname']) ??
              'Attachment $id',
          fileExtension: _asNonEmptyString(item['extension']),
          sizeBytes: _asIntOrNull(item['size']),
        ),
      );
    }
    return result;
  }

  @override
  Future<Uint8List> downloadFile({
    required String domain,
    required String token,
    required int attachmentId,
  }) async {
    // File-download URL shape is unconfirmed against the live instance — the
    // API v1 file endpoint is the best candidate; adjust here if it 404s.
    final response = await http
        .get(_uri(domain, 'files/$attachmentId'), headers: _authHeaders(token))
        .timeout(_requestTimeout);
    _checkAuth(response);
    if (response.statusCode != 200) {
      throw Exception(
        'Zentao file download failed with status ${response.statusCode}',
      );
    }
    return response.bodyBytes;
  }
}
