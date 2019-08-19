/******************************************************************************** 
 
    StringContainer

 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/utils/text.dart';
import 'package:app/view/main/profile/bordered_container.dart';

class StringContainer extends StatelessWidget {
  final String text;
  final TextSize size;
  StringContainer(this.text, this.size);

  Widget _getTextWidget(String text, TextSize size) {
    switch (size) {
      case TextSize.TINY:
        return TinyText(text: text);
      case TextSize.SMALL:
        return SmallText(text: text);
      case TextSize.MEDIUM:
        return MediumText(text: text);
      case TextSize.BIG:
        return BigText(text: text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: Center(
        child: _getTextWidget(text, size),
      ),
    );
  }
}
