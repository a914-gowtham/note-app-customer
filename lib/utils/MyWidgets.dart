import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWidgets{

  static Widget verticalLine(double thickness,{double height=10,Color color}) {
    return Container(
        height: height, child: VerticalDivider(color: color,thickness: thickness,));
  }


}