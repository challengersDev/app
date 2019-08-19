import 'package:flutter/material.dart';
import 'package:app/utils/text.dart';

// Уровень - начальный
Widget _pairContainer(String question, String answer) {
  return Column(children: <Widget>[
    Expanded(flex: 1, child: TinyText(text: question)),
    Expanded(flex: 1, child: SmallText(text: answer))
  ]);
}

// Уровень - время - тип
Widget pairsRow(String firstType, String firstValue, String secondType,
    String secondValue, String thirdType, String thirdValue) {
  return Row(
    children: <Widget>[
      Expanded(flex: 1, child: _pairContainer(firstType, firstValue)),
      Expanded(flex: 1, child: _pairContainer(secondType, secondValue)),
      Expanded(flex: 1, child: _pairContainer(thirdType, thirdValue))
    ],
  );
}