part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  
  const factory ProductEvent.fetch() = _Fetch;
  const factory ProductEvent.fetchByCategory(String category) =
      _FetchByCategory;
    // Add data produk
  const factory ProductEvent.addProduct(Product product, XFile image) =
      _AddProduct;
  // SEARCH PRODUCT
  const factory ProductEvent.searchProduct(String query) = _SearchProduct;
  // Featch from state 
   const factory ProductEvent.fetchAllFromSate() = _FetchAllFromState;

}