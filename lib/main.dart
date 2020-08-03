import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Bloc/bloc.dart';
import 'package:filmes_favoritos/Bloc/bloc_favorite.dart';
import 'package:filmes_favoritos/Screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'My Best Movies',
      theme: ThemeData(
          primaryColor: Colors.black,
          primaryColorDark: Colors.white.withAlpha(240),
          cursorColor: Colors.black,
          primaryIconTheme: IconThemeData(color: Colors.white),
          primarySwatch: black,
      ),
      home: BlocProvider(
        bloc: MoviesBloc(),
          child: BlocProvider(
            bloc: FavoriteBloc(),
              child: Home()
          )
      ),
    );
  }
}

const MaterialColor black = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);
