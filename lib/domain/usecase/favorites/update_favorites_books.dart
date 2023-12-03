import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/favorites/favorites_repository.dart';

class UpdateFavoritesBooks extends UseCase<List<Book>, List<Book>> {
  final FavoritesRepository repository;

  UpdateFavoritesBooks({required this.repository});

  @override
  Future<Either<Failure, List<Book>>> call(List<Book> paramenter) {
    return repository.updateFavoritesBooks(paramenter);
  }
}
