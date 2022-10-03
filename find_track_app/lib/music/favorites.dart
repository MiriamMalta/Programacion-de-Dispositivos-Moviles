import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/favorites_bloc.dart';
import 'details_song.dart';

class FavoritesS extends StatefulWidget {
  const FavoritesS({super.key});

  @override
  State<FavoritesS> createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesS> {
  List<dynamic> _listSongs = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canciones favoritas'),
      ),
      body: Container(
        child: Column(
          children: [
            //_listArea(context),
            _showFavorites(),
          ],
        ),
      ),
    );
  }

  BlocConsumer<FavoritesBloc, FavoritesState> _showFavorites() {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesInitial) {
        }
        else if (state is FavoritesErrorState) {
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
        print(state);
        if (state is FavoritesPutState) {
          _listSongs = state.favorites;
          print(_listSongs);
          if (_listSongs.length == 0) return _empty(context);
          else return Container(
            child: Column(
              children: [
                _listArea(context),
              ],
            ),
          );
        }
        else {
          return _empty(context);
        }
      },
    );
  }

  Widget _listArea(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.895,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _listSongs.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _openSong(_listSongs[index]);
              },
              child: Container(
                height: 350,
                padding: EdgeInsets.only(top: 8, bottom: 8, right: 30, left:30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          "${_listSongs[index]["image"]}", 
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.white,),
                          onPressed: () {
                            setState(() {
                              _deteteFavorite(_listSongs[index]);
                            });
                          },
                        )
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          color: Colors.blueAccent.shade400.withOpacity(0.9),
                          child: Column(
                            children: [ 
                              Text(
                                "${_listSongs[index]["title"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${_listSongs[index]["artist"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 15,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _empty(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.895,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No hay canciones favoritas",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  void _openSong(dynamic song) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Abrir canción"),
          content: Text("Será redirigido a ver opciones para abrir la canción ¿Quieres continuar?"),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsSong(
                      title: song['title'],
                      artist: song['artist'],
                      release_date: song['release_date'],
                      apple: song['apple'],
                      spotify: song['spotify'],
                      album: song['album'],
                      image: song['image'],
                      song_link: song['song_link'],
                    ),
                  ),
                );
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

  void _deteteFavorite(dynamic song){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Eliminar de favoritos"),
          content: Text("El elemento será eliminado de tus favoritos ¿Quieres continuar?"),
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
                    content: Text("Removiendo de favoritos..."),
                    duration: Duration(seconds: 1),
                  ),
                );
                BlocProvider.of<FavoritesBloc>(context).add(FavoritesDeleteFrom(
                  song['title'],
                  song['artist'],
                  song['release_date'],
                  song['apple'],
                  song['spotify'],
                  song['album'],
                  song['image'],
                  song['song_link'],
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget),
                );
              },
              child: Text(
                "Eliminar",
                style: TextStyle(color: Colors.purple.shade200)
              ),
            ),
          ],
        );
      }
    );
  }

}