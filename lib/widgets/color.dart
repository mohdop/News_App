import 'package:flutter/material.dart';
extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

//use example: "6E53F1"

Color? purply = "#6E53F1".toColor();
Color? blacky = "#111B31".toColor();
Color? whitey = "#FEFEFE".toColor();