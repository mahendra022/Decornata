import 'package:flutter/material.dart';

var color1 = HexColor('#D9158B');
var color2 = HexColor('#707070');
var color3 = HexColor('#CFBC0D');
var color4 = HexColor('#FF50B3');

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
