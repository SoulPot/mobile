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
          onTap: (){
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
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: SoulPotTheme.spGreen, strokeWidth: 1.w)),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.plant.alias),
                    Text("Famille > ${widget.plant.plantID}")
                  ],
                ),
              ],
            ),
          )),
    );
  }

}

