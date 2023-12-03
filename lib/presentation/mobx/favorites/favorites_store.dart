import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/favorites/fetch_favorites_books.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/favorites/update_favorites_books.dart';
import 'package:mobx/mobx.dart';

part 'favorites_store.g.dart';

class FavoritesStore = FavoritesStoreBase with _$FavoritesStore;

abstract class FavoritesStoreBase with Store {
  final FetchFavoritesBooks fetchFavoritesBooks;
  final UpdateFavoritesBooks updateFavoritesBooks;

  FavoritesStoreBase(
      {required this.fetchFavoritesBooks, required this.updateFavoritesBooks});

  @observable
  bool isLoading = false;

  @observable
  List<Book> favoritesList = [];

  @observable
  String? error;

  @action
  Future<void> fetchForBookList() async {
    isLoading = true;
    await fetchFavoritesBooks(NoParamenter()).then((value) => value.fold(
        (failure) => error = failure.message,
        (success) => favoritesList = success));
    isLoading = false;
  }

  @action
  Future<void> addNewFavorite(Book book) async {
    isLoading = true;
    favoritesList.add(book);
    await updateFavoritesBooks(favoritesList).then((value) => value.fold(
        (failure) => error = failure.message,
        (success) => favoritesList = success));
    isLoading = false;
  }

  @action
  Future<void> removeFavorite(Book book) async {
    isLoading = true;
    favoritesList.remove(book);
    await updateFavoritesBooks(favoritesList).then((value) => value.fold(
        (failure) => error = failure.message,
        (success) => favoritesList = success));
    isLoading = false;
  }
}
