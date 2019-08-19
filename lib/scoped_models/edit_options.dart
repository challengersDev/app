/******************************************************************************** 
   
    EditOptionsModel

    Описание вкладок редактирования
    В следующей версии.
 
 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';

import '../models/edit_options.dart';
import '../models/user.dart';

mixin EditOptionsModel on Model {
  
  Map<EditType, Map<dynamic, Option> > options;
  
  EditType currentType = EditType.LEVEL;

  // Текущее положение фокуса кнопки
  Map<EditType, int> currentIndexes = Map();

  void fillOptions() {

    options = Map();

    // Заполнение пола
    Map<Sex, Option> sexMap = Map();

    // Мужчина
    Option man = Option();
    man.description = "вы мужчина, ура!";
    man.image = 'assets/images/me.jpg';
    sexMap[Sex.MAN] = man;

    // Женщина
    Option woman = Option();
    woman.description = "вы женщина, неплохо!";
    woman.image = 'assets/images/ro.jpg';
    sexMap[Sex.WOMAN] = woman;

    options[EditType.SEX] = sexMap;

    // Заполнение типа
    Map<BodyType, Option> typeMap = Map();

    // Экзо
    Option ekto = Option();
    ekto.description = "Эктоморф";
    ekto.image = 'assets/images/1.jpg';
    typeMap[BodyType.EKTO] = ekto;

    // Эндо
    Option ento = Option();
    ento.description = "Эндоморф";
    ento.image = 'assets/images/2.jpg';
    typeMap[BodyType.ENDO] = ento;

    // Мезо
    Option meso = Option();
    meso.description = "Мезоморф";
    meso.image = 'assets/images/3.jpg';
    typeMap[BodyType.MESO] = meso;

    options[EditType.TYPE] = typeMap;

    // Заполнение уровня
    Map<UserLevel, Option> levelMap = Map();

    // Начальный
    Option beg = Option();
    beg.description = "Начальный";
    beg.image = 'assets/images/sport.jpg';
    levelMap[UserLevel.BEGINNER] = beg;

    // Средний
    Option mid = Option();
    mid.description = "Средний";
    mid.image = 'assets/images/sport.jpg';
    levelMap[UserLevel.MEDIUM] = mid;

    // Спортсмен
    Option sp = Option();
    sp.description = "Спортсмен";
    sp.image = 'assets/images/sport.jpg';
    levelMap[UserLevel.PROFI] = sp;

    options[EditType.LEVEL] = levelMap;

    // Заполнение текущих индексов подсветки кнопок
    currentIndexes[EditType.LEVEL] = currentIndexes[EditType.TYPE] = currentIndexes[EditType.SEX] = 0;
  }

  int getCurrentIndex() {
    return currentIndexes[currentType];
  }

  void setCurrentIndex( int newIndex ) {
    currentIndexes[currentType] = newIndex;
    notifyListeners();
  }

  void setEditOption( EditType type ) {
    currentType = type;
  }

  Option getEditOption( int position ) {
    switch( currentType ) {
      case EditType.SEX:
        return options[EditType.SEX][Sex.values[position]];
      case EditType.LEVEL:
        return options[EditType.LEVEL][UserLevel.values[position]];
      case EditType.TYPE:
        return options[EditType.TYPE][BodyType.values[position]];
    }
    print('getEditOption returns null');
    return null;
  }
}