import 'dart:ffi';
import 'dart:math';

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
  bool displayFront = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 25.h,
      child: GestureDetector(
        onTap: () => {},
        child: _buildFlipAnimation(),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(buildFront) != widget?.key);
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() => displayFront = !displayFront),
      child: AnimatedSwitcher(
        transitionBuilder: __transitionBuilder,
        duration: Duration(milliseconds: 600),
        child: displayFront ? buildFront() : buildBack(),
      ),
    );
  }

  Widget buildFront(){
    return buildCard(ValueKey(true));
  }

  Widget buildBack(){
    return buildCard(ValueKey(false));
  }

  Widget buildCard(Key key) {
    return Card(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),

      child: Container(
        width: 35.w,
        height: 20.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              displayFront ? Text(
                widget.objective.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: widget.objective.fontColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse"),
              ) : Text(
                widget.objective.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: widget.objective.fontColor,
                    fontFamily: "Greenhouse"),
              ),
              widget.objective.owned == true || !displayFront
                  ? Container(width: 0, height: 0)
                  : displayProgressBar(),
            ],
          ),
        ),
      ),
      color: widget.objective.backgroundColor,
    );
  }

  displayProgressBar() {
    return LinearProgressBar(
      maxSteps: 100,
      progressType: LinearProgressBar.progressTypeLinear,
      // Use Linear progress
      currentStep:
          widget.objective.stateValue != null ? widget.objective.stateValue : 0,
      progressColor: SoulPotTheme.SPPaleGreen,
      backgroundColor: Colors.grey,
      semanticsLabel: "Label",
      semanticsValue: "Value",
    );
  }

  onChanged() {}
}
