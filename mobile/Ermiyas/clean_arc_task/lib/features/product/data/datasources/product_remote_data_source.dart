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
  final String _baseUrl = "https://internship-ecommerce.onrender.com";

  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<Product> addProduct(Product product) async {
    final productModel = ProductModel(
      product.id,
      name: product.name,
      category: product.category,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
    final response = await client.post(Uri.parse("$_baseUrl/products"),
        body: json.encode(productModel.toJson()),
        headers: {'Content-Type': 'application/json'});
    final responseData = jsonDecode(response.body);
    return ProductModel.fromJson({...responseData, 'id': responseData['_id']});
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.get(Uri.parse("$_baseUrl/products"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print(jsonList);
      return jsonList
          .map((json) => ProductModel.fromJson({...json, 'id': json['_id']}))
          .toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  @override
  Future<Product> editProduct(Product product) async {
    final productModel = ProductModel(
      product.id,
      name: product.name,
      category: product.category,
      price: product.price,
      description: product.description,
      imageUrl: product.imageUrl,
    );
    final response = await client.put(
      Uri.parse("$_baseUrl/products/${product.id}"),
      body: json.encode(productModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    final responseData = jsonDecode(response.body);
    return ProductModel.fromJson({...responseData, 'id': responseData['_id']});
  }

  @override
  Future<Product> deleteProduct(Product product) async {
    final response =
        await client.delete(Uri.parse("$_baseUrl/products/${product.id}"));
    final responseData = jsonDecode(response.body);
    return ProductModel.fromJson({...responseData, 'id': responseData['_id']});
  }
}
