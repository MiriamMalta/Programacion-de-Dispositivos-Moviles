import 'package:flutter/material.dart';

import 'package:mc_flutter/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade800) ),
      home: HomePage(),
    );
  }
}

