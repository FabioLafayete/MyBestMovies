import 'dart:convert';
import 'package:filmes_favoritos/Models/Movie.dart';
import 'package:http/http.dart' as http;

import '../global.dart';

const API = "http://www.omdbapi.com/?i=${ID}&apikey=${API_KEY}&plot=full&type=movie";

class Api {

  Future<Movie> search(String search) async {
    http.Response response = await http.get(API + "&t=" + search);
    return decodeMovie(response);
  }

  Movie decodeMovie(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      Movie movie = Movie.fromJson(decoded);
      return movie;
    } else {
      throw Exception("Failed to load movies");
    }
  }

}
