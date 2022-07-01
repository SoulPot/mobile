import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulpot/analyzers_setup/views/app_infos_view.dart';
import 'package:soulpot/global/utilities/ConnectivityManager.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/analyzers_setup/widgets/analyzer_count_printer.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

import '../../global/models/analyzer.dart';
import '../../global/models/plant.dart';
import 'analyzer_setup_view.dart';

class AnalyzerCountPickerView extends StatefulWidget {
  const AnalyzerCountPickerView({Key? key, required this.codex})
      : super(key: key);

  final List<Plant> codex;

  @override
  State<AnalyzerCountPickerView> createState() =>
      _AnalyzerCountPickerViewState();
}

class _AnalyzerCountPickerViewState extends State<AnalyzerCountPickerView> {
  int _currentAnalyzerCount = 0;
  final List<Analyzer> _analyzers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        "Bienvenue sur l'application",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: SoulPotTheme.spBlack,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Greenhouse',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: IconButton(
                          icon: Icon(
                            Icons.info,
                            color: SoulPotTheme.spGreen,
                            size: 8.w,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 600),
                                  reverseDuration:
                                      const Duration(milliseconds: 600),
                                  type: PageTransitionType.fade,
                                  child: const AppInfosView(),
                                  childCurrent: context.widget),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Image.asset(
                  "assets/images/LogoSoulPot.png",
                  height: 25.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  "Commençons par la configuration de vos analyzers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: SoulPotTheme.spBlack,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Greenhouse',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w, right: 1.w, top: 1.h),
                child: const Divider(
                  thickness: 1,
                  color: SoulPotTheme.spBlack,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                child: Text(
                  "De combien d'analyzer disposez-vous ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: SoulPotTheme.spBlack,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Greenhouse',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3.h),
                child: Center(
                  child: NumberStepper(
                    numbers: const [1, 2, 3, 4, 5],
                    activeStep: _currentAnalyzerCount,
                    activeStepBorderColor: SoulPotTheme.spGreen,
                    activeStepBorderWidth: 2,
                    activeStepColor: SoulPotTheme.spPalePurple,
                    enableNextPreviousButtons: false,
                    enableStepTapping: true,
                    lineColor: SoulPotTheme.spGreen,
                    numberStyle: const TextStyle(
                      color: SoulPotTheme.spBlack,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Greenhouse',
                    ),
                    stepColor: SoulPotTheme.spLightGray,
                    onStepReached: (step) {
                      setState(() {
                        _currentAnalyzerCount = step;
                      });
                    },
                  ),
                ),
              ),
              AnalyzerCountPrinter(analyzerCount: _currentAnalyzerCount + 1),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Vous avez déjà configuré vos analyzers ?",
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: SoulPotTheme.spBlack,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Greenhouse',
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("first_launch", false);

                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  alignment: Alignment.bottomCenter,
                                  curve: Curves.easeInOut,
                                  duration: const Duration(milliseconds: 600),
                                  reverseDuration:
                                      const Duration(milliseconds: 600),
                                  type: PageTransitionType.fade,
                                  child: const SignInView(),
                                  childCurrent: context.widget),
                            );
                          },
                          child: Text(
                            "Passer la configuration",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: SoulPotTheme.spGreen,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Greenhouse',
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (await ConnectivityManager
                            .checkPeripheralConnection()) {
                          for (int i = 0; i < _currentAnalyzerCount + 1; i++) {
                            _analyzers
                                .add(Analyzer("Analyzer ${i + 1}", false));
                          }
                          Navigator.push(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 600),
                                reverseDuration:
                                    const Duration(milliseconds: 600),
                                type: PageTransitionType.fade,
                                child: AnalyzerSetupView(
                                  analyzers: _analyzers,
                                  codex: widget.codex,
                                ),
                                childCurrent: context.widget),
                          );
                        } else {
                          snackBarCreator(context, "Une connexion internet est nécessaire !", SoulPotTheme.spRed);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: SoulPotTheme.spGreen,
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        _currentAnalyzerCount == 0
                            ? "Continuer la configuration de votre analyzer"
                            : "Continuer la configuration de vos ${_currentAnalyzerCount + 1} analyzers",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
