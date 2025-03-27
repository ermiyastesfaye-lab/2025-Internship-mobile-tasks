import 'package:dartz/dartz.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/platform/network_info.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

class ProductRepositoryImpl {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl(
      {required this.productRemoteDataSource,
      required this.productLocalDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, Product>> addProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> editProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(Product product) {
    throw UnimplementedError();
  }
}
