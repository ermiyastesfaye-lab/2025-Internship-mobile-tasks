import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';
import 'package:task_7/features/product/domain/usecases/edit_product.dart';

import 'add_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late EditProduct usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = EditProduct(repository: mockProductRepository);
  });

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    category: 'Test Category',
    price: 10.0,
    description: 'This is a test product',
    imageUrl: 'http://example.com/test-product.jpg',
  );

  test(
    'should edit product to the repository',
    () async {
      when(mockProductRepository.editProduct(any))
          .thenAnswer((_) async => Right(tProduct));
      final result = await usecase(EditParams(product: tProduct));
      expect(result, Right(tProduct));

      verify(mockProductRepository.editProduct(tProduct));

      verifyNoMoreInteractions(mockProductRepository);
    },
  );
}
