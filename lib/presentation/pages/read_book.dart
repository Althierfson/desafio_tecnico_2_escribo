import 'package:desafio_tecnico_2_escribo/core/download/download_epub.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

openEpub(String url) async {
  VocsyEpub.setConfig(
    identifier: "iosBook",
    scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    enableTts: true,
  );

  String path = await DownloadEpub.instance.filePathByUrl(url);

  VocsyEpub.open(
    path,
    lastLocation: EpubLocator.fromJson({
      "bookId": "2239",
      "href": "/OEBPS/ch06.xhtml",
      "created": 1539934158390,
      "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
    }),
  );
}
