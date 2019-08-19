/******************************************************************************** 
 
    FloatingButtons

    Всплывающие кнопки внизу экрана.

    - CustomButton - базовая кнопка, отвечает за тип, расположение, функционал кнопки.

    - ConfirmButton, DiscardButton, ExitButton - подтипы.
   
 *******************************************************************************/

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String   heroTag;
  final Alignment alignment;
  final Widget child;
  final Color color;
  CustomButton({@required this.onPressed,
                @required this.heroTag,
                @required this.alignment,
                @required this.color,
                @required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
              child: Align(
                alignment: alignment,
                child: FloatingActionButton(
                  heroTag: heroTag, // заглушка от исключений
                  onPressed: onPressed,
                  child: child,
                  backgroundColor: color,
                ),
              ),
            );
  }  
}

class ConfirmButton extends StatelessWidget {
  final Function onPressed;
  ConfirmButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButton(alignment: Alignment.bottomRight,
                        onPressed: onPressed,
                        heroTag: "1",
                        color: Colors.green,
                        child: Icon(Icons.offline_pin),);
  }
}

class DiscardButton extends StatelessWidget {
  final Function onPressed;
  DiscardButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButton(alignment: Alignment.bottomLeft,
                        onPressed: onPressed,
                        heroTag: "2",
                        color: Colors.red,
                        child: Icon(Icons.exit_to_app),);
  }
}

class ExitButton extends StatelessWidget {
  final Function onPressed;
  ExitButton({@required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return CustomButton(alignment: Alignment.bottomCenter,
                        onPressed: onPressed,
                        heroTag: "3",
                        color: Colors.white,
                        child: Text("ВЫЙТИ", style: TextStyle(color: Colors.black),),);
  }
}