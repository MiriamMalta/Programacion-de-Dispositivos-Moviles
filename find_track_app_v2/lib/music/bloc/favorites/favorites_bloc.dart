import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../auth/user_auth_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial()) {
    on<FavoritesEventAddFrom>(_addSongs);
    on<FavoritesDeleteFrom>(_deleteSongs);
    on<FavoritesEventAddTo>(_getSongs);
  }

  //List<dynamic> favoriteSongList = [];

  FutureOr<void> _addSongs(FavoritesEventAddFrom event, Emitter<FavoritesState> emit) async {
    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    print("User uid: $useruid");
    if (useruid == "") {
      return;
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('p2_song')
      .where('useruid', isEqualTo: useruid)
      .get();
    print("Result: ${result.docs.length}");
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      emit(FavoritesErrorState(error: "Usuario no encontrado"));
      return;
    }
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
      List<dynamic> document = documents[0]['favorites'];
      print("document: $document");
      for (var i = 0; i < document.length; i++) {
        print(document[i]['title']);
        if (document[i]['title'] == event.title) {
          emit(FavoritesHeartState(heart: "Este titulo ya se encuentra en favoritos"));
          return;
        }
      }
      await FirebaseFirestore.instance
        .collection('p2_song')
        .doc(useruid)
        .set({
          'favorites': FieldValue.arrayUnion([fav]),
        }, SetOptions(merge: true));
      emit(FavoritesHeartState(heart: "Agregando a favoritos")); 
    } 
    catch (e) {
      emit(FavoritesErrorState(error: "No se pudo agregar la canción a favoritos"));
    }
  } 

  FutureOr<void> _getSongs(FavoritesEventAddTo event, Emitter<FavoritesState> emit) async {
    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    print("User uid: $useruid");
    if (useruid == "") {
      return;
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('p2_song')
      .where('useruid', isEqualTo: useruid)
      .get();
    print("Result: ${result.docs.length}");
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      emit(FavoritesErrorState(error: "Usuario no encontrado"));
      return;
    }
    try {
      emit(FavoritesPutState(favorites: documents[0]['favorites']));
    } 
    catch (e) {
      emit(FavoritesErrorState(error: "No se pudo agregar la canción a favoritos"));
    }
  }

  FutureOr<void> _deleteSongs(FavoritesDeleteFrom event, Emitter<FavoritesState> emit) async {
    String useruid = UserAuthRepository.userInstance?.currentUser?.uid ?? "";
    print("User uid: $useruid");
    if (useruid == "") {
      return;
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
      .collection('p2_song')
      .where('useruid', isEqualTo: useruid)
      .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      emit(FavoritesErrorState(error: "Usuario no encontrado"));
      return;
    }
    try {
      List<dynamic> document = documents[0]['favorites'];
      print("document: $document");
      document.removeWhere((element) => element['title'] == event.title);
      await FirebaseFirestore.instance
        .collection('p2_song')
        .doc(useruid)
        .set({
          'favorites': document,
        }, SetOptions(merge: true));
      print("document: ${documents[0]['favorites']}");
      List<dynamic> newDocument = documents[0]['favorites'];
      newDocument.removeWhere((element) => element['title'] == event.title);
      emit(FavoritesPutState(favorites: newDocument));
    } 
    catch (e) {
      emit(FavoritesErrorState(error: "No se pudo agregar la canción a favoritos"));
    }
  } 

}
