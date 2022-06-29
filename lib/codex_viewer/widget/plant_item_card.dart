import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';
import '../../models/plant.dart';
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.plant.gifURL,
                  height: 10.h,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              color: SoulPotTheme.spGreen, strokeWidth: 1.w)),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
                VerticalDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          widget.plant.alias,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Greenhouse"),
                        ),
                      ),
                      SizedBox(
                          width: 55.w,
                          child: Text(
                            "${widget.plant.shortDescription}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: "Greenhouse"),
                          )),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: SoulPotTheme.spPurple,
                  size: 7.w,
                ),
              ],
            ),
          )),
    );
  }
}
