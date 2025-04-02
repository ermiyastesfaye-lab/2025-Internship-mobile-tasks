part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductEvent {
  final Product product;

  const AddProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class GetProductsEvent extends ProductEvent {
  const GetProductsEvent();
}

class EditProductEvent extends ProductEvent {
  final Product product;

  const EditProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final Product product;

  const DeleteProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}
