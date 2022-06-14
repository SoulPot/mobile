import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/theme.dart';

class CardObjective extends StatefulWidget {
  const CardObjective({Key? key,
    required this.label,
    required this.description,
    required this.backgroundColor,
    required this.fontColor,
    required this.objectiveValue,
    required this.stateValue,
  })
      : super(key: key);
  final String label;
  final String description;
  final Color backgroundColor;
  final Color fontColor;
  final int objectiveValue;
  final int stateValue;

  @override
  State<CardObjective> createState() => _CardObjectiveState();
}

class _CardObjectiveState extends State<CardObjective> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 25.h,
      child: Card(
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
                    fontSize: 15.sp,
                    color: widget.fontColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse"),
              ),
              LinearProgressBar(
                maxSteps: widget.objectiveValue,
                progressType: LinearProgressBar.progressTypeLinear, // Use Linear progress
                currentStep: widget.stateValue,
                progressColor: SoulPotTheme.SPPaleGreen,
                backgroundColor: Colors.grey,
                semanticsLabel: "Label",
                semanticsValue: "Value",
              ),
              Text(
                widget.stateValue.toString() + "/" + widget.objectiveValue.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 9.sp,
                    color: widget.fontColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse"),
              ),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11.sp,
                    color: widget.fontColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse"),
              ),

            ],
          ),
        ),
        color: widget.backgroundColor,
      ),
    );
  }

  onChanged() {}
  

}