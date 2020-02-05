import 'package:flutter/material.dart';
class Utils {

  static defaultItem(
      String text
      ){
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: SizedBox(
        height: 35,
        child: GridView(
            padding: EdgeInsets.all(1),
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                childAspectRatio: 0.25
            ),
            children: text.split(",").map((m){
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.pinkAccent, width: 3)
                ),
                child: Text(m,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
              );
            }).toList()
        ),
      ),
    );

  }

  static subTitle(
      String text
      ){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

}