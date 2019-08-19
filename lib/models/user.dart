/******************************************************************************** 
    
    User

    Тестовая модель пользователя.

 *******************************************************************************/

import 'package:flutter/material.dart';

enum Sex {
  MAN, WOMAN
}

enum UserLevel {
  BEGINNER, MEDIUM, PROFI,
}

// Строение тела
enum BodyType {
  EKTO, ENDO, MESO
}

class User {
  final int      id;            
  String       name;
  String    surname;
  String      email;
  Sex           sex;
  UserLevel   level;
  BodyType bodyType;
  int           age;
  int        weight;
  int        height;
  String      photo;

  User(
      {@required this.id,
      @required this.name,
      @required this.surname,
      @required this.email,
      @required this.sex,
      @required this.level,
      @required this.bodyType,
      @required this.age,
      @required this.weight,
      @required this.height,
      this.photo = "none"});
}