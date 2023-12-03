import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';

class BookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        author: json["author"],
        coverUrl: json["cover_url"],
        downloadUrl: json["download_url"],
      );

  factory BookModel.fromEntity(Book entity) => BookModel(
        id: entity.id,
        title: entity.title,
        author: entity.author,
        coverUrl: entity.coverUrl,
        downloadUrl: entity.downloadUrl,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "author": author,
        "cover_url": coverUrl,
        "download_url": downloadUrl,
      };

  Book toEntity() => Book(
      id: id,
      title: title,
      author: author,
      coverUrl: coverUrl,
      downloadUrl: downloadUrl);
}
