import 'package:flutter/material.dart';

import '../tests.dart';
import 'menu_icon_button.dart';
class PopularTestItem extends StatelessWidget{


  final List<Tests> testItem;
  PopularTestItem({this.testItem});

  List<Widget> createWidgetList(){
    List<Widget> buttons = [];
    for(int i=0;i<testItem.length;i++){
       MenuImageButton button = MenuImageButton(
         imageText: testItem[i].testName,
         image: testItem[i].testImage,
         onPress: (){print('One Test pressed');},
       );
       buttons.add(button);
       buttons.add(SizedBox(width: 10.0,));
    }

    return buttons;
  }
  @override
  Widget build(BuildContext context) {

    return Row(
      children: createWidgetList(),
    );
  }
}
