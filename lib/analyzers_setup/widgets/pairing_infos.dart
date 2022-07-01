import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';

class PairingInfos extends StatefulWidget {
  const PairingInfos({Key? key, required this.swipePageButton}) : super(key: key);

  final void Function(int) swipePageButton;

  static const monsteraGif =
      "https://firebasestorage.googleapis.com/v0/b/soulpot-5fbe6.appspot.com/o/plants_gifs%2F11_Monstera.gif?alt=media&token=3cc93ddd-74b8-4f10-be1a-8519e208f556";
  static const orchideeGif =
      "https://firebasestorage.googleapis.com/v0/b/soulpot-5fbe6.appspot.com/o/plants_gifs%2F10_Orchidee.gif?alt=media&token=6ac34508-e6c8-40a2-b83c-1f0739887890";

  @override
  State<PairingInfos> createState() => _PairingInfosState();
}

class _PairingInfosState extends State<PairingInfos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: SoulPotTheme.spPaleGreen,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Text(
              "Paramétrer votre Analyzer",
              style: TextStyle(
                fontFamily: "Greenhouse",
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: SoulPotTheme.spPalePurple,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
              child: Column(
                children: const [
                  Text(
                    "Avant de pouvoir utiliser votre Analyzer, il vous faut l'appairer. Pour cela, assurez vous que votre Bluetooth ainsi que votre Wifi sont activés. Votre téléphone doit être connecté à Internet.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.looks_one_rounded,
                color: SoulPotTheme.spGreen,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 83.w,
                  child: const Text(
                    "Sélectionnez l'Analyzer à appairer.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.looks_two_rounded,
                color: SoulPotTheme.spGreen,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 83.w,
                  child: Column(
                    children: [
                      const Text(
                        "Choisissez le réseau wifi sur lequel vous voulez connecter votre Analyzer.",
                        style: TextStyle(
                          fontFamily: "Greenhouse",
                        ),
                      ),
                      Text(
                        "L'Analyzer a besoin d'une connexion internet pour pouvoir remonter régulièrement les informations de votre plante",
                        style: TextStyle(
                          fontFamily: "Greenhouse",
                          fontStyle: FontStyle.italic,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.looks_3_rounded,
                color: SoulPotTheme.spGreen,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 83.w,
                  child: const Text(
                    "Sélectionnez ensuite la plante correspondant à l'Analyzer dans la liste disponible.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.looks_4_rounded,
                color: SoulPotTheme.spGreen,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 83.w,
                  child: const Text(
                    "Une fois tous vos Analyzers paramétrés, vous pouvez créer un compte sur l'application ou vous connecter si vous en avez déjà un.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: SoulPotTheme.spPalePurple,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.w),
              child: const Text(
                "Vous pouvez renommer votre Analyzer pour l'identifier plus facilement, comme avec le nom de votre plante ou la pièce dans laquelle il se trouve !",
                style: TextStyle(
                  fontFamily: "Greenhouse",
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Text(
            "Le paramétrage est terminé !",
            style: TextStyle(
              fontFamily: "Greenhouse",
                color: SoulPotTheme.spGreen,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CachedNetworkImage(
              imageUrl: PairingInfos.monsteraGif,
              height: 13.h,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: SoulPotTheme.spGreen,
                          strokeWidth: 1.w)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
            const Spacer(),
            CachedNetworkImage(
              imageUrl: PairingInfos.orchideeGif,
              height: 13.h,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: SoulPotTheme.spGreen,
                          strokeWidth: 1.w)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
            const Spacer(),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: IconButton(
                onPressed: () => { widget.swipePageButton(0)},
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 30.sp,
                  color: SoulPotTheme.spPurple,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: IconButton(
                onPressed: () => { widget.swipePageButton(2)},
                icon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 30.sp,
                  color: SoulPotTheme.spPurple,
                ),
              ),
            )
          ],
        ),

      ],
    );
  }
}
