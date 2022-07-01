import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';

class GeneralAppInfos extends StatefulWidget {
  const GeneralAppInfos({
    Key? key,
    required this.swipePageButton,
  }) : super(key: key);

  final void Function(int) swipePageButton;

  @override
  State<GeneralAppInfos> createState() => _GeneralAppInfosState();
}

class _GeneralAppInfosState extends State<GeneralAppInfos> {
  static const plantScreenURL =
      "https://firebasestorage.googleapis.com/v0/b/soulpot-5fbe6.appspot.com/o/guide_pictures%2Fdemo_plant.jpg?alt=media&token=7d760e03-e875-4c11-953e-a3dda975b5dd";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          color: SoulPotTheme.spPaleGreen,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Text(
              "Présentation de SoulPot ",
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
                    "Vous êtes ici dans le guide de l'application, pour vous permettre de mieux comprendre comment fonctionne votre Analyzer.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                  Text(
                    "Ce guide ne parle que d'un seul Analyzer à la fois, mais l'application est utilisable avec 5 Analyzers maximum.",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.warning_amber_rounded,
              color: SoulPotTheme.spRed,
            ),
            Text(
              "Cette application est inutile sans un Analyzer",
              style: TextStyle(
                  fontFamily: "Greenhouse",
                  color: SoulPotTheme.spRed,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.warning_amber_rounded,
              color: SoulPotTheme.spRed,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
          child: const Text(
            "L'application affiche les informations de votre Analyzer. Elle indique également si les recommandations pour votre plante sont respectées. Lorsque la plante en a besoin vous pouvez aussi l'arroser !",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Greenhouse",
            ),
          ),
        ),
        Container(
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SoulPotTheme.spPurple, width: 1.w),
          ),
          child: CachedNetworkImage(
            imageUrl: plantScreenURL,
            height: 40.h,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        color: SoulPotTheme.spGreen, strokeWidth: 1.w)),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
          child: const Text(
            "Une notification vous indiquera si jamais votre plante n'est plus dans ses conditions optimales.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Greenhouse",
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            child: IconButton(
              onPressed: () => {widget.swipePageButton(1)},
              icon: Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 30.sp,
                color: SoulPotTheme.spPurple,
              ),
            ),
          ),
        )
      ],
    );
  }
}
