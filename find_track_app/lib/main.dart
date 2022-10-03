// https://www.flutterbeads.com/change-app-name-in-flutter/
// https://www.flutterbeads.com/change-app-launcher-icon-flutter/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'music/details_song.dart';
import 'music/favorites.dart';
import 'music/music_animation.dart';
import 'music/bloc/song_bloc.dart';
import 'music/bloc/favorites_bloc.dart';

void main() => runApp(MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => SongBloc(),
    ),
    BlocProvider(
      create: (context) => FavoritesBloc(),
    ),
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: MusicAnimation(),
      routes: {
        "/music_animation": (context) => MusicAnimation(
          
        ),
        "/details_song": (context) => DetailsSong(
          title: "",
          artist: "",
          release_date: "",
          apple: "",
          spotify: "",
          album: "",
          image: "",
          song_link: "",
        ),
        "/favorites": (context) => FavoritesS(
          
        )
      }, //MusicAnimation() DetailsSong() Favorites() HearingMusic()
    );
  }
}
