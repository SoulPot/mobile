import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';

class ComplementaryInfos extends StatefulWidget {
  const ComplementaryInfos({Key? key, required this.swipePageButton}) : super(key: key);

  final void Function(int) swipePageButton;

  static const analyzerParamPicture =
      "https://firebasestorage.googleapis.com/v0/b/soulpot-5fbe6.appspot.com/o/guide_pictures%2Fdemo_analyzer.jpg?alt=media&token=a23e3071-67b0-4e7f-9e94-1c7fe0a84997";

  @override
  State<ComplementaryInfos> createState() => _ComplementaryInfosState();
}

class _ComplementaryInfosState extends State<ComplementaryInfos> {
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
              "Informations Complémentaires :",
              style: TextStyle(
                fontFamily: "Greenhouse",
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 1.h, horizontal: 3.w),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: SoulPotTheme.spPalePurple,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 1.h, horizontal: 3.w),
              child: const Text(
                "A tout moment, vous pouvez intervenir sur le paramétrage de vos Analyzers, par exemple si vous souhaitez changer le wifi sur lequel il est connecté ou encore son nom.",
                style: TextStyle(
                  fontFamily: "Greenhouse",
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        CachedNetworkImage(
          imageUrl: ComplementaryInfos.analyzerParamPicture,
          height: 15.h,
          progressIndicatorBuilder:
              (context, url, downloadProgress) => Center(
              child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: SoulPotTheme.spGreen,
                  strokeWidth: 1.w)),
          errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 2.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.monitor_heart,
                color: SoulPotTheme.spPurple,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 85.w,
                  child: const Text(
                    "Un Codex est à disposition avec de nombreuses informations sur votre plante, mais aussi sur toutes les plantes disponibles dans l'application.",
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
          padding: EdgeInsets.symmetric(
              horizontal: 2.w, vertical: 1.h),
          child: Row(
            children: [
              const Icon(
                Icons.verified,
                color: SoulPotTheme.spPurple,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: SizedBox(
                  width: 85.w,
                  child: const Text(
                    "De plus, vous trouverez des objectifs à accomplir afin de rendre plus ludique la vie de votre plante !",
                    style: TextStyle(
                      fontFamily: "Greenhouse",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: 1.h, horizontal: 3.w),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: SoulPotTheme.spPalePurple,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 1.h, horizontal: 3.w),
              child: const Text(
                "Si vous souhaitez changer la plante de votre Analyzer, supprimez l'analyzer et réajoutez-le.",
                style: TextStyle(
                  fontFamily: "Greenhouse",
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Text(
          "A vous de jouer !",
          style: TextStyle(
              fontFamily: "Greenhouse",
              color: SoulPotTheme.spGreen,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              child: IconButton(
                onPressed: () => { widget.swipePageButton(1)},
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 30.sp,
                  color: SoulPotTheme.spPurple,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
