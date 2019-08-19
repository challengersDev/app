/******************************************************************************** 
    
    text.dart

    Вспомогательные функции работы с текстом.

    - функции вывода текста нужного размера
    - функции преобразования имени типа в русскоязычное значение
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import '../models/exercise.dart';
import 'package:app/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';

enum TextSize {
  TINY,
  SMALL,
  MEDIUM,
  BIG
}

class SizedText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  SizedText(
      {@required this.text, @required this.size, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
    );
  }
}

class TinyText extends StatelessWidget {
  final String text;
  final Color color;
  TinyText({@required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SizedText(text: text, size: model.tinyTextSize, color: color);
      },
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  SmallText({@required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SizedText(text: text, size: model.smallTextSize, color: color);
      },
    );
  }
}

class MediumText extends StatelessWidget {
  final String text;
  final Color color;
  MediumText({@required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SizedText(text: text, size: model.mediumTextSize, color: color);
      },
    );
  }
}

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  BigText({@required this.text, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return SizedText(text: text, size: model.bigTextSize, color: color);
      },
    );
  }
}


String getTimeText(int minutes) {
  if (minutes < 5) return "ДО 5 МИН";
  if (5 <= minutes && minutes <= 10) return " 5-10 МИН";
  return "ОТ 10 МИН";
}


String getAgeText(int number) {
  if (number % 10 == 1) {
    return " ГОД";
  }
  if (number % 10 < 5 && number % 10 != 0) {
    return " ГОДА";
  }
  return " ЛЕТ";
}

String getSex(Sex sex) {
  switch (sex) {
    case Sex.MAN:
      return "МУЖСКОЙ";
    case Sex.WOMAN:
      return "ЖЕНСКИЙ";
  }
}

String getLevel(UserLevel level) {
  switch (level) {
    case UserLevel.BEGINNER:
      return "НАЧАЛЬНЫЙ";
    case UserLevel.MEDIUM:
      return "СРЕДНИЙ";
    case UserLevel.PROFI:
      return "СПОРТСМЕН";
  }
}

String getBodyType(BodyType type) {
  switch (type) {
    case BodyType.EKTO:
      return "ЭКТОМОРФ";
    case BodyType.ENDO:
      return "ЭНДОМОРФ";
    case BodyType.MESO:
      return "МЕЗОМОРФ";
  }
}
