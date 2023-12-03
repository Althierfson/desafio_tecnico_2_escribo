import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/core/network/network_info.dart';
import 'package:desafio_tecnico_2_escribo/data/datasource/book/book_data_source_remote.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/domain/repositories/book/book_repository.dart';
import 'package:flutter/material.dart';

class BookRepositoryImpl implements BookRepository {
  final BookDataSourceRemote dataSourceRemote;
  final NetworkInfo networkInfo;

  BookRepositoryImpl(
      {required this.dataSourceRemote, required this.networkInfo});

  @override
  Future<Either<Failure, List<Book>>> fetchBooks() async {
    if (await networkInfo.isConnect) {
      try {
        final list = await dataSourceRemote.fetchBooks();
        return Right(List.from(list.map((e) => e.toEntity())));
      } on Failure catch (failure) {
        return Left(failure);
      } catch (error) {
        debugPrint("BookRepository - Unexpected Error: ${error.toString()}");
        return Left(UnexpectedFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
