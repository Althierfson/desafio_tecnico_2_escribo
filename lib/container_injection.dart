import 'package:desafio_tecnico_2_escribo/core/network/network_info.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/book/book_data_source_remote.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/favorites/favorites_data_source_local.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/reading_history/reading_history_data_source_local.dart';
import 'package:desafio_tecnico_2_escribo/data/repositories/book/book_repository_impl.dart';
import 'package:desafio_tecnico_2_escribo/data/repositories/favorites/favorites_repository_impl.dart';
import 'package:desafio_tecnico_2_escribo/data/repositories/reading_history/reading_history_repository_impl.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/book/book_repository.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/favorites/favorites_repository.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/reading_history/reading_history_repository.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/book/fetch_books.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/favorites/fetch_favorites_books.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/favorites/update_favorites_books.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/reading_history/fetch_history.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/reading_history/save_history.dart';
import 'package:desafio_tecnico_2_escribo/presentation/mobx/book/book_store.dart';
import 'package:desafio_tecnico_2_escribo/presentation/mobx/favorites/favorites_store.dart';
import 'package:desafio_tecnico_2_escribo/presentation/mobx/reading_history/reading_history_store.dart';
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
  readingHistoryFeature();
  favoritesFeature();
}

void bookFeature() {
  it.registerLazySingleton<BookDataSourceRemote>(
      () => BookDataSourceRemoteImpl(client: it()));

  it.registerLazySingleton<BookRepository>(
      () => BookRepositoryImpl(dataSourceRemote: it(), networkInfo: it()));

  it.registerLazySingleton(() => FetchBook(repository: it()));

  it.registerFactory(() => BookStore(fetchBook: it()));
}

void readingHistoryFeature() {
  it.registerLazySingleton<ReadingHistoryDataSourceLocal>(
      () => ReadingHistoryDataSourceLocalImpl(shared: it()));

  it.registerLazySingleton<ReadingHistoryRepository>(
      () => ReadingHistoryRepositoryImpl(dataSourceLocal: it()));

  it.registerLazySingleton(() => FetchHistory(repository: it()));
  it.registerLazySingleton(() => SaveHistory(repository: it()));

  it.registerFactory(
      () => ReadingHistoryStore(fetchHistory: it(), saveHistory: it()));
}

void favoritesFeature() {
  it.registerLazySingleton<FavoritesDataSourceLocal>(
      () => FavoritesDataSourceLocalImpl(shared: it()));

  it.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(dataSourceLocal: it()));

  it.registerLazySingleton(() => FetchFavoritesBooks(repository: it()));
  it.registerLazySingleton(() => UpdateFavoritesBooks(repository: it()));

  it.registerFactory(() =>
      FavoritesStore(fetchFavoritesBooks: it(), updateFavoritesBooks: it()));
}
