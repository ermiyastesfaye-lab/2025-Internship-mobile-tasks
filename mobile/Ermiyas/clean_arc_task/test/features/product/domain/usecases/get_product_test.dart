import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';
import 'package:task_7/features/product/domain/usecases/get_products.dart';

import 'add_product_test.mocks.dart';

@GenerateMocks([ProductRepository])
void main() {
  late GetProducts usecase;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = GetProducts(repository: mockProductRepository);
  });

  final tProduct = Product(
    '1',
    name: 'Test Product',
    category: 'Test Category',
    price: 10.0,
    description: 'This is a test product',
    imageUrl: 'http://example.com/test-product.jpg',
  );

  test(
    'should get products from the repository',
    () async {
      when(mockProductRepository.getProducts())
          .thenAnswer((_) async => Right([tProduct]));
      final result = await usecase(NoParams());
      expect(result.getOrElse(() => []), equals([tProduct]));

      verify(mockProductRepository.getProducts());

      verifyNoMoreInteractions(mockProductRepository);
    },
  );
}
