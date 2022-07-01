import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/analyzers_setup/widgets/complementary_infos.dart';
import 'package:soulpot/analyzers_setup/widgets/general_app_infos.dart';
import 'package:soulpot/analyzers_setup/widgets/pairing_infos.dart';

import '../../global/utilities/theme.dart';

class AppInfosView extends StatefulWidget {
  const AppInfosView({Key? key}) : super(key: key);

  @override
  State<AppInfosView> createState() => _AppInfosViewState();
}

class _AppInfosViewState extends State<AppInfosView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: SoulPotTheme.spBackgroundWhite,
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                children: [
                  GeneralAppInfos(swipePageButton: swipePageButton ),
                  PairingInfos(swipePageButton: swipePageButton,),
                  ComplementaryInfos(swipePageButton: swipePageButton,),
                ],
              ),

              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: SoulPotTheme.spGreen,
                      size: 10.w,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void swipePageButton(int index) {
    // use this to animate to the page
    _pageController.jumpToPage(index);
  }
}
