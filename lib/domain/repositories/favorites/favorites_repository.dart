import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Book>>> fetchFavoritesBooks();
  Future<Either<Failure, List<Book>>> updateFavoritesBooks(List<Book> list);
}
