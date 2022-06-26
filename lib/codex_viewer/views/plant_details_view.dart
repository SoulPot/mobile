import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/codex_viewer/views/codex_view.dart';
import 'package:soulpot/global/utilities/theme.dart';

import '../../models/plant.dart';

class PlantDetailsView extends StatelessWidget {
  const PlantDetailsView({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(plant.alias, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: SoulPotTheme.spPurple),),
              ),
            ),

            CachedNetworkImage(
              imageUrl: plant.gifURL,
              height: 55.h,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          color: SoulPotTheme.spGreen,
                          strokeWidth: 1.w)),
              errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
            ),
            Column(
              
              children: [
                Spacer(),

                Text("Nom Scientifique"),
                Text(plant.plantID),
                Text(plant.plantID),
                Text(plant.plantID),
                Text(plant.plantID),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
