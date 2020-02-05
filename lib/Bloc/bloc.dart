import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Models/Movie.dart';
import 'package:filmes_favoritos/Util/api.dart';

import 'dart:async';

import 'package:rxdart/rxdart.dart';

class MoviesBloc implements BlocBase {

  Api api;
  Movie movies;
  final _moviesController = BehaviorSubject<Movie>();
  Stream get outMovies => _moviesController.stream;

  final _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  MoviesBloc(){
    api = new Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {

    if(search != null){
      _moviesController.sink.add(null);
      movies = await api.search(search);
    }
    _moviesController.sink.add(movies);
  }


  @override
  void dispose() {
    _moviesController.close();
    _searchController.close();
  }


}