import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';

class AddProduct extends UseCase<Product, AddParams> {
  final ProductRepository repository;

  AddProduct({required this.repository});

  @override
  Future<Either<Failure, Product>> call(AddParams params) async {
    return await repository.addProduct(params.product);
  }
}

class AddParams extends Equatable {
  final Product product;

  const AddParams({required this.product});

  @override
  List<Object?> get props => [product];
}
