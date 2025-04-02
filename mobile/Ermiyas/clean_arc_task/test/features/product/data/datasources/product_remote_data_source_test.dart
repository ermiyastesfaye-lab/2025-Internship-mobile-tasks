import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

import 'product_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockClient);
  });

  const baseUrl = "https://internship-ecommerce.onrender.com";

  final testProduct = ProductModel(
    '1',
    name: 'Test Product',
    category: 'Test Category',
    price: 9.99,
    description: 'Test Description',
    imageUrl: 'http://test.com/image.jpg',
  );

  final testProductJson = testProduct.toJson();
  final testProductResponse = json.encode({
    ...testProductJson,
    '_id': testProduct.id,
  });

  final testProductList = [
    {
      '_id': '1',
      'name': 'Product 1',
      'category': 'Category 1',
      'price': 10.99,
      'description': 'Description 1',
      'imageUrl': 'http://test.com/image1.jpg',
    },
    {
      '_id': '2',
      'name': 'Product 2',
      'category': 'Category 2',
      'price': 20.99,
      'description': 'Description 2',
      'imageUrl': 'http://test.com/image2.jpg',
    },
  ];

  group('ProductRemoteDataSourceImpl', () {
    test('should add a product when the response is successful', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('$baseUrl/products'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(testProductResponse, 200));

      // Act
      final result = await dataSource.addProduct(testProduct);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.id, testProduct.id);
      verify(mockClient.post(
        Uri.parse('$baseUrl/products'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should throw an exception when add product fails', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('$baseUrl/products'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(() => dataSource.addProduct(testProduct), throwsException);
    });

    test('should return a list of products when the response is successful',
        () async {
      // Arrange
      when(mockClient.get(Uri.parse('$baseUrl/products'))).thenAnswer(
          (_) async => http.Response(json.encode(testProductList), 200));

      // Act
      final result = await dataSource.getProducts();

      // Assert
      expect(result, isA<List<Product>>());
      expect(result.length, testProductList.length);
      expect(result[0].id, testProductList[0]['_id']);
      verify(mockClient.get(Uri.parse('$baseUrl/products')));
    });

    test('should throw an exception when get products fails', () async {
      // Arrange
      when(mockClient.get(Uri.parse('$baseUrl/products')))
          .thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(() => dataSource.getProducts(), throwsException);
    });

    test('should edit a product when the response is successful', () async {
      // Arrange
      when(mockClient.put(
        Uri.parse('$baseUrl/products/${testProduct.id}'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response(testProductResponse, 200));

      // Act
      final result = await dataSource.editProduct(testProduct);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.id, testProduct.id);
      verify(mockClient.put(
        Uri.parse('$baseUrl/products/${testProduct.id}'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should throw an exception when edit product fails', () async {
      // Arrange
      when(mockClient.put(
        Uri.parse('$baseUrl/products/${testProduct.id}'),
        body: json.encode(testProductJson),
        headers: {'Content-Type': 'application/json'},
      )).thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(() => dataSource.editProduct(testProduct), throwsException);
    });

    test('should delete a product when the response is successful', () async {
      // Arrange
      when(mockClient.delete(Uri.parse('$baseUrl/products/${testProduct.id}')))
          .thenAnswer((_) async => http.Response(testProductResponse, 200));

      // Act
      final result = await dataSource.deleteProduct(testProduct);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.id, testProduct.id);
      verify(
          mockClient.delete(Uri.parse('$baseUrl/products/${testProduct.id}')));
    });

    test('should throw an exception when delete product fails', () async {
      // Arrange
      when(mockClient.delete(Uri.parse('$baseUrl/products/${testProduct.id}')))
          .thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(() => dataSource.deleteProduct(testProduct), throwsException);
    });
  });
}
