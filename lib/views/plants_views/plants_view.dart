import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/widgets/CardInfoPlant.dart';

import '../../theme.dart';
import 'package:sizer/sizer.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({Key? key}) : super(key: key);

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  // MOCKED DATAS
  var mockedValues = {
    "Luminosity": 75,
    "Temperature": 10,
    "Humidity": 0,
    "Battery": 52
  };

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
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 0.5.w),
                  child: Container(
                    width: 75.w,
                    child: Text(
                      "Ceci est le nom de la plante un peu long ",
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
                        batteryLevel: mockedValues["Battery"]!,
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
                height: 40.h,
                width: 100.w,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
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
                  ),
                  Spacer(),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Row(
              children: [
                CardInfoPlant(
                  label: "Luminosité",
                  value: "${mockedValues["Luminosity"]} lux",
                  backgroundColor: SoulPotTheme.luminosityColors["Good"]!,
                  fontColor: Colors.black,
                ),
                CardInfoPlant(
                  label: "Température",
                  value: "${mockedValues["Temperature"]}°C",
                  backgroundColor: SoulPotTheme.temperatureColors["Cold"]!,
                  fontColor: Colors.black,
                ),
              ],
            ),
            Row(
              children: [
                Spacer(),
                CardInfoPlant(
                  label: "Humidité",
                  value: "${mockedValues["Humidity"]}%",
                  backgroundColor: SoulPotTheme.humidityColors["Dry"]!,
                  fontColor: Colors.black,
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
}
