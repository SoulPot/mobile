import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SoulPotTheme {

  static const Color spGreen = Color(0xFF178C23);
  static const Color spPaleGreen = Color(0xFFB5EF85);
  static const Color spPurple = Color(0xFF541D72);
  static const Color spPalePurple = Color(0xFFC9C3E9);
  static const Color spBackgroundWhite = Color(0xFFF2F2F2);
  static const Color spBlack = Color(0xFF2F2323);
  static const Color spPaleRed = Color(0xFFE88587);
  static const Color spLightGray = Color(0xFFD4D4D4);
  static const Color spBT = Color(0xFF0082FC);
  static const Color spRed = Color(0xFFDC2B2B);
  static const Color spRedPale = Color(0xFFF58D8D);

  static Map<String, Color> luminosityColors = {"Low": const Color(0xFF808080), "Good": spPaleGreen, "High" : const Color(0xFFffff4d)};
  static Map<String, Color> temperatureColors = {"Cold": const Color(0xFFB1F4E7), "Good": spPaleGreen, "Hot" : const Color(0xFFFF3F34)};
  static Map<String, Color> humidityColors = {"Wet": const Color(0xFF4682B4), "Good": spPaleGreen, "Dry" : const Color(0xFFFFE4B5)};
  static TextStyle codexDataTextStyle = TextStyle(fontFamily: "Greenhouse", fontSize: 10.sp);
}
