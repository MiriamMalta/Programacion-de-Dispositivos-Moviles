import 'package:dart_side/home_page.dart';
import 'package:dart_side/pagina2.dart';
import 'package:dart_side/pagina3.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(
        numero_random: "",
        texto: "",
        emoticon: "",
      ),
      routes: {
        "/homePage": (context) => HomePage(
          numero_random: "",
          texto: "",
          emoticon: "",
        ),
        "/pagina2": (context) => Pagina2(
          numero_random: "",
          texto: "",
          emoticon: "",
        ),
        "/pagina3": (context) => Pagina3(
          numero_random: "",
          texto: "",
          emoticon: "",
        )
      },
    );
  }

}