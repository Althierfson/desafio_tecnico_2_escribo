import 'dart:convert';

import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/data/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoritesDataSourceLocal {
  Future<List<BookModel>> fetchFavoritesBooks();
  Future<List<BookModel>> updateFavoritesBooks(List<BookModel> list);
}

class FavoritesDataSourceLocalImpl implements FavoritesDataSourceLocal {
  final SharedPreferences shared;

  FavoritesDataSourceLocalImpl({required this.shared});

  final String _favoritesKey = "_favoritesKey";

  @override
  Future<List<BookModel>> fetchFavoritesBooks() async {
    try {
      final list = shared.getStringList(_favoritesKey) ?? [];
      return List.from(list.map((e) => BookModel.fromJson(jsonDecode(e))));
    } catch (error) {
      debugPrint(
          "FavoritesDataSourceLocal - Unexpected Error: ${error.toString()}");
      throw LocalDataAccessFailure();
    }
  }

  @override
  Future<List<BookModel>> updateFavoritesBooks(List<BookModel> list) async {
    try {
      await shared.setStringList(
          _favoritesKey, List.from(list.map((e) => jsonEncode(e))));
      return await fetchFavoritesBooks();
    } catch (error) {
      debugPrint(
          "FavoritesDataSourceLocal - Unexpected Error: ${error.toString()}");
      throw LocalDataAccessFailure();
    }
  }
}
