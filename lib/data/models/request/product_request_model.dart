
import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  // data yang dikirim itu yang dari postman
  final String writerName;
  final String title;
  final String desc;
  final int price;
  final String category;
  final int mostLikes;
  final XFile img;
  ProductRequestModel({
    required this.writerName,
    required this.title,
    required this.price,
    required this.desc,
    required this.category,
    required this.mostLikes,
    required this.img,
  });

  Map<String, String> toMap() {
    return {
      'writerName': writerName,
      'title': title,
      'desc': desc,
      'price': price.toString(),
      'category': category,
      'most_likes': mostLikes.toString(),
    };
  }
}
