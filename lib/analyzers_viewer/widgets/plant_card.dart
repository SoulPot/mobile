import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/models/plant.dart';

class PlantCard extends StatefulWidget {
  const PlantCard({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: SoulPotTheme.spBackgroundWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: widget.plant.gifURL,
            height: 5.h,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: SoulPotTheme.spGreen,
                ),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Column(
              children: [
                Text(
                  widget.plant.alias,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Greenhouse"),
                ),
                Text(
                  widget.plant.display_pid,
                  style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Greenhouse"),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
