/******************************************************************************** 
    
    SizesModel

    Данные о размерах.
    
    TODO: рассчет
  
 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';


mixin SizesModel on Model {
  double screenHeight;
  double screenWidth;

  // Размеры текста
  double tinyTextSize;
  double smallTextSize;
  double mediumTextSize;
  double bigTextSize;

  // Соотношения на экране кнопок фильтрации
  int fltClosedPcnt;
  int fltOpenedPcnt;
  
  // Размеры для страницы упражнений
  double exContainerSize;
  double exContainerRadius;
  double exContainerMargin;

  // Размеры для страницы описания
  double dscrStepsHeight;       // Высота шагов
  double dscrMistakesHeight;    // Высота ошибок
  int dscrStepsOnPage;        // Количество шагов на странице
  int dscrMistakesOnPage;        // Количество ошибок на странице  

  // Размеры для страницы каталога
  double prfContainerMargin;
  double prfContainerPadding;
  double prfContainerRadius;
  double prfImageSize;

  // Задание параметров экрана
  void setScreenSize( double w, double h ) {
    screenWidth  = w;
    screenHeight = h;

    //print(screenWidth.toString());
    //print(screenHeight.toString());

    // Размеры текста
    
    bigTextSize = screenHeight / 40;
    mediumTextSize = bigTextSize * 0.8;
    smallTextSize = mediumTextSize * 0.8;
    tinyTextSize = smallTextSize * 0.8;

    // Соотношения на экране кнопок фильтрации
    fltClosedPcnt = 12;
    fltOpenedPcnt = 30;
  
   // Размеры для страницы упражнений
    exContainerSize   = bigTextSize * 6;
    exContainerRadius = 20;
    exContainerMargin = 10;

    // Размеры для страницы описания
    dscrStepsHeight    = exContainerSize * 1.5;    // Высота шагов
    dscrMistakesHeight = exContainerSize * 2;    // Высота ошибок
    dscrStepsOnPage       = 1;        // Количество шагов на странице
    dscrMistakesOnPage    = 3;        // Количество ошибок на странице  

    // Размеры для страницы каталога
    prfContainerMargin  = 5.0;
    prfContainerPadding = 5.0;
    prfContainerRadius  = 5.0;
    prfImageSize        = screenHeight / 8;
  }
}
