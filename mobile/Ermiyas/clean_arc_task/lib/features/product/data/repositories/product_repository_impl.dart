import 'package:dartz/dartz.dart';
import 'package:task_7/core/error/exceptions.dart';
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

  Future<Either<Failure, Product>> addProduct(Product product) async {
    await networkInfo.isConnected;
    try {
      final remoteproduct = await productRemoteDataSource.addProduct(product);
      return Right(remoteproduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteproduct = await productRemoteDataSource.getProducts();
        productLocalDataSource.cacheProducts(remoteproduct);
        return Right(remoteproduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      final localProduct = await productLocalDataSource.getLastProducts();
      return Right(localProduct);
    }
  }

  Future<Either<Failure, Product>> editProduct(Product product) async {
    networkInfo.isConnected;
    try {
      final remoteproduct = await productRemoteDataSource.editProduct(product);
      return Right(remoteproduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Product>> deleteProduct(Product product) async {
    networkInfo.isConnected;
    try {
      final remoteproduct =
          await productRemoteDataSource.deleteProduct(product);
      return Right(remoteproduct);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
