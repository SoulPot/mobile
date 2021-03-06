import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/firebase_management/analytics.dart';
import 'package:soulpot/global/widgets/cached_image.dart';

import '../../../global/models/analyzer.dart';
import '../../../global/utilities/mqtt_manager.dart';
import '../../../global/utilities/theme.dart';
import 'plant_infos_card.dart';

class PlantViewer extends StatefulWidget {
  const PlantViewer({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;

  @override
  State<PlantViewer> createState() => _PlantViewerState();
}

class _PlantViewerState extends State<PlantViewer> {
  final MQTTManager _mqttManager = MQTTManager();

  @override
  void initState() {
    _mqttManager.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: SizedBox(
                width: 75.w,
                child: Text(
                  widget.analyzer.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Greenhouse",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        CachedImage(imageUrl: widget.analyzer.imageURL!, height: 34.h),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  widget.analyzer.needSprinkle &&
                      widget.analyzer.humidity != -255
                      ? ElevatedButton(
                    onPressed: sprink,
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
                          Icons.shower_rounded,
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
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  widget.analyzer.lastUpdateDateTime == "Aucune"
                      ? "Jamais mis ?? jour"
                      : "Derni??re mise ?? jour le ${widget.analyzer
                      .lastUpdateDateTime!.split(" ")[0]} ?? ${widget.analyzer
                      .lastUpdateDateTime!.split(" ")[1]}",
                  style: TextStyle(fontSize: 9.sp, fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            CardInfoPlant(
              label: "Luminosit??",
              value: widget.analyzer.luminosity! == -255
                  ? "Aucune donn??e"
                  : "${widget.analyzer.luminosity!} lux",
              backgroundColor: getLuminosityColor(widget.analyzer),
              fontColor: Colors.black,
              recommendedValue:
              widget.analyzer.recommendations!.recommendedLuminosity,
            ),
            CardInfoPlant(
              label: "Temp??rature",
              value: widget.analyzer.temperature! == -255
                  ? "Aucune donn??e"
                  : "${widget.analyzer.temperature!}??C",
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
              label: "Humidit??",
              value: widget.analyzer.humidity! == -255
                  ? "Aucune donn??e"
                  : "${widget.analyzer.humidity!}%",
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

  void sprink() {
    String? deviceId = widget.analyzer.id;
    int minReco = widget.analyzer.recommendations!.recommendedHumidity[0];
    int maxReco = widget.analyzer.recommendations!.recommendedHumidity[1];
    int medReco = (minReco + maxReco) ~/ 2;
    if (deviceId == null) {
      return;
    }
    String payload = "{\"sprinkle\":\"true\", \"expectedValue\": \"$medReco\"}";
    _mqttManager.publishMsg(payload, deviceId, "/sprink");
    AnalyticsManager.logSprinkle();
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
