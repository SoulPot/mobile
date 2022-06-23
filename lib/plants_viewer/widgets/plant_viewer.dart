import 'dart:math';

import 'package:battery_indicator/battery_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/plants_viewer/widgets/disconnect_dialog.dart';

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
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 1.h, right: 2.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Text(
                        "Batterie",
                        style: TextStyle(
                          fontSize: 11.sp,
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
                      size: 5.w,
                      colorful: true,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
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
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: ElevatedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) => DisconnectDialog());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: SoulPotTheme.spRed,
                    fixedSize: Size(5.h, 5.h),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.door_front_door_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Center(
          child: CachedNetworkImage(
            imageUrl: widget.analyzer.imageURL!,
            height: 34.h,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: SoulPotTheme.spGreen,
                        strokeWidth: 1.w)),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
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
