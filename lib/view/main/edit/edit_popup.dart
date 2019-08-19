/******************************************************************************** 
    
    EditPopup

    Всплывающее меню выбора при редактировании профиля.
    В разработке.
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/view/main/edit/floating_buttons.dart';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/models/edit_options.dart';
import 'package:app/view/main/catalogue/option_button.dart';
import 'package:app/utils/text.dart';
import 'package:app/models/user.dart';

class EditPopup extends StatefulWidget {
  final EditType _editType;
  int _optionsQuan;

  int _getOptionsQuan() {
    switch (_editType) {
      case EditType.SEX:
        return 2;
      case EditType.LEVEL:
      case EditType.TYPE:
        return 3;
    }
    return 0;
  }

  EditPopup(this._editType) {
    _optionsQuan = _getOptionsQuan();
  }

  @override
  State<StatefulWidget> createState() {
    return _EditPopup();
  }
}

class _EditPopup extends State<EditPopup> {

  void _changeChosen( MainModel model, int position) {
      model.setCurrentIndex(position);
  }

  String _getEditTitle(MainModel model, int position) {
    switch (widget._editType) {
      case EditType.SEX:
        Sex value = Sex.values[position];
        return getSex(value);
      case EditType.LEVEL:
        UserLevel value = UserLevel.values[position];
        return getLevel(value);
      case EditType.TYPE:
        BodyType value = BodyType.values[position];
        return getBodyType(value);
    }
    return null;
  }

  // Возвращает одну из кнопок горизонтальной прокрутки
  Widget _getListItem(BuildContext context, MainModel model, int position) {
    return Expanded(
      flex: 1,
      child: Container(
        width: model.screenWidth / widget._optionsQuan,
        child: Column(
          children: <Widget>[
            OptionButton(
              text: _getEditTitle(model, position),
              condition: model.getCurrentIndex() == position,
              onPressed: () {
                _changeChosen(model, position);
              },
              isUnderlined: false,
            ),
            Opacity(
              opacity: model.getCurrentIndex() == position ? 1.0 : 0.5,
              child: Image.asset(
                model.getEditOption(position).image,
                width: model.screenWidth / widget._optionsQuan,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionText(MainModel model) {
    return Center(
      child: SmallText(text: model.getEditOption(model.getCurrentIndex()).description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        List<Widget> row = [];

        // Для выбора, какие опции выводить
        model.setEditOption(widget._editType);

        for (int i = 0; i < widget._optionsQuan; i++) {
          row.add(_getListItem(context, model, i));
        }
        return Container(
          height: model.screenHeight / 2,
          width:  model.screenWidth,
          child: Column(
            children: <Widget>[
              Row(
                children: row,
              ),
              _descriptionText(model),
              Container(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: <Widget>[
                    ConfirmButton(onPressed: () { _onConfirmed(model); }),
                    DiscardButton(onPressed: () => Navigator.pop(context))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onConfirmed( MainModel model ) {
    //model.setValue(model.getCurrentIndex());
    Navigator.pop(context);
  }
}
