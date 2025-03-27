import 'package:task_7/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.category,
      required super.price,
      required super.description,
      required super.imageUrl});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
        description: json['description'],
        imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "price": price,
      "description": description,
      "imageUrl": imageUrl
    };
  }
}
