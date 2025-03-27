import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:task_7/core/platform/network_info.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/repositories/product_repository_impl.dart';

import 'product_repository_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource])
@GenerateMocks([ProductLocalDataSource])
@GenerateMocks([NetworkInfo])
void main() {
  ProductRepositoryImpl repository;
  MockProductRemoteDataSource mockProductRemoteDataSource;
  MockProductLocalDataSource mockProductLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
        networkInfo: mockNetworkInfo,
        productLocalDataSource: mockProductLocalDataSource,
        productRemoteDataSource: mockProductRemoteDataSource);
  });
}
