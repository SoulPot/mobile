import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';

import '../../models/Analyzer.dart';

class RenameDialog extends StatefulWidget {
  const RenameDialog({Key? key, required Analyzer analyzer})
      : _analyzer = analyzer,
        super(key: key);

  final Analyzer _analyzer;

  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  TextEditingController _analyzerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 33.h,
        width: 90.w,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 2.5.w, right: 2.5.w),
              child: Text(
                'Comment souhaitez-vous renommer ${widget._analyzer.name} ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: SoulPotTheme.SPBlack,
                    fontSize: 15.sp,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: TextField(
                controller: _analyzerNameController,
                decoration: InputDecoration(
                  hintText: widget._analyzer.name,
                  hintStyle: TextStyle(
                    color: SoulPotTheme.SPBlack,
                    fontSize: 12.sp,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                style: TextStyle(
                  color: SoulPotTheme.SPBlack,
                  fontSize: 12.sp,
                  fontFamily: 'Greenhouse',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 2.h),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Annuler",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.SPBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.SPPaleRed,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (_analyzerNameController.text.isNotEmpty &&
                          _analyzerNameController.text.trim() != "") {
                        widget._analyzer.name = _analyzerNameController.text;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Valider",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SoulPotTheme.SPBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.SPPaleGreen,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
