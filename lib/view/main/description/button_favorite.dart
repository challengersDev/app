/******************************************************************************** 
 
    ButtonFavorite

    Кнопка избранного.
    По нажатию меняет внешний вид и изменяет модель данных
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/models/exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';

class ButtonFavorite extends StatefulWidget {
  final Exercise exercise;
  ButtonFavorite(this.exercise);
  @override
  State<StatefulWidget> createState() {
    return _ButtonFavorite();
  }
}

class _ButtonFavorite extends State<ButtonFavorite> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
              model.revertFavorite( widget.exercise );
          },
          child: Container(
            margin: EdgeInsets.all(0.0),
            child: Icon(
              model.isFavorite(widget.exercise.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
              //size: 30.0,
            ),
          ),
        );
      },
    );
  }
}
