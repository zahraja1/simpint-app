import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:katalog/data/dataSource/product_remote_datasource.dart';
import 'package:katalog/data/models/response/product_response_model.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDataSource;
  // Untuk Ambil data produk
  List<Product> products = [];
  ProductBloc(
    this._productRemoteDataSource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemoteDataSource.getProducts();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    // Ini untuk filter data berdasarkan kategori
    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();

      emit(ProductState.success(newProduct));
    });
// Ini buat search data product
    on<_SearchProduct>((event, emit) async {
      emit(const ProductState.loading());

      final newProduct = products
          .where((element) =>
              element.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductState.success(newProduct));
    });

    // Ini buat ngembaliin ke halaman awal
    on<_FetchAllFromState>((event, emit) async {
      emit(const ProductState.loading());

      emit(ProductState.success(products));
    });
  }
}