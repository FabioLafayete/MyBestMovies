import 'dart:convert';
import 'package:filmes_favoritos/Models/Movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements BlocBase {


  Map<String, Movie> _favorites = {};

  final _favController = BehaviorSubject<Map<String, Movie>>();
  Stream<Map<String, Movie>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then(
            (pref){
          if(pref.getKeys().contains("favorites")){
            _favorites = json.decode(pref.getString("favorites")).map(
                    (k, v){
                  return MapEntry(k, Movie.fromJson(v));
                }
            ).cast<String, Movie>();
            _favController.add(_favorites);
          }
        }
    );
  }

  void toggleFavorite(Movie movie){
    if(_favorites.containsKey(movie.title)) _favorites.remove(movie.title);
    else _favorites[movie.title] = movie;
    _favController.sink.add(_favorites);
    _savedFav();
  }

  void _savedFav(){
    SharedPreferences.getInstance().then(
            (pref){
          pref.setString("favorites", json.encode(_favorites));
        }
    );
  }

  @override
  void dispose() {
    _favController.close();

  }

}