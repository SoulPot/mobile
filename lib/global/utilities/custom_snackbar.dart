import 'package:flutter/material.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:sizer/sizer.dart';

void snackBarCreator(BuildContext context, String text, Color color) {
  CustomSnackBar(
    context,
    Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: SoulPotTheme.spBlack,
        fontFamily: 'Greenhouse',
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
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
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
