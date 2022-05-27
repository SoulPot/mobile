import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/models/MockedData.dart';
import 'package:soulpot/widgets/CardInfoPlant.dart';

import '../../models/Analyzer.dart';
import '../../theme.dart';
import 'package:sizer/sizer.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({Key? key}) : super(key: key);

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  // MOCKED DATAS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
                  child: Container(
                    width: 75.w,
                    child: Text(
                      MockedData.analyzer1.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Greenhouse",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, right: 2.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Text(
                          "Batterie",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Greenhouse",
                          ),
                        ),
                      ),
                      BatteryIndicator(
                        batteryFromPhone: false,
                        batteryLevel: MockedData.analyzer1.battery!,
                        style: BatteryIndicatorStyle.skeumorphism,
                        showPercentNum: true,
                        size: 6.w,
                        colorful: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Image.asset(
                "assets/images/plant1.gif",
                height: 34.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                children: [
                  Spacer(),
                  MockedData.analyzer1.needSprinkle
                      ? ElevatedButton(
                          onPressed: water,
                          style: ElevatedButton.styleFrom(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            primary: SoulPotTheme.SPPaleGreen,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                SoulPotTheme.water,
                                color: SoulPotTheme.SPBT,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 3.w),
                                child: Text(
                                  "M'arroser",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: SoulPotTheme.SPPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 0.w,
                          height: 6.2.h,
                        ),
                  Spacer(),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            Row(
              children: [
                CardInfoPlant(
                  label: "Luminosité",
                  value: "${MockedData.analyzer1.luminosity!} lux",
                  backgroundColor: getLuminosityColor(MockedData.analyzer1),
                  fontColor: Colors.black,
                  recommendedValue: MockedData.analyzer1.recommendations!.recommendedLuminosity,
                ),
                CardInfoPlant(
                  label: "Température",
                  value: "${MockedData.analyzer1.temperature!}°C",
                  backgroundColor: getTemperatureColor(MockedData.analyzer1),
                  fontColor: Colors.black,
                  recommendedValue: MockedData.analyzer1.recommendations!.recommendedTemperature,
                ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                CardInfoPlant(
                  label: "Humidité",
                  value: "${MockedData.analyzer1.humidity!}%",
                  backgroundColor: getHumidityColor(MockedData.analyzer1),
                  fontColor: Colors.black,
                  recommendedValue: MockedData.analyzer1.recommendations!.recommendedHumidity,
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void water() {
    print("J'arrose ma plonte");
  }

  void parameters() {
    print("Vers les paramètres");
  }

  Color getTemperatureColor(Analyzer analyzer) {
    if (analyzer.recommendations != null && analyzer.temperature != null) {
      if (analyzer.temperature! <
          analyzer.recommendations!.recommendedTemperature.reduce(min)) {
        return SoulPotTheme.temperatureColors["Cold"]!;
      } else if (analyzer.temperature! >
          analyzer.recommendations!.recommendedTemperature.reduce(max)) {
        return SoulPotTheme.temperatureColors["Hot"]!;
      } else {
        return SoulPotTheme.temperatureColors["Good"]!;
      }
    } else {
      return SoulPotTheme.SPBackgroundWhite;
    }
  }

  Color getLuminosityColor(Analyzer analyzer) {
    if (analyzer.recommendations != null && analyzer.luminosity != null) {
      if (analyzer.luminosity! <
          analyzer.recommendations!.recommendedLuminosity.reduce(min)) {
        return SoulPotTheme.luminosityColors["Low"]!;
      } else if (analyzer.luminosity! >
          analyzer.recommendations!.recommendedLuminosity.reduce(max)) {
        return SoulPotTheme.luminosityColors["High"]!;
      } else {
        return SoulPotTheme.luminosityColors["Good"]!;
      }
    } else {
      return SoulPotTheme.SPBackgroundWhite;
    }
  }

  Color getHumidityColor(Analyzer analyzer) {
    if (analyzer.recommendations != null && analyzer.humidity != null) {
      if (analyzer.humidity! <
          analyzer.recommendations!.recommendedHumidity.reduce(min)) {
        return SoulPotTheme.humidityColors["Dry"]!;
      } else if (analyzer.humidity! >
          analyzer.recommendations!.recommendedHumidity.reduce(max)) {
        return SoulPotTheme.humidityColors["Wet"]!;
      } else {
        return SoulPotTheme.humidityColors["Good"]!;
      }
    } else {
      return SoulPotTheme.SPBackgroundWhite;
    }
  }
}
