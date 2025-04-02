import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tProductModel = ProductModel(
    '1',
    name: 'Test Product',
    category: 'Test Category',
    price: 10.0,
    description: 'This is a test product',
    imageUrl: 'http://example.com/test-product.jpg',
  );

  const tProductModelWithDefaults = ProductModel(
    '',
    name: 'Unknown',
    category: 'Uncategorized',
    price: 0.0,
    description: 'No description available',
    imageUrl: 'https://via.placeholder.com/150',
  );

  test(
    'should be a subclass of ProductEntity',
    () async {
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test('should return a valid model when JSON is complete', () async {
      // Arrange
      final jsonMap = {
        '_id': '1',
        'name': 'Test Product',
        'category': 'Test Category',
        'price': 10.0,
        'description': 'This is a test product',
        'imageUrl': 'http://example.com/test-product.jpg',
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result, tProductModel);
    });

    test('should return a model with defaults when fields are missing',
        () async {
      // Arrange
      final jsonMap = {
        '_id': null,
        'name': null,
        'category': null,
        'price': null,
        'description': null,
        'imageUrl': null,
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result, tProductModelWithDefaults);
    });

    test('should handle numeric price as double', () async {
      // Arrange
      final jsonMap = {
        '_id': '1',
        'name': 'Test Product',
        'category': 'Test Category',
        'price': 10, // int instead of double
        'description': 'This is a test product',
        'imageUrl': 'http://example.com/test-product.jpg',
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result.price, 10.0);
    });

    test('should handle string price conversion', () async {
      // Arrange
      final jsonMap = {
        '_id': '1',
        'name': 'Test Product',
        'category': 'Test Category',
        'price': '10.5', // string instead of number
        'description': 'This is a test product',
        'imageUrl': 'http://example.com/test-product.jpg',
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result.price, 10.5);
    });

    test('should use default when price is invalid', () async {
      // Arrange
      final jsonMap = {
        '_id': '1',
        'name': 'Test Product',
        'category': 'Test Category',
        'price': 'invalid', // invalid price
        'description': 'This is a test product',
        'imageUrl': 'http://example.com/test-product.jpg',
      };

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result.price, 0.0);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // Act
      final result = tProductModel.toJson();

      // Assert
      final expectedJsonMap = {
        "name": "Test Product",
        "category": "Test Category",
        "price": 10.0,
        "description": "This is a test product",
        "imageUrl": "http://example.com/test-product.jpg"
      };
      expect(result, expectedJsonMap);
    });

    test('should not include id in the JSON map', () async {
      // Act
      final result = tProductModel.toJson();

      // Assert
      expect(result.containsKey('id'), false);
      expect(result.containsKey('_id'), false);
    });
  });

  group('fixture', () {
    test('should parse from fixture correctly', () async {
      // Arrange
      final String jsonString = await fixture('product.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      // Act
      final result = ProductModel.fromJson(jsonMap);

      // Assert
      expect(result.id, '1');
      expect(result.name, 'Test Product');
      expect(result.category, 'Test Category');
      expect(result.price, 10.0);
      expect(result.description, 'This is a test product');
      expect(result.imageUrl, 'http://example.com/test-product.jpg');
    });
  });
}
