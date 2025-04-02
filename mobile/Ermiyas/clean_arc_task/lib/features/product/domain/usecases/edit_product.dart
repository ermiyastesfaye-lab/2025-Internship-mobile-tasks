// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';

class EditProduct extends UseCase<Product, EditParams> {
  final ProductRepository repository;
  EditProduct({
    required this.repository,
  });

  @override
  Future<Either<Failure, Product>> call(EditParams params) async {
    return await repository.editProduct(params.product);
  }
}

class EditParams extends Equatable {
  final Product product;

  const EditParams({required this.product});

  @override
  List<Object?> get props => [product];
}
