import 'package:desafio_tecnico_2_escribo/container_injection.dart';
import 'package:desafio_tecnico_2_escribo/core/download/download_epub.dart';
import 'package:desafio_tecnico_2_escribo/custom_colos.dart';
import 'package:desafio_tecnico_2_escribo/domain/entities/book.dart';
import 'package:desafio_tecnico_2_escribo/presentation/mobx/book/book_store.dart';
import 'package:desafio_tecnico_2_escribo/presentation/pages/read_book.dart';

import 'package:desafio_tecnico_2_escribo/presentation/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late BookStore _store;

  @override
  void initState() {
    _store = it<BookStore>();
    _store.fetchForBookList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "O que você vai ler hoje?",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.maximumBluePurple),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Suas Ultimas Leituras",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) => Text("data"),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 15.0,
                    ),
                  ),
                ),
                const Text(
                  "Explore o nosso arcevo",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Estante")),
                    const SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Favoritos"))
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Observer(builder: (context) {
                  if (_store.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return _buildGrid();
                  }
                }),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    List<Widget> listWidget = [];
    for (int i = 0; i < _store.bookList.length; i = i + 2) {
      listWidget.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookTile(
              book: _store.bookList[i],
              isfavorite: true,
              onTap: () {
                _openEpub(_store.bookList[i]);
              },
              onLabelTap: () {}),
          const SizedBox(
            width: 15.0,
          ),
          i + 1 < _store.bookList.length
              ? BookTile(
                  book: _store.bookList[i + 1],
                  isfavorite: true,
                  onTap: () {
                    _openEpub(_store.bookList[i + 1]);
                  },
                  onLabelTap: () {})
              : Container()
        ],
      ));
    }
    return Column(children: listWidget);
  }

  _openEpub(Book book) async {
    final down = DownloadEpub.instance;
    if (await down.epubIsAlreadyDownloaded(book.downloadUrl)) {
      _showBookOption(book);
    } else {
      down.downloadEpub(book.downloadUrl);
      _showLoading();
      down.downloadProgress = (progress) {
        if (progress >= 100) {
          Navigator.pop(context);
          _showBookOption(book);
        }
      };
    }
  }

  _showBookOption(Book book) {
    double width = (MediaQuery.of(context).size.width - 32 - 15) / 2;
    showModalBottomSheet(
      context: context,
      builder: (_) => BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                    const SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width,
                          child: Text(
                            book.title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: Text(
                            book.author,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            openEpub(book.downloadUrl);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.maximumBluePurple),
                          child: const Text(
                            "Ler Epub",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const PopScope(
              canPop: false,
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Baixando Epub... Por favor espere")
                    ],
                  ),
                ),
              ),
            ));
  }
}
