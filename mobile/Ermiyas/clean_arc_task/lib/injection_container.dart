import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_7/core/network/network_info.dart';
import 'package:task_7/core/util/input_convertor.dart';
import 'package:task_7/features/product/data/datasources/product_local_data_source.dart';
import 'package:task_7/features/product/data/datasources/product_remote_data_source.dart';
import 'package:task_7/features/product/data/repositories/product_repository_impl.dart';
import 'package:task_7/features/product/domain/repositories/product_repository.dart';
import 'package:task_7/features/product/domain/usecases/add_product.dart';
import 'package:task_7/features/product/domain/usecases/delete_product.dart';
import 'package:task_7/features/product/domain/usecases/edit_product.dart';
import 'package:task_7/features/product/domain/usecases/get_products.dart';
import 'package:task_7/features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  //Bloc
  sl.registerFactory(
    () => ProductBloc(
      getProducts: sl(),
      addProduct: sl(),
      editProduct: sl(),
      deleteProduct: sl(),
      inputConverter: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton(() => GetProducts(repository: sl()));
  sl.registerLazySingleton(() => AddProduct(repository: sl()));
  sl.registerLazySingleton(() => EditProduct(repository: sl()));
  sl.registerLazySingleton(() => DeleteProduct(repository: sl()));

  // repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productRemoteDataSource: sl(),
      productLocalDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
