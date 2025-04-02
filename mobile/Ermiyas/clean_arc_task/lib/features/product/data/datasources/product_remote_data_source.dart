import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<Product> addProduct(Product product);
  Future<List<Product>> getProducts();
  Future<Product> editProduct(Product product);
  Future<Product> deleteProduct(Product product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";

  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Product> addProduct(Product product) async {
    final productModel = ProductModel(
      id: product.id,
      name: product.name,
      category: product.category,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
    final response = await client.post(Uri.parse("$_baseUrl/posts"),
        body: json.encode(productModel.toJson()),
        headers: {'Content-Type': 'application/json'});
    return ProductModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse("$_baseUrl/posts"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<Product> editProduct(Product product) async {
    product as ProductModel;
    final response = await client.put(
      Uri.parse("$_baseUrl/posts/${product.id}"),
      body: json.encode(product.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return ProductModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<Product> deleteProduct(Product product) async {
    final response =
        await client.delete(Uri.parse("$_baseUrl/posts/$product.id"));
    return ProductModel.fromJson(jsonDecode(response.body));
  }
}
