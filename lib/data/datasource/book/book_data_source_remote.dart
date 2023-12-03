import 'dart:convert';

import 'package:desafio_tecnico_2_escribo/core/failure/failures.dart';
import 'package:desafio_tecnico_2_escribo/data/models/book_model.dart';
import 'package:desafio_tecnico_2_escribo/environment.dart';
import 'package:http/http.dart' as http;

abstract class BookDataSourceRemote {
  Future<List<BookModel>> fetchBooks();
}

class BookDataSourceRemoteImpl implements BookDataSourceRemote {
  final http.Client client;

  BookDataSourceRemoteImpl({required this.client});

  @override
  Future<List<BookModel>> fetchBooks() async {
    http.Response response;
    try {
      response =
          await client.get(Uri.parse("${Environment.baseUrl}/books.json"));
    } catch (e) {
      throw AccessServerFailure();
    }

    if (response.statusCode == 200) {
      final list = jsonDecode(utf8.decode(response.bodyBytes));
      return List.from(list.map((e) => BookModel.fromJson(e)));
    } else {
      throw AccessServerFailure();
    }
  }
}
