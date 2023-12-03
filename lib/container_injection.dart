import 'package:desafio_tecnico_2_escribo/core/network/network_info.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/book/book_data_source_remote.dart';
import 'package:desafio_tecnico_2_escribo/data/repositories/book/book_repository_impl.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/book/book_repository.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/book/fetch_books.dart';
import 'package:desafio_tecnico_2_escribo/presentation/mobx/book/book_store.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final it = GetIt.instance;

Future<void> setupContainer() async {
  // external
  it.registerLazySingleton<http.Client>(() => http.Client());
  final shared = await SharedPreferences.getInstance();
  it.registerLazySingleton<SharedPreferences>(() => shared);
  it.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

  // Iternal
  it.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: it()));

  // features
  bookFeature();
}

void bookFeature() {
  it.registerLazySingleton<BookDataSourceRemote>(
      () => BookDataSourceRemoteImpl(client: it()));

  it.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(dataSourceRemote: it(), networkInfo: it()));

  it.registerLazySingleton(() => FetchBook(repository: it()));

  it.registerFactory(() => BookStore(fetchBook: it()));
}