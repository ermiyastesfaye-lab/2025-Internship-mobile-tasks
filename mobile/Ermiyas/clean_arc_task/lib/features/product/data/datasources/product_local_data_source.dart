import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<ProductModel> productToCache);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  static const String cachedProductsKey = 'CACHED_Products';

  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<ProductModel>> getLastProducts() async {
    final String? jsonString = sharedPreferences.getString(cachedProductsKey);
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString) as List<dynamic>;
        return jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        throw CacheException();
      }
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> productToCache) async {
    final List<Map<String, dynamic>> jsonList =
        productToCache.map((product) => product.toJson()).toList();
    final String jsonString = jsonEncode(jsonList);
    final success =
        await sharedPreferences.setString(cachedProductsKey, jsonString);
    if (!success) {
      throw CacheException();
    }
  }
}
