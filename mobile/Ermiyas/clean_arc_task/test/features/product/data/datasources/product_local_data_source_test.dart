import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';

import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  const cachedProductsKey = 'CACHED_Products';

  final testProducts = [
    ProductModel(
      '1',
      name: 'Product 1',
      category: 'Category 1',
      price: 10.99,
      description: 'Description 1',
      imageUrl: 'http://test.com/image1.jpg',
    ),
    ProductModel(
      '2',
      name: 'Product 2',
      category: 'Category 2',
      price: 20.99,
      description: 'Description 2',
      imageUrl: 'http://test.com/image2.jpg',
    ),
  ];

  final testProductsJson = json.encode(
    testProducts.map((product) => product.toJson()).toList(),
  );

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastProducts', () {
    test('should return cached products when they exist', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn(testProductsJson);

      // Act
      final result = await dataSource.getLastProducts();

      // Assert
      expect(result, equals(testProducts));
      verify(mockSharedPreferences.getString(cachedProductsKey));
    });

    test('should throw CacheException when no cached products exist', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey)).thenReturn(null);

      // Act & Assert
      expect(
          () => dataSource.getLastProducts(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString(cachedProductsKey));
    });

    test('should throw CacheException when JSON is invalid', () async {
      // Arrange
      when(mockSharedPreferences.getString(cachedProductsKey))
          .thenReturn('invalid json');

      // Act & Assert
      expect(
          () => dataSource.getLastProducts(), throwsA(isA<CacheException>()));
      verify(mockSharedPreferences.getString(cachedProductsKey));
    });
  });

  group('cacheProducts', () {
    test('should cache products successfully', () async {
      // Arrange
      when(mockSharedPreferences.setString(cachedProductsKey, testProductsJson))
          .thenAnswer((_) async => true);

      // Act
      await dataSource.cacheProducts(testProducts);

      // Assert
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        testProductsJson,
      ));
    });

    test('should throw CacheException when caching fails', () async {
      // Arrange
      when(mockSharedPreferences.setString(cachedProductsKey, testProductsJson))
          .thenAnswer((_) async => false);

      // Act & Assert
      expect(
        () => dataSource.cacheProducts(testProducts),
        throwsA(isA<CacheException>()),
      );
      verify(mockSharedPreferences.setString(
        cachedProductsKey,
        testProductsJson,
      ));
    });
  });
}
