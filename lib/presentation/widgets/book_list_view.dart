import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/presentation/widgets/book_tile.dart';
import 'package:flutter/material.dart';

class BookListView extends StatelessWidget {
  final List<Book> list;
  final Function()? onTapItem;
  final Function()? onTapLabel;
  const BookListView({super.key, required this.list, this.onTapItem, this.onTapLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildGrid(),
    );
  }

  List<Widget> _buildGrid() {
    List<Widget> listWidget = [];
    for (int i = 0; i < list.length; i = i + 2) {
      listWidget.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookTile(
              book: list[i], isfavorite: true, onTap: () {}, onLabelTap: () {}),
          const SizedBox(
            width: 15.0,
          ),
          i + 1 < list.length
              ? BookTile(
                  book: list[i + 1],
                  isfavorite: true,
                  onTap: onTapItem,
                  onLabelTap: onTapLabel)
              : Container()
        ],
      ));
    }
    return listWidget;
  }
}
