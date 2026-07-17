part of 'zentao_product_picker_cubit.dart';

@freezed
abstract class ZentaoProductPickerState with _$ZentaoProductPickerState {
  const factory ZentaoProductPickerState({
    @Default(true) bool isLoadingProducts,
    @Default(<ZentaoProduct>[]) List<ZentaoProduct> products,
    String? productsError,
    ZentaoProduct? selectedProduct,
    @Default(false) bool isLoadingItems,
    @Default(<ZentaoTask>[]) List<ZentaoTask> tasks,
    @Default(<ZentaoBug>[]) List<ZentaoBug> bugs,
    String? itemsError,
    int? importingId,
  }) = _ZentaoProductPickerState;
}
