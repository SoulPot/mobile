import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/objective.dart';

import '../../global/utilities/theme.dart';

class ObjectiveCard extends StatefulWidget {
  const ObjectiveCard({Key? key, required this.objective}) : super(key: key);

  final Objective objective;

  @override
  State<ObjectiveCard> createState() => _ObjectiveCardState();
}

class _ObjectiveCardState extends State<ObjectiveCard> {
  bool displayFront = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () => setState(() => displayFront = !displayFront),
      child: AnimatedSwitcher(
        transitionBuilder: __transitionBuilder,
        duration: const Duration(milliseconds: 600),
        child: displayFront ? buildFront() : buildBack(),
      ),
    );
  }

  Widget buildFront() {
    return buildCard(const ValueKey(true));
  }

  Widget buildBack() {
    return buildCard(const ValueKey(false));
  }

  Widget buildCard(Key key) {
    return Card(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: widget.objective.backgroundColor,
      child: SizedBox(
        width: 35.w,
        height: 20.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              displayFront
                  ? Text(
                      widget.objective.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: widget.objective.fontColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Greenhouse"),
                    )
                  : Text(
                      widget.objective.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: widget.objective.fontColor,
                          fontFamily: "Greenhouse"),
                    ),
              widget.objective.owned == false || !displayFront
                  ? const SizedBox(
                      width: 0,
                      height: 0,
                    )
                  : displayProgressBar(),
              !displayFront ? displayObjectiveType() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  displayProgressBar() {
    return LinearProgressBar(
      maxSteps: 100,
      progressType: LinearProgressBar.progressTypeLinear,
      // Use Linear progress
      currentStep:
          widget.objective.stateValue ?? 0,
      progressColor: SoulPotTheme.spPaleGreen,
      backgroundColor: Colors.grey,
      semanticsLabel: "Label",
      semanticsValue: "Value",
    );
  }

  displayObjectiveType() {

    if (widget.objective.type == "easy") {
      return const Icon(Icons.star_border_outlined);
    } else if (widget.objective.type == "advanced") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star_border_outlined),
          Icon(Icons.star_border_outlined),
        ],
      );
    } else if (widget.objective.type == "hard") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.star_border_outlined),
          Icon(Icons.star_border_outlined),
          Icon(Icons.star_border_outlined)
        ],
      );
    }
  }

  onChanged() {}
}
