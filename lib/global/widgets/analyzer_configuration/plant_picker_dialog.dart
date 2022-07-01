import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/widgets/cached_image.dart';

import '../../models/plant.dart';
import '../../utilities/theme.dart';


class PlantPickerDialog extends StatefulWidget {
  const PlantPickerDialog({Key? key, required this.codex}) : super(key: key);

  final List<Plant> codex;

  @override
  State<PlantPickerDialog> createState() => _PlantPickerDialogState();
}

class _PlantPickerDialogState extends State<PlantPickerDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 50.h,
        width: 90.w,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                "Choisissez votre plante",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.codex.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, widget.codex[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                      ),
                      child: Card(
                        color: SoulPotTheme.spBackgroundWhite,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 1.h,
                          ),
                          child: Row(
                            children: [
                              CachedImage(imageUrl: widget.codex[index].gifURL, height: 5.h),
                              const Spacer(),
                              Column(
                                children: [
                                  Text(
                                    widget.codex[index].alias,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Greenhouse",
                                    ),
                                  ),
                                  Text(
                                    widget.codex[index].displayPID,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      fontFamily: "Greenhouse",
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
