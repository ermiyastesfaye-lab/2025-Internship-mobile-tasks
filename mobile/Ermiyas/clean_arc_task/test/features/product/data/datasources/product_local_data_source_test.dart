import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/core/error/exceptions.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource =
        ProductLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('ProductLocalDataSource Tests', () {
    test(
      'should return products from SharedPreferences when there is one in the cache',
      () async {
        final jsonString = await fixture('product_cached.json');
        final List<dynamic> jsonList = json.decode(jsonString);
        final tProductModel =
            jsonList.map((product) => ProductModel.fromJson(product));

        when(mockSharedPreferences.getString(any)).thenReturn(jsonString);

        final result = await dataSource.getLastProducts();

        verify(mockSharedPreferences.getString('CACHED_Products'));
        expect(result, equals(tProductModel));
      },
    );
    test('should throw a CacheException when there is not a cached value', () {
      when(mockSharedPreferences.getString(any)).thenReturn(null);

      final call = dataSource.getLastProducts;

      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });
  group('cacheProducts', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    test('should call SharedPreferences to cache the data', () {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      dataSource.cacheProducts([tProductModel]);

      final expectedJsonString = json.encode([tProductModel.toJson()]);

      verify(mockSharedPreferences.setString(
        'CACHED_Products',
        expectedJsonString,
      ));
    });
  });
}
