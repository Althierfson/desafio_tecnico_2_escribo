import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/reading_history/reading_history_repository.dart';

class FetchHistory extends UseCase<List<Book>, NoParamenter> {
  final ReadingHistoryRepository repository;

  FetchHistory({required this.repository});

  @override
  Future<Either<Failure, List<Book>>> call(NoParamenter paramenter) {
    return repository.fetchHistory();
  }
}
