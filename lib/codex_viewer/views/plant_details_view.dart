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
        child: Container(
          color: SoulPotTheme.spBackgroundWhite,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h, top: 8.h),
                      child: CachedNetworkImage(
                        imageUrl: plant.gifURL,
                        height: 35.h,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    color: SoulPotTheme.spGreen,
                                    strokeWidth: 1.w)),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Text("${plant.shortDescription}", textAlign: TextAlign.center,),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          color: SoulPotTheme.spPaleGreen,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: const Text(
                            "Informations",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Text("Nom Botanique : "),
                            Text(plant.display_pid),
                          ]),
                          TableRow(children: [
                            Text("Origine : "),
                            Container(
                                width: 65.w, child: Text("${plant.origin}")),
                          ]),
                          TableRow(children: [
                            Text("Famille : "),
                            Text("${plant.family}"),
                          ]),
                          TableRow(children: [
                            Text("Type de plante : "),
                            Text("${plant.plant_type}"),
                          ]),
                          TableRow(children: [
                            Text("Couleur : "),
                            Text("${plant.flower_color}"),
                          ]),
                          TableRow(children: [
                            Text("Bouture : "),
                            Text("${plant.cutting}"),
                          ]),
                          TableRow(children: [
                            Text("Semis : "),
                            Text("${plant.sowing}"),
                          ]),
                          TableRow(children: [
                            Text("Plantation : "),
                            Text("${plant.planting_season}"),
                          ]),
                          TableRow(children: [
                            Text("Floraison"),
                            Text("${plant.flowering_season}"),
                          ]),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: SoulPotTheme.spPalePurple,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Text("${plant.infos}"),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100.w,
                        decoration: const BoxDecoration(
                          color: SoulPotTheme.spPaleGreen,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: const Text(
                            "Recommandations",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: SoulPotTheme.spPalePurple,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Container(
                            width: 100.w,
                            child: Text("${plant.recoText}"),
                          ),
                        ),
                      ),
                    ),

                    //Text("${plant.picture_url}"),
                  ],
                ),
              ),
              Container(
                height: 7.h,
                color: SoulPotTheme.spBackgroundWhite,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 7.w,
                          color: SoulPotTheme.spPurple,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          plant.alias,
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: SoulPotTheme.spPurple),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
