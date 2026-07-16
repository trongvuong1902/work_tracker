import 'package:injectable/injectable.dart' hide Order;

import '../../../database/leave_reminder/commute_sample_entity.dart';
import '../../../database/objectbox.g.dart';

abstract class CommuteSampleDao {
  void insert(CommuteSampleEntity entity);

  /// Samples with `capturedAt >= [since]`, most-recent-first.
  List<CommuteSampleEntity> getSince(DateTime since);

  /// Deletes all samples with `capturedAt < [before]`. Used for pruning.
  void deleteOlderThan(DateTime before);

  /// Deletes every sample (used on Home/Work location change).
  void deleteAll();
}

@LazySingleton(as: CommuteSampleDao)
class CommuteSampleDaoImpl implements CommuteSampleDao {
  final Box<CommuteSampleEntity> _box;

  CommuteSampleDaoImpl(this._box);

  @override
  void insert(CommuteSampleEntity entity) => _box.put(entity); // id stays 0 -> always an insert

  @override
  List<CommuteSampleEntity> getSince(DateTime since) {
    final query = _box
        .query(CommuteSampleEntity_.capturedAt.greaterOrEqualDate(since))
        .order(CommuteSampleEntity_.capturedAt, flags: Order.descending)
        .build();
    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  @override
  void deleteOlderThan(DateTime before) {
    final query = _box
        .query(CommuteSampleEntity_.capturedAt.lessThanDate(before))
        .build();
    try {
      _box.removeMany(query.findIds());
    } finally {
      query.close();
    }
  }

  @override
  void deleteAll() => _box.removeAll();
}
