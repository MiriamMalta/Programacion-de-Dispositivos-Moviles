import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Blocs
import 'music/auth/bloc/auth_bloc.dart';
import 'music/bloc/song/song_bloc.dart';
import 'music/bloc/favorites/favorites_bloc.dart';

// Pages
import 'music/details_song.dart';
import 'music/favorites.dart';
import 'music/login.dart';
import 'music/music_animation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(VerifyAuthEvent()),
        ),
        BlocProvider(
          create: (context) => SongBloc(),
        ),
        BlocProvider(
          create: (context) => FavoritesBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      routes: {
        "/music_animation": (context) => MusicAnimation(),
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
        "/favorites": (context) => FavoritesS()
      }, 
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Favor de autenticarse"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return MusicAnimation();
          } else if (state is UnAuthState ||
              state is AuthErrorState ||
              state is SignOutSuccessState) {
            return LogIn();
          }
          return Center(
            //child: CircularProgressIndicator()
            child: LoadingAnimationWidget.staggeredDotsWave(
              size: 55,
              color: Color.fromARGB(255, 226, 149, 239),
            ),
          );
        },
      ),//MusicAnimation() DetailsSong() Favorites() HearingMusic()
    );
  }
}
