import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/favorites/favorites_data_source_local.dart';
import 'package:desafio_tecnico_2_escribo/data/models/book_model.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/favorites/favorites_repository.dart';
import 'package:flutter/material.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesDataSourceLocal dataSourceLocal;

  FavoritesRepositoryImpl({required this.dataSourceLocal});

  @override
  Future<Either<Failure, List<Book>>> fetchFavoritesBooks() async {
    try {
      final listModel = await dataSourceLocal.fetchFavoritesBooks();
      return Right(List.from(listModel.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      debugPrint("FavoritesRepository - Unexpected Error: ${error.toString()}");
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Book>>> updateFavoritesBooks(
      List<Book> list) async {
    try {
      final listModel = await dataSourceLocal.updateFavoritesBooks(
          List.from(list.map((e) => BookModel.fromEntity(e))));
      return Right(List.from(listModel.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      debugPrint("FavoritesRepository - Unexpected Error: ${error.toString()}");
      return Left(UnexpectedFailure());
    }
  }
}
