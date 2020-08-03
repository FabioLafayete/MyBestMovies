import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Bloc/bloc_favorite.dart';
import 'package:filmes_favoritos/Models/Movie.dart';
import 'package:filmes_favoritos/Util/utils.dart';
import 'package:flutter/material.dart';

class inicioAdapter extends StatelessWidget {

  final Movie movie;
  inicioAdapter(this.movie);

  @override
  Widget build(BuildContext context) {

    TextStyle ts = TextStyle(
      color: Colors.white,
      fontSize: 15
    );

    TextStyle tsB = TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.bold
    );

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          movie.poster == "N/A" ?
          Container(
            height: MediaQuery.of(context).size.width * 1.10,
            width: MediaQuery.of(context).size.width * 0.80,
            color: Colors.white,
            child: Image.asset("lib/images/no_image.png", fit:BoxFit.fill),
          ) :
          Container(
            height: MediaQuery.of(context).size.width * 1.10,
            width: MediaQuery.of(context).size.width * 0.80,
            child: Image.network(movie.poster, fit: BoxFit.fill),
          ),
          Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox( //Para alinhar o título no meio...
                    width: MediaQuery.of(context).size.width * 0.09,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 12, right: 1),
                      child: Text(
                        movie.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  StreamBuilder<Map<String, Movie>>(
                    stream: bloc.outFav,
                    initialData: {},
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return IconButton(
                          icon: Icon(snapshot.data.containsKey(movie.title)
                              ? Icons.favorite : Icons.favorite_border
                          ),
                          color: Colors.pinkAccent,
                          iconSize: 30,
                          onPressed: (){
                            bloc.toggleFavorite(movie);
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
              Utils.subTitle("Actor: "),
              Utils.defaultItem(movie.actors),
              SizedBox(height: 10),
              Utils.subTitle("Writer: "),
              Utils.defaultItem(movie.writer),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Year: ",  style: ts),
                        Text(movie.year, style: tsB),
                      ]
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Country: ", style: ts),
                        Text(movie.country, style: tsB)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Director: ",  style: ts),
                          Text(movie.director, style: tsB),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Text(
                  "Synopsis:",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 2, 5),
                child: Text(
                  movie.plot,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  maxLines: 100,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
