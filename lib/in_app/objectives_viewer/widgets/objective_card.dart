import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/objective.dart';


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
        final isUnder = (ValueKey(buildCard(const ValueKey(true))) != widget?.key);
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
        child: displayFront ?  buildCard(const ValueKey(true)) :  buildCard(const ValueKey(false)),
      ),
    );
  }

  Widget buildCard(Key key) {
    return Card(
      key: key,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: 35.w,
        height: 15.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade300,
              widget.objective.backgroundColor,
              widget.objective.backgroundColor,
            ],
            stops: [
              0.0,
              (100 - widget.objective.stateValue!) / 100,
              (100 - widget.objective.stateValue!) / 100,
              1.0
            ],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
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
              widget.objective.owned == true || !displayFront
                  ? widget.objective.owned == true
                      ? Text(
                          "Obtenu le ${widget.objective.ownedDate}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: widget.objective.fontColor,
                              fontFamily: "Greenhouse",
                              fontWeight: FontWeight.w500),
                        )
                      : SizedBox(
                          height: 0.h,
                        )
                  : Text(
                      widget.objective.stateValue! == 0
                          ? "Non commencé"
                          : "Complété à ${widget.objective.stateValue}%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: widget.objective.fontColor,
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.w500),
                    ),
              !displayFront ? displayObjectiveType() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  displayObjectiveType() {
    if (widget.objective.type == "easy") {
      return difficultyStar();
    } else if (widget.objective.type == "advanced") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          difficultyStar(),
          difficultyStar(),
        ],
      );
    } else if (widget.objective.type == "hard") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          difficultyStar(),
          difficultyStar(),
          difficultyStar(),
        ],
      );
    }
  }

  static Widget difficultyStar() {
    return const Icon(
      Icons.star_outlined,
      color: Color(0xFFDEC20B),
    );
  }

  onChanged() {}
}
