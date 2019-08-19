/******************************************************************************** 
 
    BorderedContainer

    Контейнер, ограниченный рамкой в случае режима редактирования
   
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  BorderedContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget childWidget, MainModel model) {
        return Container(
          margin: EdgeInsets.all(model.prfContainerMargin),
          decoration: BoxDecoration(
            border: Border.all(
                color: model.isProfile() ? Colors.white : Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(model.prfContainerRadius)),
          ),
          padding: EdgeInsets.symmetric(vertical: model.prfContainerPadding),
          child: Wrap(
            children: <Widget>[child],
          ),
        );
      },
    );
  }
}
