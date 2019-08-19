/******************************************************************************** 
    
    NavigationModel

    Модель реализует переходы по "страницам" 
    (Замену содержимого страницы: body, buttons, appBar).
    
    Также возвращает необходимое содержимое по запросу
    (getAppBar(), ...)

    В каждой функции перехода вызывается метод notifyListeners()
    для перерисовки содержимого страницы.

 *******************************************************************************/

import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import 'package:app/view/main/catalogue/cat_body.dart';
import 'package:app/view/main/description/descr_body.dart';
import 'package:app/view/main/profile/profile_body.dart';

import 'package:app/view/main/catalogue/cat_button.dart';
import 'package:app/view/main/profile/profile_button.dart';

import 'package:app/view/main/description/descr_appbar.dart';

import '../models/exercise.dart';

enum CurrentView { PROFILE, EDIT, CATALOGUE, DESCRIPTION }

mixin NavigationModel on Model {
  // для перехода по нажатию подвала
  CurrentView currentView = CurrentView.CATALOGUE;

  // для хранения текущей страницы каталог/описание
  // при возврате на профиль/редакт всегда профиль
  CurrentView currentCatView = CurrentView.CATALOGUE;

  // индекс подвала 0 - каталог, 1 - профиль
  int currentIndex = 0;

  // текущая страница
  int pageNumber = 0;

  // Текущая тренировка: данные, тип и индекс
  Exercise _exercise;
  int exerciseIndex = 0;

  Exercise get currentExercise {
    return _exercise;
  }

  // настраивает нужную страницу при нажатии подвала
  void changePage(int index) {
    // переход на страничку каталога или описания упражнения
    if (index == 0 && currentIndex == 1) {
      currentView = currentCatView;
      currentIndex = 0;
    }
    // переход на профиль
    else if (index == 1 && currentIndex == 0) {
      currentView = CurrentView.PROFILE;
      currentIndex = 1;
    }
    notifyListeners();
  }

  void swipePage( int position ) {
    pageNumber = position;
    notifyListeners();
  }

  AppBar getAppBar() {
    
    switch (currentView) {
      case CurrentView.PROFILE:
      case CurrentView.EDIT:
      case CurrentView.CATALOGUE:
        return null;
      // выводить название упражнения
      case CurrentView.DESCRIPTION:
         return descriptionAppBar(_exercise); 
    }
  }

  Widget getBody() {
    switch (currentView) {
      case CurrentView.PROFILE:
      case CurrentView.EDIT:
        return ProfileBody();
      case CurrentView.CATALOGUE:
        return CatalogueBody();
      case CurrentView.DESCRIPTION:
        return DescriptionBody(_exercise);
    }
  }

  Widget getButton() {
    switch (currentView) {
      case CurrentView.PROFILE:
        return ProfileButtons();
      case CurrentView.EDIT:
        return null; 
      case CurrentView.CATALOGUE:
        return CatalogueButton();
      case CurrentView.DESCRIPTION:
        return null;
    }
  }

  //  функция перехода с профиля на редактирование
  void gotoEdit() {
      currentView = CurrentView.EDIT;
      notifyListeners();
  }

    //  функция перехода с профиля на редактирование
  void gotoProfile() {
      currentView = CurrentView.PROFILE;
      notifyListeners();
  }

  bool isProfile() {
    return currentView == CurrentView.PROFILE;
  }

  Future<bool> goBack() {
    gotoCatalogue();
  }

  void gotoCatalogue() {
      currentView = currentCatView = CurrentView.CATALOGUE;
      notifyListeners();
  }

  void gotoDescription(Exercise aExercise,  int aExIndex) {
      // запомнить, на какой странице (каталог или упражнение)
      currentView = currentCatView = CurrentView.DESCRIPTION;
      _exercise = aExercise;
      exerciseIndex = aExIndex;
      notifyListeners();
  }
}
