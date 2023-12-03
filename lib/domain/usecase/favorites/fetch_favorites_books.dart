import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/favorites/favorites_repository.dart';

class FetchFavoritesBooks extends UseCase<List<Book>, NoParamenter> {
  final FavoritesRepository repository;

  FetchFavoritesBooks({required this.repository});

  @override
  Future<Either<Failure, List<Book>>> call(NoParamenter paramenter) {
    return repository.fetchFavoritesBooks();
  }
}
