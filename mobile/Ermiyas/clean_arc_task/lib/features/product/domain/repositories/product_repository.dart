import 'package:dartz/dartz.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> addProduct(Product product);
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> editProduct(Product product);
  Future<Either<Failure, Product>> deleteProduct(Product product);
}
