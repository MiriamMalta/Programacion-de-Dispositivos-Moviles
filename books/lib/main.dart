import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/book_bloc.dart';
import 'screens/details.dart';
import 'screens/home_page.dart';

void main() => runApp(BlocProvider(
  create: (context) => BookBloc(),
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //colorScheme: ColorScheme.dark(),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromRGBO(66, 66, 66, 1),
        ),
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/details': (context) => Details(
          image: '',
          title: '',
          publishedDate: '',
          description: '',
          pageCount: 0,
        ),
      },
    );
  }
}
