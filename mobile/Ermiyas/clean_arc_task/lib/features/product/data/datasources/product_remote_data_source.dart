import 'package:task_7/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<Product> addProduct(Product product);
  Future<List<Product>> getProducts();
  Future<Product> editProduct(Product product);
  Future<Product> deleteProduct(Product product);
}
