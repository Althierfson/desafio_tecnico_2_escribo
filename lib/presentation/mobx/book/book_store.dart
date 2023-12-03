import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/book/fetch_books.dart';
import 'package:mobx/mobx.dart';

part 'book_store.g.dart';

class BookStore = BookStoreBase with _$BookStore;

abstract class BookStoreBase with Store {
  final FetchBook fetchBook;

  BookStoreBase({required this.fetchBook});

  @observable
  bool isLoading = false;

  @observable
  List<Book> bookList = [];

  @observable
  String? error;

  @action
  Future<void> fetchForBookList() async {
    isLoading = true;
    await fetchBook(NoParamenter()).then((value) => value.fold(
        (failure) => error = failure.message, (success) => bookList = success));
    isLoading = false;
  }
}
