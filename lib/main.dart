/******************************************************************************** 
 
    main.dart

    Инициализация модели данных, настройка темы, вызов первой страницы.
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './scoped_models/main.dart';
//import 'package:app/view/auth_page.dart';
import 'package:app/view/main/main_page.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
    ]);
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: "Challenger's",
        theme: ThemeData(
          primarySwatch: Colors.red
        ),
        home: MainPage(),
      ),
    );
  }
}
