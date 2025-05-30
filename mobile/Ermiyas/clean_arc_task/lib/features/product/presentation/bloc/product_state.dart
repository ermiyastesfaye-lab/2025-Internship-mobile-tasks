part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class Empty extends ProductState {
  const Empty();
}

class Loading extends ProductState {
  const Loading();
}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class Error extends ProductState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
