import 'package:app/scoped_models/exercise.dart';
/******************************************************************************** 
 
    ExerciseContainer

    Контейнер, содержащий одно упражнение.

    При нажатии переводит на страничку с соответствующим описанием.
   
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:app/models/exercise.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/utils/text.dart';
import 'package:app/utils/widgets.dart';

class ExerciseContainer extends StatelessWidget {
  final Exercise exercise;
  final int pageNumber;
  final int index;

  ExerciseContainer(this.exercise, this.pageNumber, this.index); 
  
  @override 
  Widget build( BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // Нахождение вопросов и ответов
        List<ExerciseAttrib> shownTypes = model.exerciseAttribs
            .where((attrib) => attrib.show == ShowOption.CTLG_ONLY)
            .toList();
        List<String> _questions = [];
        List<String> _answers = [];
        for (int i = 0; i < shownTypes.length; i++) {
          Filter filter = model.filters[shownTypes[i].name];
          _questions.add(filter.type);
          _answers.add(exercise.types[shownTypes[i].name]);
        }

        return GestureDetector(
          onTap: () {
            model.gotoDescription(exercise, index);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius:
                    BorderRadius.all(Radius.circular(model.exContainerRadius))),
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(
                left: model.exContainerMargin,
                right: model.exContainerMargin,
                bottom: model.exContainerMargin),
            height: model.exContainerSize,
            // ряд - картинка и все остальное
            child: Row(
              children: <Widget>[
                // Картинка
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Image.asset(
                      exercise.image,
                    ),
                  ),
                ),
                // остальное
                Expanded(
                  flex: 4,
                  // колонка - название и остальное

                  child: Column(
                    children: <Widget>[
                      //Название + сердечко
                      Expanded(
                          flex: 1,
                          child: _nameAndHeartRow(
                            exercise.title,
                            model.isFavorite(exercise.id),
                          )),
                      // Пустое место
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 1,
                        child: pairsRow(
                          _questions[0],
                          _answers[0],
                          _questions[1],
                          _answers[1],
                          _questions[2],
                          _answers[2],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buttonFavorite(bool isFavorite) {
    return isFavorite
        ? Icon(
            Icons.favorite,
            color: Colors.red,
          )
        : Center();
  }

  Widget _nameAndHeartRow(String exerciseName, bool isFavorite) {
    return Row(
      children: <Widget>[
        // Пустое место
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 10,
          child: Container(
            alignment: Alignment.topLeft,
            child: BigText(text: exerciseName),
          ),
        ),

        // Сердечко только если избранное
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.topRight,
            child: _buttonFavorite(isFavorite),
          ),
        ),
      ],
    );
  }
}
