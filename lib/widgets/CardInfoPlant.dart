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
      height: 12.5.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: widget.fontColor,
                    fontFamily: "Greenhouse"),
              ),
              Text(
                widget.value,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: widget.fontColor,
                    fontFamily: "Greenhouse"),
              ),
              Text(
                "Recommandé : ${widget.recommendedValue[0]} - ${widget.recommendedValue[1]}",
                style: TextStyle(
                    fontSize: 10.sp,
                    color: widget.fontColor,
                    fontFamily: "Greenhouse"),
              ),
            ],
          ),
        ),
        color: widget.backgroundColor,
      ),
    );
  }
}
