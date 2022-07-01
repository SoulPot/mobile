import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/global/widgets/circle_page_indicator.dart';
import 'package:soulpot/in_app/codex_viewer/widget/picture_gif_carousel.dart';
import 'package:soulpot/in_app/codex_viewer/widget/plant_details_informations.dart';
import 'package:soulpot/in_app/codex_viewer/widget/plant_details_recommendations.dart';

import '../../../global/models/plant.dart';

class PlantDetailsView extends StatelessWidget {
  PlantDetailsView({Key? key, required this.plant}) : super(key: key);
  final Plant plant;
  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: (details) {
            int sensitivity = 8;
            if (details.delta.dx > sensitivity) {
              // Right Swipe
              Navigator.of(context).pop();
            }
          },
          child: Container(
            color: SoulPotTheme.spBackgroundWhite,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.h, top: 8.h),
                        child: PictureGifCarousel(
                          pageNotifier: _pageNotifier,
                          plant: plant,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: PageIndicator(
                          pageNotifier: _pageNotifier,
                          itemCount: 2,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          "${plant.shortDescription}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontFamily: "Greenhouse"),
                        ),
                      ),
                      PlantDetailsInformations(plant: plant),
                      PlantDetailsRecommendations(plant: plant),
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
      ),
    );
  }
}
