/******************************************************************************** 
    
    CatalogueBody

    Тело вкладки "упражнения".
    
    Содержит главные типы (mainType) упражнений (свайп) 
    и страницу со списком упражнений текущего типа (CataloguePage)
    TODO: фокус выбранного главного типа.
    TODO: свайп страниц.
  
 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/scoped_models/main.dart';

import 'package:app/view/main/catalogue/cat_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:app/view/main/catalogue/option_button.dart';

class CatalogueBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CatalogueBody();
  }
}

class _CatalogueBody extends State<CatalogueBody> {
  // Возвращает одну из кнопок горизонтальной прокрутки
  Widget getListItem(
      BuildContext context, MainModel model, int position) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      width: screenSize.width / 4, // TODO: размер зависит от данных
      child: OptionButton(
        text: model.mainFilters[position],
        condition: position == model.pageNumber,
        onPressed: () {
          model.swipePage(position);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: model.screenHeight / 40
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return getListItem(
                      context, model, position);
                },
                itemCount: model.mainFilters.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Expanded(flex: 10, child: CataloguePage(model.pageNumber)),
          ],
        );
      },
    );
  }
}
