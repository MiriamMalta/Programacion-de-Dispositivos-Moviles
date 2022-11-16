import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/favorites/favorites_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bloc/song/song_bloc.dart';

class DetailsSong extends StatelessWidget {
  final title;
  final artist;
  final release_date;
  final apple;
  final spotify;
  final album;
  final image;
  final song_link;

  const DetailsSong({super.key, 
    required this.title, 
    required this.artist, 
    required this.release_date, 
    required this.apple, 
    required this.spotify, 
    required this.album, 
    required this.image, 
    required this.song_link
  });

  @override
  Widget build(BuildContext context) {
    return _main();
  }

  BlocConsumer<SongBloc, SongState> _main(){
    return BlocConsumer<SongBloc, SongState>(
        listener: (context, SongState state) {
          if (state is SongLoadedState) {
            print("${state.props[0]}");
          }
        },
        builder: (context, SongState state) {
          return Scaffold(
          appBar: AppBar(
            title: Text('Here you go'),
            actions: [
              IconButton(
                onPressed: () {
                  _addToFavorites(context);
                },
                icon: _favorite(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(image),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  album,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  //'Jaymes Young',
                  artist,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                Text(
                  release_date,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.5),
                  )
                ),
                SizedBox(height: 15),
                Divider(thickness: 1, color: Colors.white.withOpacity(0.05),),
                Text(
                  'Abrir con:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                  )
                ),
                SizedBox(height: 15),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            print("${spotify}");
                            _launchURL(Uri.parse(spotify));
                          },
                          child: Image.asset(
                            'assets/spotify_icon.png', 
                            height: 55, 
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("${song_link}");
                            _launchURL(Uri.parse(song_link));
                          },
                          child: Image.asset(
                            'assets/podcast_icon.png', 
                            height: 55, 
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("${apple}");
                            _launchURL(Uri.parse(apple));
                          },
                          child: Image.asset(
                            'assets/apple_icon.png', 
                            height: 45, 
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addToFavorites(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Agregar a favoritos"),
          content: Text("El elemento será agregado a tus favorito ¿Quieres continuar?"),
          actions: [
            TextButton(
              onPressed: () { 
                Navigator.pop(context, 'Cancel');
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.purple.shade200)
              ),
            ),
            TextButton(
              onPressed: () { 
                Navigator.pop(context, 'Cancel');
                BlocProvider.of<FavoritesBloc>(context).add(FavoritesEventAddFrom(
                  title,
                  artist,
                  release_date,
                  apple,
                  spotify,
                  album,
                  image,
                  song_link,
                ));
              },
              child: Text(
                "Continuar",
                style: TextStyle(color: Colors.purple.shade200)
              ),
            ),
          ],
        );
      }
    );
  }

  BlocConsumer<FavoritesBloc, FavoritesState> _favorite() {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesHeartState) {
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text("Procesando..."),
              duration: Duration(seconds: 1),
            ),
          );
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                content: Text("${state.heart}"),
              ),
            );
        } else if (state is FavoritesErrorState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is FavoritesHeartState) {
          return Icon(Icons.favorite, color: Colors.white,);
        } else {
          return Icon(Icons.favorite_border, color: Colors.white,);
        }
      },
    );
  }
}