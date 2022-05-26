import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CardInfoPlant extends StatefulWidget {
  const CardInfoPlant(
      {Key? key,
      required this.label,
      required this.value,
      required this.backgroundColor,
      required this.fontColor})
      : super(key: key);
  final String label;
  final String value;
  final Color backgroundColor;
  final Color fontColor;

  @override
  State<CardInfoPlant> createState() => _CardInfoPlantState();
}

class _CardInfoPlantState extends State<CardInfoPlant> {
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 12.5.h,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
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
            ],
          ),
        ),
        color: widget.backgroundColor,
      ),
    );
  }
}
