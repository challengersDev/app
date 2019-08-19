/******************************************************************************** 
 
    ProfileContainer

    Контейнер с "вопросом" (пол) и "ответом" (женский).

    Реализует логику изменения пользовательских данных:
    Выбор из списка или ввод числа (проверяется на допустимость)

    TODO: заменить несколько функций на одну (с передачей списка)
   
 *******************************************************************************/

import 'package:app/scoped_models/navigation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/utils/text.dart';
import 'package:app/models/edit_options.dart';
//import 'package:app/page_contents/edit_popup.dart';
import 'package:app/models/user.dart';
import 'package:app/view/main/profile/bordered_container.dart';

class ProfileContainer extends StatefulWidget {
  final String _question;
  final String _answer;
  ProfileContainer(this._question, this._answer);

  @override
  State<StatefulWidget> createState() {
    return _ProfileContainer();
  }
}

Future<Sex> _dialogSex(BuildContext context) async {
  return await showDialog<Sex>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('ВЫБЕРИТЕ ПОЛ'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Sex.MAN);
            },
            child: Text('МУЖСКОЙ'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Sex.WOMAN);
            },
            child: Text('ЖЕНСКИЙ'),
          ),
        ],
      );
    },
  );
}

Future<UserLevel> _dialogLevel(BuildContext context) async {
  return await showDialog<UserLevel>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('ВЫБЕРИТЕ УРОВЕНЬ'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, UserLevel.BEGINNER);
            },
            child: Text('НАЧАЛЬНЫЙ'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, UserLevel.MEDIUM);
            },
            child: Text('СРЕДНИЙ'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, UserLevel.PROFI);
            },
            child: Text('СПОРТСМЕН'),
          ),
        ],
      );
    },
  );
}

Future<BodyType> _dialogBodyType(BuildContext context) async {
  return await showDialog<BodyType>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('ВЫБЕРИТЕ ТИП'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, BodyType.EKTO);
            },
            child: Text('ЭКТОМОРФ'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, BodyType.MESO);
            },
            child: Text('МЕЗОФОРФ'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, BodyType.ENDO);
            },
            child: Text('ЭНДОМОРФ'),
          ),
        ],
      );
    },
  );
}

void _dialogFunction(
    BuildContext context, String question, MainModel model) async {
  // Нет редактирования
  if (model.currentView == CurrentView.PROFILE) {
    return;
  }
  model.createUserCopy();

  switch (question) {
    case "ПОЛ":
      Sex sex = await _dialogSex(context);
      if (sex != null) {
        model.setSex(sex);
      }
      break;
    case "УРОВЕНЬ":
      UserLevel level = await _dialogLevel(context);
      if (level != null) {
        model.setLevel(level);
      }
      break;
    case "ТИП":
      BodyType type = await _dialogBodyType(context);
      if (type != null) {
        model.setBodyType(type);
      }
      break;
    case "ВОЗРАСТ":
    case "РОСТ":
    case "ВЕС":
      int result = await _asyncInputDialog(context, question);
      if (result == -1) {
        break;
      }
      if (question == "ВОЗРАСТ") {
        model.setAge(result);
      } else if (question == "РОСТ") {
        model.setHeight(result);
      } else if (question == "ВЕС") {
        model.setWeight(result);
      }
      break;
  }
}


Future<int> _asyncInputDialog(BuildContext context, String question) async {
  int result = -1;
  return showDialog<int>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: BigText(text: 'ВВЕДИТЕ ' + question),
        content: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    labelText: question, filled: true, fillColor: Colors.white),
                keyboardType: TextInputType.number,
                onChanged: (String string) {
                  result = int.parse(string);
                },
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: MediumText(text: 'OK'),
            onPressed: () {
              Navigator.of(context).pop(result);
            },
          ),
        ],
      );
    },
  );
}

EditType getEditType(String question) {
  switch (question) {
    case "ПОЛ":
      return EditType.SEX;
    case "УРОВЕНЬ":
      return EditType.LEVEL;
    case "ТИП":
      return EditType.TYPE;
    case "ВОЗРАСТ":
    case "РОСТ":
    case "ВЕС":
      break;
  }
  return null;
}

class _ProfileContainer extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            if (model.currentView == CurrentView.PROFILE) {
              return;
            }
            _dialogFunction(context, widget._question, model);
            
            // EditPopup - в следующей версии
            // EditType editType = getEditType(widget._question);

            // // Если необходимо показать диалог
            // if (editType != null) {
            //   showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         content: EditPopup(editType),
            //       );
            //     },
            //   );
            // } else {
            //   _dialogFunction(context, widget._question, model);
            // }
          },
          child: BorderedContainer(child: Column(
              children: <Widget>[
                Center(
                  child: SmallText(
                    text: widget._question,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Center(
                  child: MediumText(
                    text: widget._answer,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
