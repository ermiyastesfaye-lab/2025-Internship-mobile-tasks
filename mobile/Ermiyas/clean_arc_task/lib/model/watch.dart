import 'dart:convert';

class Watch {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageUrl;

  Watch(
      {required this.id,
      required this.name,
      required this.category,
      required this.price,
      required this.description,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'description': description,
      'imageUrl': imageUrl
    };
  }

  factory Watch.fromMap(Map<String, dynamic> map) {
    return Watch(
      id: map['id'].toString(),
      name: map['name'],
      price: map['price'],
      category: map['category'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => jsonEncode(toMap());

  static Watch fromJson(String json) {
    final map = jsonDecode(json);
    return Watch.fromMap(map);
  }
}
