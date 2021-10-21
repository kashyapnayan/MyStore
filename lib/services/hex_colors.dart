import 'package:flutter/material.dart';


///Here We are converting Hex Value for Colors

class HexColor extends Color{
  static int _getColorFromHex(String hexColor){
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if(hexColor.length == 6){
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 6);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

/*
  How to use:
    Color colors1 = HexColor("b74093");
*/