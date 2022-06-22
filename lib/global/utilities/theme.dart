import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SoulPotTheme {

  static const Color SPGreen = Color(0xFF178C23);
  static const Color SPPaleGreen = Color(0xFFB5EF85);
  static const Color SPPurple = Color(0xFF541D72);
  static const Color SPPalePurple = Color(0xFFC9C3E9);
  static const Color SPBackgroundWhite = Color(0xFFF2F2F2);
  static const Color SPBlack = Color(0xFF2F2323);
  static const Color SPPaleRed = Color(0xFFE88587);
  static const Color SPLightGray = Color(0xFFD4D4D4);
  static const Color SPBT = Color(0xFF0082FC);
  static const Color SPRed = Color(0xFFDC2B2B);
  static const Color SPRedPale = Color(0xFFF58D8D);

  static Map<String, Color> luminosityColors = {"Low": Color(0xFF808080), "Good": SPPaleGreen, "High" : Color(0xFFffff4d)};
  static Map<String, Color> temperatureColors = {"Cold": Color(0xFFB1F4E7), "Good": SPPaleGreen, "Hot" : Color(0xFFFF3F34)};
  static Map<String, Color> humidityColors = {"Wet": Color(0xFF4682B4), "Good": SPPaleGreen, "Dry" : Color(0xFFFFE4B5)};

  static const _kFontFam = 'SoulPot';
  static const String? _kFontPkg = null;

  static const IconData water = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData faucet_solid = IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData bucket_solid = IconData(0xe802, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData battery_full = IconData(0xf240, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData battery_half = IconData(0xf242, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData battery_empty = IconData(0xf244, fontFamily: _kFontFam, fontPackage: _kFontPkg);

}
