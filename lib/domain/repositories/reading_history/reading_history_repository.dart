import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';

abstract class ReadingHistoryRepository {
  Future<Either<Failure, List<Book>>> fetchHistory();
  Future<Either<Failure, List<Book>>> saveHistory(List<Book> list);
}
