import 'package:task_7/features/product/data/models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(ProductModel productToCache);
}
