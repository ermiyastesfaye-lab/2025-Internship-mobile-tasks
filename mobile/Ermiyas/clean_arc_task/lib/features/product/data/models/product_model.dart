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
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? 'Unknown',
        category: json['category'] ?? 'Uncategorized',
        price: (json['price'] is num)
            ? (json['price'] as num).toDouble()
            : double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
        description: json['description'] ?? 'No description available',
        imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150');
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
