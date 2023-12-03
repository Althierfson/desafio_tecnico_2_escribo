import 'package:desafio_tecnico_2_escribo/container_injection.dart';
import 'package:desafio_tecnico_2_escribo/presentation/pages/book_list_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupContainer();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Estante de Livros',
      home: BookListPage()
    );
  }
}
