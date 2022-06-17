import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/Analyzer.dart';
import '../../models/Plant.dart';
import '../../theme.dart';
import '../CardInfoPlant.dart';

class PlantViewer extends StatefulWidget {
  const PlantViewer(Analyzer analyzer, {Key? key})
      : this._analyzer = analyzer,
        super(key: key);

  final Analyzer _analyzer;

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
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
              child: Container(
                width: 75.w,
                child: Text(
                  widget._analyzer.name,
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
                    batteryLevel: widget._analyzer.battery!,
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
            widget._analyzer.imageURL!,
            height: 34.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              Spacer(),
              widget._analyzer.needSprinkle
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
              value: "${widget._analyzer.luminosity!} lux",
              backgroundColor: getLuminosityColor(widget._analyzer),
              fontColor: Colors.black,
              recommendedValue:
              widget._analyzer.recommendations!.recommendedLuminosity,
            ),
            CardInfoPlant(
              label: "Température",
              value: "${widget._analyzer.temperature!}°C",
              backgroundColor: getTemperatureColor(widget._analyzer),
              fontColor: Colors.black,
              recommendedValue:
                  widget._analyzer.recommendations!.recommendedTemperature,
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            CardInfoPlant(
              label: "Humidité",
              value: "${widget._analyzer.humidity!}%",
              backgroundColor: getHumidityColor(widget._analyzer),
              fontColor: Colors.black,
              recommendedValue:
                  widget._analyzer.recommendations!.recommendedHumidity,
            ),
            Spacer(),
          ],
        )
      ],
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
