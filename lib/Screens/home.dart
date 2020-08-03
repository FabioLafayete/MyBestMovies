import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:filmes_favoritos/Bloc/bloc.dart';
import 'package:filmes_favoritos/Screens/inicio_screen.dart';
import 'package:filmes_favoritos/Screens/search.dart';
import 'package:flutter/material.dart';

import 'favoritos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<MoviesBloc>(context);
    final String font = "JosefinSans";

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            page == 0 ? "My Best Movies" : "Favorites",
            style: TextStyle(
                color: Colors.white,
                fontSize: 23, fontFamily: font
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.black,
          actions: <Widget>[
            page == 0 ? IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.pinkAccent,
                size: 28,
              ),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: DataSearch());
                if(result != null){
                  bloc.inSearch.add(result);
                }
              },
            ) : Container()
          ],
        ),
        backgroundColor: Colors.grey[850],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.black54,
              primaryColor: Colors.pinkAccent,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: TextStyle(
                      color: Colors.white38
                  )
              )
          ),
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            currentIndex: page,
            onTap: (p){
              _pageController.animateToPage(
                  p,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease
              );
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text("Favorites")
              )
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (p){
              setState(() {
                page = p;
              });
            },
            controller: _pageController,
            children: <Widget>[
              Inicio(),
              Favoritos()
            ],
          ),
        ),
      ),
    );
  }
}
