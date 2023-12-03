import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/reading_history/fetch_history.dart';
import 'package:desafio_tecnico_2_escribo/domain/usecase/reading_history/save_history.dart';
import 'package:mobx/mobx.dart';

part 'reading_history_store.g.dart';

class ReadingHistoryStore = ReadingHistoryStoreBase with _$ReadingHistoryStore;

abstract class ReadingHistoryStoreBase with Store {
  final FetchHistory fetchHistory;
  final SaveHistory saveHistory;

  ReadingHistoryStoreBase(
      {required this.fetchHistory, required this.saveHistory});

  @observable
  bool isLoading = false;

  @observable
  List<Book> historyList = [];

  @observable
  String? error;

  @action
  Future<void> fetchForHistoryList() async {
    isLoading = true;
    await fetchHistory(NoParamenter()).then((value) => value.fold(
        (failure) => error = failure.message,
        (success) => historyList = success));
    isLoading = false;
  }

  @action
  Future<void> saveHistoryList(Book book) async {
    isLoading = true;
    await saveHistory(
            SaveHistoryParamenter(currentHistory: historyList, newBook: book))
        .then((value) => value.fold((failure) => error = failure.message,
            (success) => historyList = success));
    isLoading = false;
  }
}
