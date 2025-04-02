import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/core/util/input_convertor.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/usecases/add_product.dart';
import 'package:task_7/features/product/domain/usecases/delete_product.dart';
import 'package:task_7/features/product/domain/usecases/edit_product.dart';
import 'package:task_7/features/product/domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProduct addProduct;
  final GetProducts getProducts;
  final EditProduct editProduct;
  final DeleteProduct deleteProduct;
  final InputConverter inputConverter;

  ProductBloc({
    required this.addProduct,
    required this.getProducts,
    required this.editProduct,
    required this.deleteProduct,
    required this.inputConverter,
  }) : super(Empty()) {
    on<AddProductEvent>(_onAddProduct);
    on<EditProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
    on<GetProductsEvent>(_onGetProducts);
  }

  Future<void> _onAddProduct(
      AddProductEvent event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result = await addProduct.call(AddParams(product: event.product));

    result.fold(
      (failure) => emit(Error(message: 'Error in adding product')),
      (_) => add(GetProductsEvent()),
    );
  }

  Future<void> _onUpdateProduct(
      EditProductEvent event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result = await editProduct.call(EditParams(product: event.product));

    result.fold(
      (failure) => emit(Error(message: 'Error in updating product')),
      (_) => add(GetProductsEvent()),
    );
  }

  Future<void> _onDeleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result =
        await deleteProduct.call(DeleteParams(product: event.product));

    result.fold(
      (failure) => emit(Error(message: 'Error in deleting product')),
      (_) => add(GetProductsEvent()), // Fetch updated products after deleting
    );
  }

  Future<void> _onGetProducts(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(Loading());

    final result = await getProducts.call(NoParams());

    result.fold(
      (failure) => emit(Error(message: 'Error in fetching products')),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }
}
