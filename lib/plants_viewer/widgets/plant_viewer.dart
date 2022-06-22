import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/analyzer.dart';
import '../../global/utilities/theme.dart';
import 'plant_infos_card.dart';

class PlantViewer extends StatefulWidget {
  const PlantViewer({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;

  @override
  State<PlantViewer> createState() => _PlantViewerState();
}

class _PlantViewerState extends State<PlantViewer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
              child: SizedBox(
                width: 75.w,
                child: Text(
                  widget.analyzer.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
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
                    batteryLevel: widget.analyzer.battery!,
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
          child: Image.network(
            widget.analyzer.imageURL!,
            height: 34.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              const Spacer(),
              widget.analyzer.needSprinkle
                  ? ElevatedButton(
                      onPressed: water,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: SoulPotTheme.spPaleGreen,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            SoulPotTheme.water,
                            color: SoulPotTheme.spBT,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 3.w),
                            child: Text(
                              "M'arroser",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: SoulPotTheme.spPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: 0.w,
                      height: 5.36.h,
                    ),
              const Spacer(),
            ],
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.grey,
        ),
        Row(
          children: [
            CardInfoPlant(
              label: "Luminosité",
              value: "${widget.analyzer.luminosity!} lux",
              backgroundColor: getLuminosityColor(widget.analyzer),
              fontColor: Colors.black,
              recommendedValue:
                  widget.analyzer.recommendations!.recommendedLuminosity,
            ),
            CardInfoPlant(
              label: "Température",
              value: "${widget.analyzer.temperature!}°C",
              backgroundColor: getTemperatureColor(widget.analyzer),
              fontColor: Colors.black,
              recommendedValue:
                  widget.analyzer.recommendations!.recommendedTemperature,
            ),
          ],
        ),
        Row(
          children: [
            const Spacer(),
            CardInfoPlant(
              label: "Humidité",
              value: "${widget.analyzer.humidity!}%",
              backgroundColor: getHumidityColor(widget.analyzer),
              fontColor: Colors.black,
              recommendedValue:
                  widget.analyzer.recommendations!.recommendedHumidity,
            ),
            const Spacer(),
          ],
        )
      ],
    );
  }

  void water() {
    //TODO PUSH TO MQTT
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
      return SoulPotTheme.spBackgroundWhite;
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
      return SoulPotTheme.spBackgroundWhite;
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
      return SoulPotTheme.spBackgroundWhite;
    }
  }
}