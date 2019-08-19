/******************************************************************************** 
    
    ProfileBody

    Страница профиля.

 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/view/main/profile/data_container.dart';
import 'package:app/view/main/profile/string_container.dart';
import 'package:app/view/main/profile/icon_container.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/utils/text.dart';
import 'package:app/view/main/edit/edit_buttons.dart';

class ProfileBody extends StatelessWidget {
  Widget _wrapExpanded(Widget widget, Alignment alignment) {
    return Expanded(
      flex: 1,
      child: Container(alignment: alignment, child: widget),
    );
  }

  List<List<Widget>> _fillProfileContainers(MainModel model) {
    List<Widget> _firstRow = [];
    _firstRow.add(_wrapExpanded(
        ProfileContainer("ПОЛ", getSex(model.user.sex)), Alignment.centerLeft));
    _firstRow.add(_wrapExpanded(
        ProfileContainer("УРОВЕНЬ", getLevel(model.user.level)),
        Alignment.center));
    _firstRow.add(_wrapExpanded(
        ProfileContainer("ТИП", getBodyType(model.user.bodyType)),
        Alignment.centerRight));

    List<Widget> _secondRow = [];
    _secondRow.add(_wrapExpanded(
        ProfileContainer(
            "ВОЗРАСТ", model.user.age.toString() + getAgeText(model.user.age)),
        Alignment.centerLeft));
    _secondRow.add(_wrapExpanded(
        ProfileContainer("ВЕС", model.user.weight.toString() + " КГ"),
        Alignment.center));
    _secondRow.add(_wrapExpanded(
        ProfileContainer("РОСТ", model.user.height.toString() + " СМ"),
        Alignment.centerRight));

    List<Widget> _thirdRow = [];
    _thirdRow.add(_wrapExpanded(
        IconContainer(Icon(Icons.account_box)), Alignment.centerLeft));
    _thirdRow.add(
        _wrapExpanded(IconContainer(Icon(Icons.android)), Alignment.center));
    _thirdRow.add(_wrapExpanded(
        IconContainer(Icon(Icons.verified_user)), Alignment.centerRight));

    List<List<Widget>> _profileContainers = [];
    _profileContainers.add(_firstRow);
    _profileContainers.add(_secondRow);
    _profileContainers.add(_thirdRow);
    return _profileContainers;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {

        List<List<Widget>> _containerRows = _fillProfileContainers(model);

        return Column(
          children: <Widget>[
            _wrapExpanded(
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: model.prfImageSize,
                        height: model.prfImageSize,
                        child: Container()//Image.asset(model.user.photo),
                      ),
                      StringContainer(
                          model.user.name + " " + model.user.surname, TextSize.BIG),

                      // Первый ряд
                      Row(children: _containerRows[0]),

                      // Второй ряд
                      Row(children: _containerRows[1]),
                    ],
                  ),
                ),
                Alignment.center),
            _wrapExpanded(
                Container(
                  child: Column(
                    children: <Widget>[
                      // иконки
                      Row(children: _containerRows[2]),

                      // email/pass
                      StringContainer("ПОДТВЕРДИТЬ EMAIL", TextSize.SMALL),
                      StringContainer(model.user.email, TextSize.MEDIUM),
                      StringContainer("ИЗМЕНИТЬ ПАРОЛЬ", TextSize.SMALL),

                      // Кнопки редактирования
                      EditButtons()
                    ],
                  ),
                ),
                Alignment.center),
          ],
        );
      },
    );
  }
}
