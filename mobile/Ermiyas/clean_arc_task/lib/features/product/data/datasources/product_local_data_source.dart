import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<ProductModel> productToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProducts() {
    final jsonString = sharedPreferences.getString('CACHED_Products');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final products =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();
      return Future.value(products);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productToCache) {
    final jsonList = productToCache.map((product) => product.toJson()).toList();
    return sharedPreferences.setString(
        'CACHED_Products', json.encode(jsonList));
  }
}
