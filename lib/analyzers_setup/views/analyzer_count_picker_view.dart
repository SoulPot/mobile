import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/models/analyzer.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/analyzers_setup/widgets/analyzer_count_printer.dart';
import 'package:sizer/sizer.dart';

import 'analyzer_setup_view.dart';

class AnalyzerCountPickerView extends StatefulWidget {
  const AnalyzerCountPickerView({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Image.asset(
                    "assets/images/LogoSoulPot.png",
                    height: 30.h,),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                  child: ElevatedButton(
                    onPressed: () async {
                      for (int i = 0; i < _currentAnalyzerCount + 1; i++) {
                        _analyzers.add(Analyzer("Analyzer ${i + 1}", false));
                      }
                      Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 600),
                            reverseDuration: const Duration(milliseconds: 600),
                            type: PageTransitionType.fade,
                            child: AnalyzerSetupView(
                              analyzers: _analyzers,
                            ),
                            childCurrent: context.widget),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.spGreen,
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
