// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:sizer/sizer.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String> itemCallBack;
  final String currentItem;

  const DropdownWidget({
    Key? key,
    required this.items,
    required this.itemCallBack,
    required this.currentItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropdownState(currentItem);
}

class _DropdownState extends State<DropdownWidget> {
  List<DropdownMenuItem<String>> dropDownItems = [];
  String currentItem;

  _DropdownState(this.currentItem);

  @override
  void initState() {
    super.initState();
    for (String item in widget.items) {
      dropDownItems.add(DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: 11.sp,
              fontFamily: 'Greenhouse',
              fontWeight: FontWeight.bold),
        ),
      ));
    }
  }

  @override
  void didUpdateWidget(DropdownWidget oldWidget) {
    if (currentItem != widget.currentItem) {
      setState(() {
        currentItem = widget.currentItem;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: SoulPotTheme.spPalePurple,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: currentItem,
                isExpanded: true,
                items: dropDownItems,
                onChanged: (selectedItem) => setState(() {
                  currentItem = selectedItem as String;
                  widget.itemCallBack(currentItem);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
