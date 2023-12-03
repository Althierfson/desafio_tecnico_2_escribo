// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesStore on FavoritesStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'FavoritesStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$favoritesListAtom =
      Atom(name: 'FavoritesStoreBase.favoritesList', context: context);

  @override
  List<Book> get favoritesList {
    _$favoritesListAtom.reportRead();
    return super.favoritesList;
  }

  @override
  set favoritesList(List<Book> value) {
    _$favoritesListAtom.reportWrite(value, super.favoritesList, () {
      super.favoritesList = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'FavoritesStoreBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$fetchForBookListAsyncAction =
      AsyncAction('FavoritesStoreBase.fetchForBookList', context: context);

  @override
  Future<void> fetchForBookList() {
    return _$fetchForBookListAsyncAction.run(() => super.fetchForBookList());
  }

  late final _$addNewFavoriteAsyncAction =
      AsyncAction('FavoritesStoreBase.addNewFavorite', context: context);

  @override
  Future<void> addNewFavorite(Book book) {
    return _$addNewFavoriteAsyncAction.run(() => super.addNewFavorite(book));
  }

  late final _$removeFavoriteAsyncAction =
      AsyncAction('FavoritesStoreBase.removeFavorite', context: context);

  @override
  Future<void> removeFavorite(Book book) {
    return _$removeFavoriteAsyncAction.run(() => super.removeFavorite(book));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
favoritesList: ${favoritesList},
error: ${error}
    ''';
  }
}
