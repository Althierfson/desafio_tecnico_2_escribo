import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/reading_history/reading_history_data_source_local.dart';
import 'package:desafio_tecnico_2_escribo/data/models/book_model.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/reading_history/reading_history_repository.dart';
import 'package:flutter/material.dart';

class ReadingHistoryRepositoryImpl implements ReadingHistoryRepository {
  final ReadingHistoryDataSourceLocal dataSourceLocal;

  ReadingHistoryRepositoryImpl({required this.dataSourceLocal});

  @override
  Future<Either<Failure, List<Book>>> fetchHistory() async {
    try {
      final list = await dataSourceLocal.fetchHistory();
      return Right(List.from(list.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      debugPrint("BookRepository - Unexpected Error: ${error.toString()}");
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Book>>> saveHistory(List<Book> list) async {
    try {
      final listModel = await dataSourceLocal
          .saveHistory(List.from(list.map((e) => BookModel.fromEntity(e))));
      return Right(List.from(listModel.map((e) => e.toEntity())));
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      debugPrint("ReadingHistoryRepository - Unexpected Error: ${error.toString()}");
      return Left(UnexpectedFailure());
    }
  }
}
