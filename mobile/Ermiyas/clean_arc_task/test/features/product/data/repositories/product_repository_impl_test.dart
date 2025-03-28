import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/platform/network_info.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/data/repositories/product_repository_impl.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource])
@GenerateMocks([ProductLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  late ProductRepositoryImpl repository;
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
        networkInfo: mockNetworkInfo,
        productLocalDataSource: mockProductLocalDataSource,
        productRemoteDataSource: mockProductRemoteDataSource);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('Add Product', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    final Product tProduct = tProductModel;

    test('should check if the device is online', () async {
      when(mockProductRemoteDataSource.addProduct(any))
          .thenAnswer((_) async => tProductModel);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await repository.addProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.addProduct(any))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.addProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.addProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.addProduct(tProduct))
              .thenThrow(ServerException());
          // act
          final result = await repository.addProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.addProduct(tProduct));
          verifyZeroInteractions(mockProductLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
  group('Get Products', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    final Product tProduct = tProductModel;
    test('should check if the device is online', () async {
      when(mockProductRemoteDataSource.getProducts())
          .thenAnswer((_) async => [tProduct]);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await repository.getProducts();

      verify(mockNetworkInfo.isConnected);
    });
    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.getProducts())
              .thenAnswer((_) async => [tProduct]);
          // act
          final result = await repository.getProducts();
          // assert
          verify(mockProductRemoteDataSource.getProducts());
          expect(result.getOrElse(() => []), equals([tProduct]));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.getProducts())
              .thenAnswer((_) async => [tProductModel]);
          // act
          await repository.getProducts();
          // assert
          verify(mockProductRemoteDataSource.getProducts());
          verify(mockProductLocalDataSource.cacheProducts([tProductModel]));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.getProducts())
              .thenThrow(ServerException());
          // act
          final result = await repository.getProducts();
          // assert
          verify(mockProductRemoteDataSource.getProducts());
          verifyZeroInteractions(mockProductLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(mockProductLocalDataSource.getLastProducts())
              .thenAnswer((_) async => [tProductModel]);

          final result = await repository.getProducts();

          verifyZeroInteractions(mockProductRemoteDataSource);
          verify(mockProductLocalDataSource.getLastProducts());
          expect(result.getOrElse(() => []), equals([tProductModel]));
        },
      );
    });
  });
  group('Edit Product', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    final Product tProduct = tProductModel;

    test('should check if the device is online', () async {
      when(mockProductRemoteDataSource.editProduct(any))
          .thenAnswer((_) async => tProductModel);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await repository.editProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.editProduct(any))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.editProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.editProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.addProduct(tProduct))
              .thenThrow(ServerException());
          // act
          final result = await repository.addProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.addProduct(tProduct));
          verifyZeroInteractions(mockProductLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
  group('Delete Product', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    final Product tProduct = tProductModel;

    test('should check if the device is online', () async {
      when(mockProductRemoteDataSource.deleteProduct(any))
          .thenAnswer((_) async => tProductModel);
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      await repository.deleteProduct(tProduct);

      verify(mockNetworkInfo.isConnected);
    });
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.deleteProduct(any))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.deleteProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.deleteProduct(tProduct));
          expect(result, equals(Right(tProduct)));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockProductRemoteDataSource.deleteProduct(tProduct))
              .thenThrow(ServerException());
          // act
          final result = await repository.deleteProduct(tProduct);
          // assert
          verify(mockProductRemoteDataSource.deleteProduct(tProduct));
          verifyZeroInteractions(mockProductLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
  });
}
