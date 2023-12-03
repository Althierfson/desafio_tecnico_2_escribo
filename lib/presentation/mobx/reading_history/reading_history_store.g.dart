// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_history_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReadingHistoryStore on ReadingHistoryStoreBase, Store {
  late final _$isLoadingAtom =
      Atom(name: 'ReadingHistoryStoreBase.isLoading', context: context);

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

  late final _$historyListAtom =
      Atom(name: 'ReadingHistoryStoreBase.historyList', context: context);

  @override
  List<Book> get historyList {
    _$historyListAtom.reportRead();
    return super.historyList;
  }

  @override
  set historyList(List<Book> value) {
    _$historyListAtom.reportWrite(value, super.historyList, () {
      super.historyList = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'ReadingHistoryStoreBase.error', context: context);

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

  late final _$fetchForHistoryListAsyncAction = AsyncAction(
      'ReadingHistoryStoreBase.fetchForHistoryList',
      context: context);

  @override
  Future<void> fetchForHistoryList() {
    return _$fetchForHistoryListAsyncAction
        .run(() => super.fetchForHistoryList());
  }

  late final _$saveHistoryListAsyncAction =
      AsyncAction('ReadingHistoryStoreBase.saveHistoryList', context: context);

  @override
  Future<void> saveHistoryList(Book book) {
    return _$saveHistoryListAsyncAction.run(() => super.saveHistoryList(book));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
historyList: ${historyList},
error: ${error}
    ''';
  }
}
