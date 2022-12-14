import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:find_track_app/music/utils/secrets.dart';
import 'package:http/http.dart' as http;

class APIRepository {
  static final APIRepository _singleton = APIRepository._internal();

  factory APIRepository() {
    return _singleton;
  }

  APIRepository._internal();

  Future<dynamic> getSong(String path) async { // List<SongModel>
    var request = new http.MultipartRequest('POST', Uri.parse('https://api.audd.io/'));
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      File(path).readAsBytesSync(),
      filename: 'music.m4a',
    ));
    request.fields['api_token'] = APItoken;
    request.fields['return'] = 'apple_music,spotify';
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final res = jsonDecode(responseString);

    if (res['status'] == 'success') {
      if (res['result'] != null) {
        var _musicInfo = res['result'];
        var _title = _musicInfo['title'];
        var _artist = _musicInfo['artist'];
        var _releaseDate = _musicInfo['release_date'];
        var _apple = _musicInfo['apple_music']['url'];
        var _spotify = _musicInfo['spotify']['album']['external_urls']['spotify'];
        var _album = _musicInfo['spotify']['album']['name'];
        var _image = _musicInfo['spotify']['album']['images'][1]['url'];
        var _songLink = _musicInfo['song_link'];
    return {
      'title': _title,
      'artist': _artist,
      'release_date': _releaseDate,
      'apple': _apple,
      'spotify': _spotify,
      'album': _album,
      'image': _image,
      'song_link': _songLink,
    };
      } else {
        return "No se encontró la canción";
      }
    } else {
      return "No se pudo obtener la información";
    }
  }
}