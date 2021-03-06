import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/widgets/cached_image.dart';

import '../../../global/models/plant.dart';
import '../../../global/utilities/theme.dart';
import '../views/plant_details_view.dart';

class PlantItemCard extends StatefulWidget {
  const PlantItemCard({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  State<PlantItemCard> createState() => _PlantItemCardState();
}

class _PlantItemCardState extends State<PlantItemCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                  alignment: Alignment.bottomCenter,
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 600),
                  reverseDuration: const Duration(milliseconds: 600),
                  type: PageTransitionType.fade,
                  child: PlantDetailsView(plant: widget.plant),
                  childCurrent: context.widget),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
            child: Row(
              children: [
                CachedImage(imageUrl: widget.plant.gifURL, height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          widget.plant.alias,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Greenhouse"),
                        ),
                      ),
                      SizedBox(
                          width: 55.w,
                          child: Text(
                            widget.plant.shortDescription ?? "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontFamily: "Greenhouse"),
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: SoulPotTheme.spPurple,
                    size: 7.w,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
