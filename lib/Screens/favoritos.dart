import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Bloc/bloc.dart';
import 'package:filmes_favoritos/Bloc/bloc_favorite.dart';
import 'package:filmes_favoritos/Models/Movie.dart';
import 'package:filmes_favoritos/Screens/MovieShow.dart';
import 'package:flutter/material.dart';

class Favoritos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    var blocSearch = BlocProvider.of<MoviesBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<Map<String, Movie>>(
          stream: bloc.outFav,
          initialData: {},
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.length > 0) {
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                    child: Text("Arraste para o lado para excluir...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal)),
                  ),
                  Column(
                    children: snapshot.data.values.map((v) {
                      return StreamBuilder<Movie>(
                          stream: blocSearch.outMovies,
                          initialData: null,
                          builder: (context, snapshotMovie) {
                            return InkWell(
                              child: Dismissible(
                                resizeDuration: Duration(milliseconds: 500),
                                movementDuration: Duration(seconds: 1),
                                key: Key(DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString()),
                                background: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.delete,
                                                color: Colors.white),
                                            SizedBox(width: 10),
                                            Text("Apagar Favorito...",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))
                                          ],
                                        ))),
                                direction: DismissDirection.startToEnd,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          bottom: 10,
                                          right: 5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.17,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: v.poster == "N/A"
                                          ? Container(
                                              color: Colors.white,
                                              child: Image.asset(
                                                  "lib/images/no_image.png"),
                                            )
                                          : Image.network(v.poster,
                                              fit: BoxFit.fill),
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(v.title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Text(v.plot,
                                            style: TextStyle(
                                                color: Colors.white70),
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis),
                                      ],
                                    ))
                                  ],
                                ),
                                onDismissed: (direction) {
                                  bloc.toggleFavorite(v);
                                  final snack = SnackBar(
                                    content: Text(
                                      "${v.title}, removido!",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.pinkAccent,
                                    duration: Duration(seconds: 4),
                                  );
                                  Scaffold.of(context).showSnackBar(snack);
                                },
                              ),
                              onTap: () {
                                //BlocProvider.of<MoviesBloc>(context).inSearch.add(v.title);
                                if (!snapshotMovie.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => MovieShow(v)));
                                }
                              },
                            );
                          });
                    }).toList(),
                  ),
                ],
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text("No favorites saved...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              );
            }
          }),
    );
  }
} // Favorites
