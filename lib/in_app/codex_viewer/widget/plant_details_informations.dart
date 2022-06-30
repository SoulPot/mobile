import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/plant.dart';
import '../../../global/utilities/theme.dart';

class PlantDetailsInformations extends StatelessWidget {
  const PlantDetailsInformations({Key? key, required this.plant})
      : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Container(
            alignment: Alignment.center,
            color: SoulPotTheme.spPaleGreen,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Text(
                "Informations",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Greenhouse",
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
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
                Text(plant.displayPID, style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Famille : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.family ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Type de plante : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.plantType ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Origine : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.origin ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
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
                Text(plant.flowerColor ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
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
                Text(plant.cutting ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Semis : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.sowing ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Plantation : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.plantingSeason ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
              TableRow(children: [
                const Text(
                  "Floraison : ",
                  style: TextStyle(
                    fontFamily: "Greenhouse",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(plant.floweringSeason ?? "",
                    style: SoulPotTheme.codexDataTextStyle),
              ]),
            ],
          ),
        ),
        plant.infos != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: SoulPotTheme.spPalePurple,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Text(plant.infos!,
                        style: SoulPotTheme.codexDataTextStyle),
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
