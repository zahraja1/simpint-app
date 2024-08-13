// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:katalog/data/models/response/product_response_model.dart';

class FavoriteItem {
  final Product product;

  // Konstruktor untuk membuat objek FavoriteItem
  FavoriteItem({
    required this.product, // Produk favorit
  });

  // Metode untuk mengonversi objek FavoriteItem menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(), // Konversi produk menjadi Map
    };
  }

  // Factory method untuk membuat objek FavoriteItem dari Map
  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      product: Product.fromMap(map['product']), // Buat objek produk dari Map
    );
  }

  // Metode untuk mengonversi objek FavoriteItem menjadi JSON
  String toJson() => json.encode(toMap());

  // Factory method untuk membuat objek FavoriteItem dari JSON
  factory FavoriteItem.fromJson(String source) =>
      FavoriteItem.fromMap(json.decode(source));
}
