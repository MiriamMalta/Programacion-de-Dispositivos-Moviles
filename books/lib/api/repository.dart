import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class APIRepository {
  static final APIRepository _singleton = APIRepository._internal();

  factory APIRepository() {
    return _singleton;
  }

  APIRepository._internal();

  Future<dynamic> getBooks(String request) async { // List<SongModel>
    var url = Uri.parse('https://www.googleapis.com/books/v1/volumes?q=' + request); //
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['totalItems'] > 0) {
        return jsonResponse['items'];
      } else {
        return 'No se encontraró ningún libro';
      }
    } else {
      return 'Error de conectividad, intente más tarde';
    }
  }
}
