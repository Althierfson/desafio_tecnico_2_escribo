import 'package:desafio_tecnico_2_escribo/custom_colos.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final bool isfavorite;
  final Function()? onTap;
  final Function()? onLabelTap;
  const BookTile(
      {super.key,
      required this.book,
      required this.isfavorite,
      required this.onTap,
      required this.onLabelTap});

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 32 - 15) / 2;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: width * .5,
              width: width,
              decoration: BoxDecoration(
                  color: CustomColors.lavenderBlue,
                  borderRadius: BorderRadius.circular(15.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  height: width * .8,
                  width: width * .53,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(2, 4),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      image: DecorationImage(
                          image: NetworkImage(book.coverUrl),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * .50, bottom: width * .63),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: IconButton(
                      onPressed: onLabelTap,
                      icon: Icon(
                        Icons.label,
                        color: isfavorite ? Colors.red : Colors.grey,
                        size: width * .25,
                      ))),
            )
          ],
        ),
        SizedBox(
          width: width,
          child: Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.fade,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            book.author,
            maxLines: 1,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
