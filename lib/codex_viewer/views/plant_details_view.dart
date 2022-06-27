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
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  plant.alias,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: SoulPotTheme.spPurple),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Spacer(),
                  CachedNetworkImage(
                    imageUrl: plant.gifURL,
                    height: 35.h,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                color: SoulPotTheme.spGreen, strokeWidth: 1.w)),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                  Text("${plant.infos}"),
                  Spacer(),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      color: SoulPotTheme.spPaleGreen,
                    ),
                    child: const Text(
                      "Informations",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Row(
                      children: [
                        Text("Nom Botanique : "),
                        Text(plant.display_pid),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.map),
                      Text("Origine : "),
                      Container(width: 65.w, child: Text("${plant.origin}")),
                    ],
                  ),
                  Text("${plant.family}"),
                  Text("${plant.plant_type}"),
                  Text("${plant.flower_color}"),

                  Text("${plant.cutting}"),
                  Text("${plant.sowing}"),
                  Text("${plant.planting_season}"),
                  Text("${plant.flowering_season}"),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    width: 100.w,
                    decoration: const BoxDecoration(
                      color: SoulPotTheme.spPaleGreen,
                    ),
                    child: const Text(
                      "Recommandations",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Container(
                      width: 100.w,
                      child: Text("${plant.recoText}"),
                    ),
                  ),

                  //Text("${plant.picture_url}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
