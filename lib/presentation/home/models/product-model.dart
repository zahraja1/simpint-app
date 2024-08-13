
import 'package:katalog/presentation/home/models/product_category.dart';
import 'package:katalog/presentation/int_ext.dart';

class ProductModel {
  final String img;
  final String writer_name;
  final String title;
  final String desc;
  final ProductCategory category;
  final int price;

  ProductModel({
      required this.img,
      required this.writer_name,
      required this.desc,
      required this.title,
      required this.category,
      required this.price,
    });

    String get priceFormat => price.currencyFormatRp;
}
