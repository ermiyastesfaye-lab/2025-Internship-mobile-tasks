import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientResponse(
      {required int statusCode, required String body}) {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(body, statusCode),
    );
    when(mockHttpClient.post(any,
            body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(body, statusCode));
    when(mockHttpClient.put(any,
            body: anyNamed('body'), headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(body, statusCode));
    when(mockHttpClient.delete(any)).thenAnswer(
      (_) async => http.Response(body, statusCode),
    );
  }

  group('getProducts', () {
    test('should return a list of products when the response code is 200',
        () async {
      final jsonString = await fixture('product_cached.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      setUpMockHttpClientResponse(statusCode: 200, body: jsonString);

      final result = await dataSource.getProducts();

      final expectedProducts =
          jsonList.map((json) => ProductModel.fromJson(json)).toList();

      expect(result, equals(expectedProducts));
    });

    test('should throw an exception when the response code is not 200',
        () async {
      setUpMockHttpClientResponse(
          statusCode: 404, body: 'Something went wrong');
      expect(() => dataSource.getProducts(), throwsException);
    });
  });

  group('addProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    test('should return the added product when the response code is 200',
        () async {
      setUpMockHttpClientResponse(
          statusCode: 200, body: json.encode(tProductModel.toJson()));

      final result = await dataSource.addProduct(tProductModel);

      expect(result, equals(tProductModel));
    });

    test('should throw an exception when the response code is not 200',
        () async {
      setUpMockHttpClientResponse(
          statusCode: 400, body: 'Failed to add product');

      expect(() => dataSource.addProduct(tProductModel), throwsException);
    });
  });

  group('editProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Updated Product',
      category: 'Updated Category',
      price: 20.0,
      description: 'This is an updated product',
      imageUrl: 'http://example.com/updated-product.jpg',
    );

    test('should return the updated product when the response code is 200',
        () async {
      setUpMockHttpClientResponse(
          statusCode: 200, body: json.encode(tProductModel.toJson()));

      final result = await dataSource.editProduct(tProductModel);

      expect(result, equals(tProductModel));
    });
  });

  group('deleteProduct', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test Product',
      category: 'Test Category',
      price: 10.0,
      description: 'This is a test product',
      imageUrl: 'http://example.com/test-product.jpg',
    );

    test('should return the deleted product when the response code is 200',
        () async {
      setUpMockHttpClientResponse(
          statusCode: 200, body: json.encode(tProductModel.toJson()));

      final result = await dataSource.deleteProduct(tProductModel);

      expect(result, equals(tProductModel));
    });
  });
}
