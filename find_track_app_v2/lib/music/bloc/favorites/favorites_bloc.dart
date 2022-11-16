import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEventAddFrom>(_addSongs);
    on<FavoritesDeleteFrom>(_deleteSongs);
  }

  List<dynamic> favoriteSongList = [];

  FutureOr<void> _addSongs(FavoritesEventAddFrom event, Emitter<FavoritesState> emit) async {
    Map fav = {
      "title": event.title,
      "artist": event.artist,
      "release_date": event.release_date,
      "apple": event.apple,
      "spotify": event.spotify,
      "album": event.album,
      "image": event.image,
      "song_link": event.song_link,
    };
    try {
      print(favoriteSongList.indexWhere((element) => element['title'] == event.title));
      if(favoriteSongList.indexWhere((element) => element['title'] == event.title) == -1) {
        favoriteSongList.add(fav);
        emit(FavoritesHeartState(heart: "Agregando a favoritos")); 
      }
      else {
        emit(FavoritesHeartState(heart: "Este titulo ya se encuentra en favoritos"));
      }   
      FavoritesEventAddTo(favoritesInfo: favoriteSongList);
      emit(FavoritesPutState(favorites: favoriteSongList));
      print(favoriteSongList);
    } 
    catch (e) {
      emit(FavoritesErrorState(error: "No se pudo agregar la canción a favoritos"));
    }
  } 

  FutureOr<void> _deleteSongs(FavoritesDeleteFrom event, Emitter<FavoritesState> emit) async {
    try {
      favoriteSongList.removeWhere((fav) => fav['title'] == event.title);
      emit(FavoritesPutState(favorites: favoriteSongList));
      print(favoriteSongList);
    } 
    catch (e) {
      emit(FavoritesErrorState(error: "No se pudo agregar la canción a favoritos"));
    }
  } 

}
