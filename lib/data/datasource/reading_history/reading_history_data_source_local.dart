import 'dart:convert';

import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReadingHistoryDataSourceLocal {
  Future<List<BookModel>> fetchHistory();
  Future<List<BookModel>> saveHistory(List<BookModel> list);
}

class ReadingHistoryDataSourceLocalImpl
    implements ReadingHistoryDataSourceLocal {
  final SharedPreferences shared;

  ReadingHistoryDataSourceLocalImpl({required this.shared});

  final String _historyKey = "_historyKey";

  @override
  Future<List<BookModel>> fetchHistory() async {
    try {
      final list = shared.getStringList(_historyKey) ?? [];
      return List.from(list.map((e) => BookModel.fromJson(jsonDecode(e))));
    } catch (error) {
      debugPrint(
          "ReadingHistoryDataSourceLocal - Unexpected Error: ${error.toString()}");
      throw LocalDataAccessFailure();
    }
  }

  @override
  Future<List<BookModel>> saveHistory(List<BookModel> list) async {
    try {
      await shared.setStringList(
          _historyKey, List.from(list.map((e) => jsonEncode(e.toJson()))));
      return await fetchHistory();
    } catch (error) {
      debugPrint(
          "ReadingHistoryDataSourceLocal - Unexpected Error: ${error.toString()}");
      throw LocalDataAccessFailure();
    }
  }
}
