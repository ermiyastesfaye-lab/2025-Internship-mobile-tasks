// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:task_7/core/error/failures.dart';
import 'package:task_7/core/usecases/usecase.dart';
import 'package:task_7/features/product/domain/entities/product.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';

class GetProducts extends UseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  GetProducts({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
