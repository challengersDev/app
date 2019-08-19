/******************************************************************************** 
    
    CataloguePage

    Реализует логику фильтрации и расположение кнопок фильтра,
    также содержит список упражнений.

 *******************************************************************************/

import 'package:app/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/utils/text.dart';
import 'package:app/view/main/catalogue/exercise_container.dart';
import 'package:app/scoped_models/exercise.dart';

// Одна страничка упражнений
class CataloguePage extends StatefulWidget {
  final int pageNumber;

  CataloguePage(this.pageNumber);

  @override
  State<StatefulWidget> createState() {
    return _CataloguePage();
  }
}

class _CataloguePage extends State<CataloguePage> {
  // Порядковый номер фильтра
  int filterNumber = 0;

  // Показаны ли кнопки фильтрации
  bool _filtersShown = false;

  // Пора ли фильтровать
  bool _timeToFilter = true;

  // Упражнения, выводимые на экран
  List<Exercise> exercises = [];

  Widget _buildExerciseList() {
    Widget exerciseCards;
    if (exercises.length > 0) {
      exerciseCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ExerciseContainer(exercises[index], widget.pageNumber, index),
        itemCount: exercises.length,
      );
    } else {
      exerciseCards = Container(
          child: Center(
        child: BigText(text: 'Нет упражнений'),
      ));
    }
    return exerciseCards;
  }

  Widget _filterButton(MainModel model) {
    return FlatButton(
      child: _filtersShown
          ? MediumText(text: "СБРОСИТЬ")
          : MediumText(text: "ФИЛЬТРЫ"),
      onPressed: () {
        // Фильтр развернут - сброс фильтров
        if (_filtersShown) {
          setState(() {
            model.resetFilters();
          });
          return;
        }
        // Вывод на экран кнопок фильтрации
        setState(() {
          _filtersShown = !_filtersShown;
        });
      },
    );
  }

  Widget _filterButtonsExpandedItem(
      BuildContext context, MainModel model, int position) {
    Filter filter = model.filters.values
        .firstWhere((item) => item.position == position);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: FlatButton(
        child: SmallText(
          text: filter.type,
          color: filterNumber == position ? Colors.red : Colors.black,
        ),
        onPressed: () {
          setState(() {
            filterNumber = position;
          });
        },
      ),
    );
  }

  Widget _filterButtonsExpanded(MainModel model) {
    if (!_filtersShown) {
      return Container();
    }

    return SizedBox(
      // TODO: Рассчет высоты!
      height: model.mediumTextSize * 2.0,
      child: ListView.builder(
        itemBuilder: (context, position) {
          return _filterButtonsExpandedItem(context, model, position);
        },
        itemCount: model.filters.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  // Кнопка развернутого фильтра
  Widget _filterButtonsExpandedToChooseItem(
      BuildContext context, MainModel model, int position) {
    Size screenSize = MediaQuery.of(context).size;
    Filter filter = model.filters.values
        .firstWhere((item) => item.position == filterNumber);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      child: OutlineButton(
        onPressed: () {
          setState(() {
            filter.children[position].active = !filter.children[position].active;
          });
        },
        child: SmallText(
          text: filter.children[position].value,
          color: filter.children[position].active ? Colors.red : Colors.black,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  Widget _filterButtonsExpandedToChoose(MainModel model) {
    if (!_filtersShown) {
      return Container();
    }
    Filter filter = model.filters.values
        .firstWhere((item) => item.position == filterNumber);
    return SizedBox(
      // TODO: Рассчет высоты!
      height: model.mediumTextSize * 2.0,
      child: ListView.builder(
        itemBuilder: (context, position) {
          return _filterButtonsExpandedToChooseItem(context, model, position);
        },
        // нулевой - имя
        itemCount: filter.children.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _filterButtonClose() {
    return (!_filtersShown)
        ? Container()
        : IconButton(
            onPressed: () {
              setState(() {
                _filtersShown = false;
              });
            },
            icon: Icon(Icons.arrow_drop_up),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        // Получение типа тренировки для вывода на странице
        model.pageNumber = widget.pageNumber;
        exercises = model.getExercises(model.pageNumber);
        // TODO: не вызывать каждый раз
        if (_timeToFilter) {
          exercises = exercises;
        }
        int flex = _filtersShown ? model.fltOpenedPcnt : model.fltClosedPcnt;
        return Column(
          children: <Widget>[
            Expanded(
              // Перерасчет распределения места при нажатии фильтра
              flex: flex,
              child: Column(
                children: <Widget>[
                  _filterButton(model), // Только "Фильтр"
                  _filterButtonsExpanded(model), // "Уровень" "Время" ...
                  _filterButtonsExpandedToChoose(
                      model), // "Начальный" "Средний"
                  _filterButtonClose(), // Закрыть фильтр
                ],
              ),
            ),
            Expanded(
              flex: 100 - flex,
              child: _buildExerciseList(),
            )
          ],
        );
      },
    );
  }
}
