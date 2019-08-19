/******************************************************************************** 
    IconContainer
     
    TODO: iconSize

 *******************************************************************************/

import 'package:flutter/material.dart';
import 'package:app/view/main/profile/bordered_container.dart';

class IconContainer extends StatelessWidget {
  final Icon icon;
  IconContainer(this.icon);
  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: IconButton(
        icon: icon,
        iconSize: 32.0,
        onPressed: () {},
      ),
    );
  }
}
