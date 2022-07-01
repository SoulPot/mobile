import 'package:flutter/material.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:sizer/sizer.dart';

import '../../models/analyzer.dart';


class RenameDialog extends StatefulWidget {
  const RenameDialog({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;

  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  final TextEditingController _analyzerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: 33.h,
        width: 90.w,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 2.5.w, right: 2.5.w),
              child: Text(
                'Comment souhaitez-vous renommer ${widget.analyzer.name} ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: SoulPotTheme.spBlack,
                    fontSize: 15.sp,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextField(
                maxLength: 40,
                controller: _analyzerNameController,
                decoration: InputDecoration(
                  hintText: widget.analyzer.name,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: TextStyle(
                  color: SoulPotTheme.spBlack,
                  fontSize: 12.sp,
                  fontFamily: 'Greenhouse',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.spPaleRed,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    ),
                    child: Text(
                      "Annuler",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.spBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_analyzerNameController.text.isNotEmpty &&
                          _analyzerNameController.text.trim() != "") {
                        widget.analyzer.name = _analyzerNameController.text;
                      }
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.spPaleGreen,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    ),
                    child: Text(
                      "Valider",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.spBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
