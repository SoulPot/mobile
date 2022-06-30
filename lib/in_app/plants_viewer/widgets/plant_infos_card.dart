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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.w,
      height: 15.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: widget.backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: widget.fontColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse"),
              ),
              Text(
                widget.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp,
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
      ),
    );
  }
}