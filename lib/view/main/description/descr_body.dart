/******************************************************************************** 
    
    DescriptionBody

    Страница подробного описания упражнения.
    Содержит порядок выполнения и ошибки (свайп).
 
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/scoped_models/exercise.dart';
import 'package:app/models/exercise.dart';
import 'package:app/utils/text.dart';
import 'package:app/utils/widgets.dart';
import 'package:app/view/main/description/video_widget.dart';

class DescriptionBody extends StatefulWidget {
  final Exercise _exercise;
  DescriptionBody(this._exercise);
  @override
  _DescriptionBody createState() => _DescriptionBody();
}

class _DescriptionBody extends State<DescriptionBody> {
  Widget _orderWidget(BuildContext context, int numOnPage, int position) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width / numOnPage,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                widget._exercise.steps[position].image,
                scale: 1.5,
              ),
            ),
            SizedBox(width: 10.0),
            Center(
              child: SmallText(
                text: widget._exercise.steps[position].text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mistakeWidget(BuildContext context, int numOnPage, int position) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width / numOnPage,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                widget._exercise.mistakes[position].image,
                scale: 1.5,
              ),
            ),
            SizedBox(width: 10.0),
            Center(
              child: SmallText(
                text: widget._exercise.mistakes[position].text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // Нахождение вопросов и ответов
        List<ExerciseAttrib> shownTypes = model.exerciseAttribs
            .where((attrib) => attrib.show != ShowOption.HIDE)
            .toList();
        List<String> _questions = [];
        List<String> _answers = [];
        Exercise exercise = model.currentExercise;
        for (int i = 0; i < shownTypes.length; i++) {
          Filter filter = model.filters[shownTypes[i].name];
          _questions.add(filter.type);
          _answers.add(exercise.types[shownTypes[i].name]);
        }
        return WillPopScope(
          onWillPop: model.goBack,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: VideoWidget(),
                ),
                // Container(
                //   padding: EdgeInsets.all(10.0),
                //   child: pairsRow(
                //     _questions[0],
                //     _answers[0],
                //     _questions[1],
                //     _answers[1],
                //     _questions[2],
                //     _answers[2],
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.all(10.0),
                //   child: pairsRow(
                //     _questions[3],
                //     _answers[3],
                //     _questions[4],
                //     _answers[4],
                //     _questions[5],
                //     _answers[5],
                //   ),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: BigText(
                    text: "ОПИСАНИЕ",
                  ),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  child: MediumText(
                    text: widget._exercise.description,
                  ),
                ),

                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: BigText(
                    text: "ПОРЯДОК ВЫПОЛНЕНИЯ",
                  ),
                ),

                // Шаги
                SizedBox(
                  height: model.dscrStepsHeight,
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return _orderWidget(
                          context, model.dscrStepsOnPage, position);
                    },
                    itemCount: model.currentExercise.steps.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: BigText(text: "ЧАСТЫЕ ОШИБКИ"),
                ),

                // Ошибки
                SizedBox(
                  height: model.dscrMistakesHeight,
                  child: ListView.builder(
                    itemBuilder: (context, position) {
                      return _mistakeWidget(
                          context, model.dscrMistakesOnPage, position);
                    },
                    itemCount: model.currentExercise.mistakes.length,
                    scrollDirection: Axis.horizontal,
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
