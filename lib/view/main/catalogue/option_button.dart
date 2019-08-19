/******************************************************************************** 
 
    OptionButton

    Кнопка выбора опций. При фокусе цвет текста красный и меняется обрамление.
   
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/utils/text.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final bool condition;
  final Function onPressed;
  final bool isUnderlined;

  OptionButton(
      {@required this.text,
      @required this.condition,
      @required this.onPressed,
      this.isUnderlined = true});

  BoxDecoration buttonUnderline(bool isChosen) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isChosen ? Colors.red : Colors.grey,
          width: 3.0,
        ),
      ),
    );
  }

  BoxDecoration buttonUpDraw(bool isChosen) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: isChosen ? Colors.red : Colors.white,
          width: 3.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          isUnderlined ? buttonUnderline(condition) : buttonUpDraw(condition),
      child: ButtonTheme(
        minWidth: double.infinity,
        child: FlatButton(
          child: MediumText(text: text, color: condition ? Colors.red : Colors.black),
          onPressed: onPressed, // TODO: Переместить на нее фокус
        ),
      ),
    );
  }
}
