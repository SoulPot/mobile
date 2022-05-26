import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/widgets/single/analyzer_count_printer.dart';
import 'package:sizer/sizer.dart';

import 'analyzer_setup.dart';

class AnalyzerCountPicker extends StatefulWidget {
  const AnalyzerCountPicker({Key? key}) : super(key: key);

  @override
  State<AnalyzerCountPicker> createState() => _AnalyzerCountPickerState();
}

class _AnalyzerCountPickerState extends State<AnalyzerCountPicker> {
  int _currentAnalyzerCount = 0;
  List<Analyzer> _analyzers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "Bienvenue sur l'application SoulPot",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: SoulPotTheme.SPBlack,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Greenhouse',
                  ),
                ),
              ),
              Image.asset("assets/images/LogoSoulPot.png"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h),
                child: Text(
                  "Commençons par la configuration de vos analyzers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: SoulPotTheme.SPBlack,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Greenhouse',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 1,
                  color: SoulPotTheme.SPBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "De combien d'analyzer disposez-vous ? ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: SoulPotTheme.SPBlack,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Greenhouse',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Center(
                  child: NumberStepper(
                    numbers: [1, 2, 3, 4, 5],
                    activeStep: _currentAnalyzerCount,
                    activeStepBorderColor: SoulPotTheme.SPGreen,
                    activeStepBorderWidth: 2,
                    activeStepColor: SoulPotTheme.SPPalePurple,
                    enableNextPreviousButtons: false,
                    enableStepTapping: true,
                    lineColor: SoulPotTheme.SPGreen,
                    numberStyle: TextStyle(
                      color: SoulPotTheme.SPBlack,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Greenhouse',
                    ),
                    stepColor: SoulPotTheme.SPLightGray,
                    onStepReached: (step) {
                      setState(() {
                        _currentAnalyzerCount = step;
                      });
                    },
                  ),
                ),
              ),
              AnalyzerCountPrinter(AnalyzerCount: _currentAnalyzerCount + 1),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: ElevatedButton(
                  onPressed: () async {
                    for (int i = 0; i < _currentAnalyzerCount + 1; i++) {
                      _analyzers.add(new Analyzer("Analyzer ${i + 1}", false));
                    }
                    Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          type: PageTransitionType.fade,
                          child: AnalyzerSetup(
                            analyzers: _analyzers,
                          ),
                          childCurrent: context.widget),
                    );
                  },
                  child: Text(
                    _currentAnalyzerCount == 0
                        ? "Continuer la configuration de votre analyzer"
                        : "Continuer la configuration de vos ${_currentAnalyzerCount + 1} analyzers",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.SPGreen,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
