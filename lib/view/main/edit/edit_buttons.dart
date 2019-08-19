import 'package:app/scoped_models/navigation.dart';
/******************************************************************************** 
    
    EditButtons

    Три кнопки на странице редактирования
    (подтвердить, отменить, выйти)
    и связанная с ними логика.
    При отмене изменений запрашивается подтверждение.
 
 *******************************************************************************/
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/view/main/edit/floating_buttons.dart';

class EditButtons extends StatelessWidget {

  Future<bool> _dialogProve(BuildContext context, String text) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          
          title: Text(text),
          children: <Widget>[
            
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('ДА'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('НЕТ'),
            ),
          ],
        );
      },
    );
  }

  void onDiscard( MainModel model, BuildContext context  ) async {
    bool discard = await _dialogProve(context, "ОТМЕНИТЬ ИЗМЕНЕНИЯ?");
    
    if (discard != null) {
      if (discard) {
        // Откат модели пользователя
        model.revertUser();
        // Установка значений для кнопок
        //model.setInitialValues();
        // Уход с редактирования
        model.gotoProfile(); 
      }
    }  
  }
  
  void onConfirm( MainModel model, BuildContext context  ) {
    model.confirmChanges();
    model.gotoProfile();  
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.currentView != CurrentView.EDIT) {
          return Container();
        }
        return Stack(
          children: <Widget>[
            ConfirmButton(onPressed: () { onConfirm( model, context ); }),
            ExitButton(onPressed: () =>
                      Navigator.pop(context)),
            DiscardButton(onPressed: () { onDiscard( model, context );} )
          ],
        );
      },
    );
  }
}
