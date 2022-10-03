import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:music_app/music/api/song_api.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final ht = APIRepository();

  SongBloc() : super(SongInitial()) {
    on<SongEventHear>(_hearSongs); // SongEventHear
  }

  FutureOr<void> _hearSongs(SongEventHear event, Emitter<SongState> emit) async {
      Record _audioRecorder = Record();
      try {
        if(!await _requestMicrophonePermission())
          throw Exception('Permiso denegado');
        emit(SongLoadingState(message: "Escuchando..."));
        await _audioRecorder.start(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          samplingRate: 44100,
        );
        await Future.delayed(Duration(seconds: 5));
        final path = await _audioRecorder.stop();
        print("Regresar de grabar");
        emit(SongSearchingState(message: "Esperando respuesta..."));
        print("Empezar a buscar");
        try {
          if(path != null) {
            Map<String, dynamic> songInfo = await ht.getSong(path);
            print(songInfo);
            if(songInfo.length > 1) {
              emit(SongLoadedState(musicInfo: songInfo));
            } else {
              emit(SongErrorState(error: "No se encontró la canción"));
            }
          }
        } catch (e) {
          print(e.toString());
          emit(SongErrorState(error: "No se encontró la canción"));
        }
      print("Regresar de buscar");
      emit(SongHearSuccessState());
    } catch(e){
      emit(SongErrorState(error: 'No se pudo analizar la canción'));
    }
  } 

  Future<bool> _requestMicrophonePermission() async{
    var permiso = await Permission.microphone.status;
    if(permiso == PermissionStatus.denied)
      await Permission.microphone.request();
    return permiso == PermissionStatus.granted;
  }

}
