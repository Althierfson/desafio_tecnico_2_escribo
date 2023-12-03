// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookStore on BookStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'BookStoreBase.isLoading', context: context);

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

  late final _$bookListAtom =
      Atom(name: 'BookStoreBase.bookList', context: context);

  @override
  List<Book> get bookList {
    _$bookListAtom.reportRead();
    return super.bookList;
  }

  @override
  set bookList(List<Book> value) {
    _$bookListAtom.reportWrite(value, super.bookList, () {
      super.bookList = value;
    });
  }

  late final _$errorAtom = Atom(name: 'BookStoreBase.error', context: context);

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
      AsyncAction('BookStoreBase.fetchForBookList', context: context);

  @override
  Future<void> fetchForBookList() {
    return _$fetchForBookListAsyncAction.run(() => super.fetchForBookList());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
bookList: ${bookList},
error: ${error}
    ''';
  }
}
