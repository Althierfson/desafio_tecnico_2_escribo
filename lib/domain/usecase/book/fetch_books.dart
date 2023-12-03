import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/book/book_repository.dart';

class FetchBook extends UseCase<List<Book>, NoParamenter> {
  final BookRepository repository;

  FetchBook({required this.repository});

  @override
  Future<Either<Failure, List<Book>>> call(NoParamenter paramenter) {
    return repository.fetchBooks();
  }
}
