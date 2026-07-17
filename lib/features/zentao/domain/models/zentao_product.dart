import 'package:freezed_annotation/freezed_annotation.dart';

part 'zentao_product.freezed.dart';

@freezed
abstract class ZentaoProduct with _$ZentaoProduct {
  /// [priority] is the product's own ordering/priority on Zentao (the
  /// `order`/`line` field, if the products endpoint exposes one) — carried
  /// through so bugs imported under a product can be sorted by "product
  /// priority" offline. Null when the instance doesn't return it.
  const factory ZentaoProduct({
    required int id,
    required String name,
    int? priority,
  }) = _ZentaoProduct;
}
