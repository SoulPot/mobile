import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardInfoPlant extends StatefulWidget {
  const CardInfoPlant(
      {Key? key,
      required this.label,
      required this.value,
      required this.backgroundColor,
      required this.fontColor,
      required this.recommendedValue,})
      : super(key: key);
  final String label;
  final String value;
  final Color backgroundColor;
  final Color fontColor;
  final List<int> recommendedValue;

  @override
  State<CardInfoPlant> createState() => _CardInfoPlantState();
}

class _CardInfoPlantState extends State<CardInfoPlant> {
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 14.h,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: widget.fontColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Greenhouse"),
                  ),
                  Text(
                    widget.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: widget.fontColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Greenhouse"),
                  ),
                  Text(
                    "Recommandée : ${widget.recommendedValue[0]} - ${widget.recommendedValue[1]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 9.sp,
                        color: widget.fontColor,
                        fontFamily: "Greenhouse"),
                  ),
                ],
              ),
            ),
            color: widget.backgroundColor,
          ),
        ],
      ),
    );
  }
}
