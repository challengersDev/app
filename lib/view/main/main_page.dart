/******************************************************************************** 
 
    MainPage

    Главная страница. Динамически выбираются заголовок, тело и плавающая кнопка.
    Подвал статичен - переключение каталог/профиль.

 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/scoped_models/main.dart';
import 'package:app/utils/text.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        model.setScreenSize(width, height);
        return Scaffold(
          appBar: model.getAppBar(),
          body: model.getBody(),
          floatingActionButton: model.getButton(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            onTap: (int index) {
              model.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.rowing),
                title: SmallText(text: "Каталог"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity),
                title: SmallText(text: "Профиль"),
              )
            ],
          ),
          // Для устранения ошибки при вводе данных
          // с клавиатуры
          resizeToAvoidBottomPadding: false,
        );
      },
    );
  }
}