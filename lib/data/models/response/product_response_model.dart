// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class ProductResponseModel {
    final bool success;
    final String message;
    final List<Product> data;

    ProductResponseModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ProductResponseModel.fromJson(String str) =>
     ProductResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProductResponseModel.fromMap(Map<String, dynamic> json) => 
    ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Product {
    final int? id;
    final String title;
    final String writerName;
    final String desc;
    final String img;
    final String category;
    final int price;
    final int mostLikes;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Product({
         this.id,
        required this.title,
        required this.writerName,
        required this.desc,
        required this.img,
        required this.category,
        required this.price,
        required this.mostLikes,
         this.createdAt,
         this.updatedAt,
    });

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        writerName: json["writer_name"],
        desc: json["desc"],
        img: json["img"],
        category: json["category"],
        price: json["price"],
        mostLikes: json["most_likes"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "writer_name": writerName,
        "desc": desc,
        "img": img,
        "category": category,
        "price": price,
        "most_likes": mostLikes,
    };

  Product copyWith({
    int? id,
    String? title,
    String? writerName,
    String? desc,
    String? img,
    String? category,
    int? price,
    int? mostLikes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      writerName: writerName ?? this.writerName,
      desc: desc ?? this.desc,
      img: img ?? this.img,
      category: category ?? this.category,
      price: price ?? this.price,
      mostLikes: mostLikes ?? this.mostLikes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.writerName == writerName &&
        other.desc == desc &&
        other.price == price &&
        other.category == category &&
        other.img == img &&
        other.mostLikes == mostLikes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        writerName.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        category.hashCode ^
        img.hashCode ^
        mostLikes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
