// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';

class DeleteProduct extends UseCase<Product, DeleteParams> {
  final ProductRepository repository;
  DeleteProduct({
    required this.repository,
  });

  @override
  Future<Either<Failure, Product>> call(DeleteParams params) async {
    return await repository.deleteProduct(params.product);
  }
}

class DeleteParams extends Equatable {
  final Product product;

  const DeleteParams({required this.product});

  @override
  List<Object?> get props => [product];
}
