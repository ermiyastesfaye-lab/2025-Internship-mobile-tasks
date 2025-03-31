import 'package:dartz/dartz.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/network/network_info.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await productRemoteDataSource.addProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource.getProducts();
        final productModels =
            remoteProducts.map((product) => product as ProductModel).toList();
        await productLocalDataSource.cacheProducts(productModels);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await productLocalDataSource.getLastProducts();
        return Right(localProducts);
      } catch (_) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> editProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct =
            await productRemoteDataSource.editProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure()); // Handle offline scenario if needed
    }
  }

  @override
  Future<Either<Failure, Product>> deleteProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct =
            await productRemoteDataSource.deleteProduct(product);
        return Right(remoteProduct);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure()); // Handle offline scenario if needed
    }
  }
}
