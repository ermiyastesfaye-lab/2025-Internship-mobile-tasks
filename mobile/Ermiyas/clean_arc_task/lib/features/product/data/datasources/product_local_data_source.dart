import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getLastProducts();

  Future<void> cacheProducts(List<Product> productToCache);
}
