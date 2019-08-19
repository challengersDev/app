/******************************************************************************** 
 
    CatalogueButton

    Кнопка избранного в каталоге
    По нажатию тренировки фильтруются.
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';

class CatalogueButton extends StatefulWidget {
  @override
  _CatalogueButton createState() => _CatalogueButton();
}

class _CatalogueButton extends State<CatalogueButton> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: model.enableFavorite,
            child: model.favoriteEnabled
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
          ),
        ),
      );
    });
  }
}
