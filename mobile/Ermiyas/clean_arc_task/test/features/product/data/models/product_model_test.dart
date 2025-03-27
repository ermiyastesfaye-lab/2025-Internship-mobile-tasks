import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:task_7/features/product/data/models/product_model.dart';
import 'package:task_7/features/product/domain/entities/product.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    category: 'Test Category',
    price: 10.0,
    description: 'This is a test product',
    imageUrl: 'http://example.com/test-product.jpg',
  );

  test(
    'should be a subclass of ProductEntity',
    () async {
      expect(tProductModel, isA<Product>());
    },
  );

  group('fromJson', () {
    test('should return a valid model', () async {
      final String jsonString = await fixture('product.json');
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      final result = ProductModel.fromJson(jsonMap);
      expect(result, tProductModel);
    });
  });
  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tProductModel.toJson();
      final expectedJsonMap = {
        "id": "1",
        "name": "Test Product",
        "category": "Test Category",
        "price": 10.0,
        "description": "This is a test product",
        "imageUrl": "http://example.com/test-product.jpg"
      };
      expect(result, expectedJsonMap);
    });
  });
}
