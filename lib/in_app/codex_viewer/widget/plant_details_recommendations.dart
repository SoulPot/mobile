import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/plant.dart';
import '../../../global/utilities/theme.dart';

class PlantDetailsRecommendations extends StatelessWidget {
  const PlantDetailsRecommendations({Key? key, required this.plant}) : super(key: key);

  final Plant plant;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Container(
            alignment: Alignment.center,
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
                    inside:
                    const BorderSide(color: Colors.black54)),
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
                    Text(
                      "Humidité ",
                      textAlign: TextAlign.center,
                        style: SoulPotTheme.codexDataTextStyle
                    ),
                    Text(
                      "${plant.recommendations.recommendedHumidity[0]}%",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFe6ac21)),
                    ),
                    Text(
                      "${plant.recommendations.recommendedHumidity[1]}%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color:
                          SoulPotTheme.humidityColors["Wet"]),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Température ",
                      textAlign: TextAlign.center,
                        style: SoulPotTheme.codexDataTextStyle
                    ),
                    Text(
                      "${plant.recommendations.recommendedTemperature[0]}°C",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6BC7B4)),
                    ),
                    Text(
                      "${plant.recommendations.recommendedTemperature[1]}°C",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color: SoulPotTheme
                              .temperatureColors["Hot"]),
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      "Luminosité ",
                      textAlign: TextAlign.center,
                        style: SoulPotTheme.codexDataTextStyle
                    ),
                    Text(
                      "${plant.recommendations.recommendedLuminosity[0]} lux",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color: SoulPotTheme
                              .luminosityColors["Low"]),
                    ),
                    Text(
                      "${plant.recommendations.recommendedLuminosity[1]} lux",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Greenhouse",
                          fontWeight: FontWeight.bold,
                          color: Color(0xffdbdb08)),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ),

        plant.recoText != null
            ? Padding(
          padding: EdgeInsets.only(
              left: 5.w, right: 5.w, bottom: 5.w),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(20)),
              color: SoulPotTheme.spPalePurple,
            ),
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: SizedBox(
                child: Text(
                  plant.recoText!,
                    style: SoulPotTheme.codexDataTextStyle
                ),
              ),
            ),
          ),
        )
            : const SizedBox(
          width: 0,
          height: 0,
        ),
      ],
    );
  }
}
