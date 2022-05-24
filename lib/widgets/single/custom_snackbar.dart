import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';

void snackBarCreator(BuildContext context, String text, Color color) {
  CustomSnackBar(
    context,
    Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: SoulPotTheme.SPBlack,
        fontFamily: 'Greenhouse',
        fontSize: 14,
      ),
    ),
    backgroundColor: color,
  );
}

class CustomSnackBar {
  CustomSnackBar(
    BuildContext context,
    Widget content, {
    SnackBarAction? snackBarAction,
    Color backgroundColor = Colors.white,
  }) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor: backgroundColor,

        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
