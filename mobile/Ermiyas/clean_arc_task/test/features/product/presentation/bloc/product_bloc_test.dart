import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/usecases/usecase.dart'; // Import NoParams
import 'package:task_7/core/util/input_convertor.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/usecases/add_product.dart';
import 'package:task_7/features/product/domain/usecases/delete_product.dart';
import 'package:task_7/features/product/domain/usecases/edit_product.dart';
import 'package:task_7/features/product/domain/usecases/get_products.dart';
import 'package:task_7/features/product/presentation/bloc/product_bloc.dart';

import 'product_bloc_test.mocks.dart';

@GenerateMocks(
    [AddProduct, GetProducts, EditProduct, DeleteProduct, InputConverter])
void main() {
  late ProductBloc bloc;
  late MockAddProduct mockAddProduct;
  late MockGetProducts mockGetProducts;
  late MockEditProduct mockEditProduct;
  late MockDeleteProduct mockDeleteProduct;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockAddProduct = MockAddProduct();
    mockEditProduct = MockEditProduct();
    mockDeleteProduct = MockDeleteProduct();
    mockInputConverter = MockInputConverter();

    bloc = ProductBloc(
      addProduct: mockAddProduct,
      getProducts: mockGetProducts,
      editProduct: mockEditProduct,
      deleteProduct: mockDeleteProduct,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be Empty', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetProductsEvent', () {
    final List<Product> testProducts = [
      Product('1',
          name: 'Product 1',
          category: 'Category',
          price: 10.0,
          description: 'Description',
          imageUrl: 'url'),
      Product('2',
          name: 'Product 2',
          category: 'Category',
          price: 20.0,
          description: 'Description',
          imageUrl: 'url'),
    ];

    test(
        'should emit [Loading, ProductsLoaded] when products are fetched successfully',
        () async {
      when(mockGetProducts(NoParams()))
          .thenAnswer((_) async => Right(testProducts));

      final expected = [Loading(), ProductsLoaded(products: testProducts)];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetProductsEvent());
      await untilCalled(mockGetProducts(NoParams()));
    });

    test('should emit [Loading, Error] when getting products fails', () async {
      when(mockGetProducts(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [
        Loading(),
        Error(message: 'Error in fetching products')
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(GetProductsEvent());
      await untilCalled(mockGetProducts(NoParams()));
    });
  });

  group('AddProductEvent', () {
    final Product testProduct = Product('3',
        name: 'Product 3',
        category: 'Category',
        price: 15.0,
        description: 'Description',
        imageUrl: 'url');

    test(
        'should emit [Loading, ProductsLoaded] when product is added successfully',
        () async {
      when(mockAddProduct(AddParams(product: testProduct)))
          .thenAnswer((_) async => Right(testProduct));
      when(mockGetProducts(NoParams()))
          .thenAnswer((_) async => Right([testProduct]));

      final expected = [
        Loading(),
        ProductsLoaded(products: [testProduct])
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(AddProductEvent(product: testProduct));
      await untilCalled(mockAddProduct(any));
    });

    test('should emit [Loading, Error] when adding a product fails', () async {
      when(mockAddProduct(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), Error(message: 'Error in adding product')];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(AddProductEvent(product: testProduct));
      await untilCalled(mockAddProduct(any));
    });
  });

  group('DeleteProductEvent', () {
    final Product testProduct = Product('3',
        name: 'Product 3',
        category: 'Category',
        price: 15.0,
        description: 'Description',
        imageUrl: 'url');

    test(
        'should emit [Loading, ProductsLoaded] when product is deleted successfully',
        () async {
      when(mockDeleteProduct(DeleteParams(product: testProduct)))
          .thenAnswer((_) async => Right(testProduct));
      when(mockGetProducts(NoParams())).thenAnswer((_) async => Right([]));

      final expected = [Loading(), ProductsLoaded(products: [])];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(DeleteProductEvent(product: testProduct));
      await untilCalled(mockDeleteProduct(any));
    });

    test('should emit [Loading, Error] when deleting a product fails',
        () async {
      when(mockDeleteProduct(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), Error(message: "Error in deleting product")];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(DeleteProductEvent(product: testProduct));
      await untilCalled(mockDeleteProduct(any));
    });
  });

  group('EditProductEvent', () {
    final Product updatedProduct = Product('1',
        name: 'Updated Product',
        category: 'Category',
        price: 12.0,
        description: 'Updated',
        imageUrl: 'url');
    final List<Product> existingProducts = [
      Product('1',
          name: 'Product 1',
          category: 'Category',
          price: 10.0,
          description: 'Description',
          imageUrl: 'url'),
      Product('2',
          name: 'Product 2',
          category: 'Category',
          price: 20.0,
          description: 'Description',
          imageUrl: 'url'),
    ];

    test(
        'should emit [Loading, ProductsLoaded] when product is edited successfully',
        () async {
      when(mockEditProduct(EditParams(product: updatedProduct)))
          .thenAnswer((_) async => Right(updatedProduct));
      when(mockGetProducts(NoParams())).thenAnswer((_) async => Right([
            updatedProduct,
            existingProducts.firstWhere((p) => p.id != updatedProduct.id),
          ]));

      final expected = [
        Loading(),
        ProductsLoaded(products: [
          updatedProduct,
          existingProducts.firstWhere((p) => p.id != updatedProduct.id),
        ]),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(EditProductEvent(product: updatedProduct));
      await untilCalled(mockEditProduct(any));
    });

    test('should emit [Loading, Error] when editing a product fails', () async {
      when(mockEditProduct(any)).thenAnswer((_) async => Left(ServerFailure()));

      final expected = [Loading(), Error(message: "Error in updating product")];
      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.add(EditProductEvent(product: updatedProduct));
      await untilCalled(mockEditProduct(any));
    });
  });
}
