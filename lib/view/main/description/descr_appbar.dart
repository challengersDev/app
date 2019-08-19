/******************************************************************************** 
    
    descriptionAppBar

    Название упражнение и флаг избранного
   
 *******************************************************************************/


import 'package:flutter/material.dart';
import 'package:app/view/main/description/button_favorite.dart';
import 'package:app/models/exercise.dart';

AppBar descriptionAppBar( Exercise exercise ) {
  return AppBar(
          leading: Container(),
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Flexible(flex: 1, child: Container(alignment: Alignment.centerLeft)),
              Flexible(flex: 10, child: Container(alignment: Alignment.center, 
              child: Text(
                exercise.title,
                style: TextStyle(color: Colors.black),
              ),),),
              Flexible(flex: 1, child: Container(alignment: Alignment.centerRight, child: ButtonFavorite(exercise)))
            ],
          ),
        );
}