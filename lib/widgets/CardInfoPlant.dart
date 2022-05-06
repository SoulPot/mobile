import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 8,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(widget.value,
                  style: TextStyle(fontSize: 24, color: widget.fontColor)),
              Text(widget.label,
                  style: TextStyle(fontSize: 24, color: widget.fontColor)),
            ],
          ),
        ),
        color: widget.backgroundColor,
      ),
    );
  }
}
