import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/Objective.dart';
import 'package:soulpot/theme.dart';

class CardObjective extends StatefulWidget {
  const CardObjective(Objective objective, {Key? key})
      : this.objective = objective,
        super(key: key);
  final Objective objective;

  @override
  State<CardObjective> createState() => _CardObjectiveState();
}

class _CardObjectiveState extends State<CardObjective> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 25.h,
      child: GestureDetector(
        onTap: () => {},
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
                  widget.objective.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: widget.objective.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Greenhouse"),
                ),
                widget.objective.owned == false ? displayProgressBar() : Container(width: 0, height: 0,),
                Text(
                  widget.objective.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: widget.objective.fontColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Greenhouse"),
                ),
              ],
            ),
          ),
          color: widget.objective.backgroundColor,
        ),
      ),
    );
  }

  displayProgressBar() {
    return LinearProgressBar(
      maxSteps: 100,
      progressType: LinearProgressBar.progressTypeLinear,
      // Use Linear progress
      currentStep: widget.objective.stateValue,
      progressColor: SoulPotTheme.SPPaleGreen,
      backgroundColor: Colors.grey,
      semanticsLabel: "Label",
      semanticsValue: "Value",
    );
  }

  onChanged() {}
}
