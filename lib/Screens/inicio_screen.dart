import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Bloc/bloc.dart';
import 'package:filmes_favoritos/Adapter/inicio_adapter.dart';
import 'package:filmes_favoritos/Util/Stateless.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {

  bool carregado = false;

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<MoviesBloc>(context);

    return StatefulWrapper(
      onInit: () {
        _getThingsOnStartup().then((value) {
          if(!carregado)
            BlocProvider.of<MoviesBloc>(context).inSearch.add("Spider-Man");
        });
      },
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        body: StreamBuilder(
            stream: bloc.outMovies,
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(
                  backgroundColor: Colors.white)
                );
              } else {
                carregado = true;
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index){
                      return inicioAdapter(snapshot.data);
                    }
                );
              }
            }
        ),
      ),
    );
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
