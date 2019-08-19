/******************************************************************************** 
    
    Exercise

    Описание упражнения.

 *******************************************************************************/

import 'package:flutter/material.dart';

// Порядок выполнения
class ExerciseStep {
  final int exerciseId;     // Привязка к упражнению
  final int id;             // Номер шага
  final String text;
  final String image;
  ExerciseStep({@required this.exerciseId,
                @required this.id,
                @required this.text,
                @required this.image});
}

// Часто возникающие ошибки
class Mistake {
  final int exerciseId;     // Привязка к упражнению
  final int id;             // Номер ошибки - надо ли?
  final String text;
  final String image;
  Mistake({@required this.exerciseId,
           @required this.id,
           @required this.text,
           @required this.image});
}

class Exercise {

  final int id;             // Для привязки к шагам выполнения и ошибкам
  
  // Название и фото упражнения
  final String title;
  final String image;
  
  // Используется для фильтрации
  String mainType;
  Map<String, String> types;

  // Используется на странице описания
  final String     description;

  List<ExerciseStep>       steps;   // Порядок выполнения
  List<Mistake>            mistakes;   // Список ошибок

  bool isFavorite;

  Exercise(
      {@required this.id,
      @required this.title,
      @required this.image,
      @required this.description}) {
        isFavorite = false;
      }
}