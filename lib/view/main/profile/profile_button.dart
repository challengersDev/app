/******************************************************************************** 
    
    ProfileButtons

    Кнопка перехода на страницу редактирования

 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';

class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
    return Container(
      child: Align(
        alignment: Alignment.bottomRight,
        
        child: FloatingActionButton(
          onPressed: model.gotoEdit,
          child: Icon(Icons.edit),
        ),
      ),
    );
  },);
  }
}