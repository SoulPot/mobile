import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/theme.dart';

import '../../models/plant.dart';

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
            if (details.delta.dx > sensitivity) { // Right Swipe
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
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 40.h,
                            enableInfiniteScroll: false,
                            pageSnapping: true,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              _pageNotifier.value = index;
                            },
                          ),
                          items: [plant.gifURL, plant.picture_url!].map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: url,
                                      height: 40.h,
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                                  color: SoulPotTheme.spGreen,
                                                  strokeWidth: 1.w)),
                                      errorWidget: (context, url, error) =>
                                          const Center(
                                              child: Icon(Icons.error)),
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: CirclePageIndicator(
                          currentPageNotifier: _pageNotifier,
                          itemCount: 2,
                          size: 10,
                          selectedSize: 12,
                          selectedDotColor: SoulPotTheme.spGreen,
                          dotColor: Colors.grey,
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Text(
                          "${plant.shortDescription}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: "Greenhouse"),
                        ),
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
                            child: Text(
                              "Informations",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Greenhouse"),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 2.h),
                        child: Table(
                          children: [
                            TableRow(children: [
                              const Text(
                                "Nom Botanique : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                plant.display_pid,
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Famille : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.family}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Type de plante : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.plant_type}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Origine : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                  width: 65.w,
                                  child: Text(
                                    "${plant.origin}",
                                    style: TextStyle(fontFamily: "Greenhouse"),
                                  )),
                            ]),
                            const TableRow(children: [
                              Text(""),
                              Text(""),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Couleur(s) : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.flower_color}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            const TableRow(children: [
                              Text(""),
                              Text(""),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Bouture : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.cutting}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Semis : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.sowing}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Plantation : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.planting_season}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Floraison : ",
                                style: TextStyle(
                                  fontFamily: "Greenhouse",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${plant.flowering_season}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
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
                            child: Text(
                              "${plant.infos}",
                              style: TextStyle(fontFamily: "Greenhouse"),
                            ),
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
                            child: Text(
                              "Recommandations",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Greenhouse"),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 7.w, vertical: 2.h),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: SoulPotTheme.spLightGray,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: Table(
                              border: TableBorder.symmetric(
                                  inside: BorderSide(color: Colors.black54)),
                              children: [
                                const TableRow(children: [
                                  Text(
                                    "Paramètres",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Minimum",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Maximum",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                                TableRow(children: [
                                  const Text(
                                    "Humidité ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Greenhouse"),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedHumidity[0].toString()}%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color:
                                            SoulPotTheme.humidityColors["Wet"]),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedHumidity[1].toString()}%",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFe6ac21)),
                                  )
                                ]),
                                TableRow(children: [
                                  const Text(
                                    "Température ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Greenhouse"),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedTemperature[0].toString()}°C",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF6BC7B4)),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedTemperature[1].toString()}°C",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color: SoulPotTheme
                                            .temperatureColors["Hot"]),
                                  )
                                ]),
                                TableRow(children: [
                                  const Text(
                                    "Luminosité ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontFamily: "Greenhouse"),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedLuminosity[0].toString()} lux",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color: SoulPotTheme
                                            .luminosityColors["Low"]),
                                  ),
                                  Text(
                                    "${plant.recommendations.recommendedLuminosity[1].toString()} lux",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontFamily: "Greenhouse",
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffeded5f)),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.w),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: SoulPotTheme.spPalePurple,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: Container(
                              width: 100.w,
                              child: Text(
                                "${plant.recoText}",
                                style: TextStyle(fontFamily: "Greenhouse"),
                              ),
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
      ),
    );
  }
}
