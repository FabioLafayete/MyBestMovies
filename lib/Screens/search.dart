import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_)=>close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container();
    } else {
      return FutureBuilder<List>(
        future: suggestions(query),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(snapshot.data[index]),
                    leading: Icon(Icons.movie),
                    onTap: (){
                      close(context, snapshot.data[index]);
                    },
                  );
                }
            );
          }
        },
      );
    }
  }

  Future<List> suggestions(String search) async {
    http.Response response = await http.get(
        "http://omdbapi.com/?i=tt3896198&apikey=38f18c00&type=movie&page=1&s=$search"
    );

    if(response.statusCode == 200){
      return json.decode(response.body)["Search"].map(
              (v){
            return v["Title"];
          }
      ).toList();
    } else {
      return throw Exception("Failed to load Suggestions");
    }

  }

}