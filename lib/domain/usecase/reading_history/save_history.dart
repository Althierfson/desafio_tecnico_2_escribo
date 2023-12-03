import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/reading_history/reading_history_repository.dart';

class SaveHistory extends UseCase<List<Book>, SaveHistoryParamenter> {
  final ReadingHistoryRepository repository;

  SaveHistory({required this.repository});

  /// It only possible save 2 books in your search history
  /// the last element in the list will be discarded
  @override
  Future<Either<Failure, List<Book>>> call(
      SaveHistoryParamenter paramenter) async {
    List<Book> newList = [];
    if (paramenter.currentHistory.isEmpty) {
      newList.add(paramenter.newBook);
    } else {
      if (paramenter.currentHistory.first == paramenter.newBook) {
        return Right(paramenter.currentHistory);
      } else {
        newList.add(paramenter.newBook);
        newList.add(paramenter.currentHistory.first);
      }
    }

    return repository.saveHistory(newList);
  }
}

class SaveHistoryParamenter {
  final List<Book> currentHistory;
  final Book newBook;

  SaveHistoryParamenter({required this.currentHistory, required this.newBook});
}
