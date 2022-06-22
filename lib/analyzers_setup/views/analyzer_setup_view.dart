import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/analyzers_setup/views/analyzer_count_picker_view.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:soulpot/analyzers_setup/widgets/analyzer_rename_dialog.dart';
import 'package:sizer/sizer.dart';
import '../../models/analyzer.dart';
import '../widgets/analyzer_pairing_dialog.dart';

import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

class AnalyzerSetupView extends StatefulWidget {
  const AnalyzerSetupView({Key? key, required this.analyzers})
      : super(key: key);

  final List<Analyzer> analyzers;

  @override
  State<AnalyzerSetupView> createState() => _AnalyzerSetupViewState();
}

class _AnalyzerSetupViewState extends State<AnalyzerSetupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SafeArea(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List.generate(widget.analyzers.length, (index) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: SoulPotTheme.spPalePurple,
                          border: Border.all(
                            color: SoulPotTheme.spPalePurple,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        width: 40.w,
                        height: 20.h,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Text(
                                widget.analyzers[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: SoulPotTheme.spBlack,
                                  fontSize: 15.sp,
                                  fontFamily: 'Greenhouse',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            RenameDialog(
                                              analyzer:
                                                  widget.analyzers[index],
                                            )).then((value) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    primary: SoulPotTheme.spPaleGreen,
                                  ),
                                  child: Text(
                                    'Renommer',
                                    style: TextStyle(
                                      color: SoulPotTheme.spBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Greenhouse',
                                    ),
                                  ),
                                ),
                                widget.analyzers[index].paired!
                                    ? const Text("Connecté")
                                    : ElevatedButton(
                                        onPressed: () async {
                                          await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) =>
                                                  AnalyzerPairingDialog(
                                                    analyzer: widget
                                                        .analyzers[index],
                                                  )).then(
                                              (value) => setState(() {}));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          primary: SoulPotTheme.spBT,
                                        ),
                                        child: Text(
                                          'Paramètrer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Greenhouse',
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: const AnalyzerCountPickerView(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.spPaleRed,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 2.h),
                        ),
                        child: Text(
                          "Précédent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.spBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          bool allArePaired = true;
                          for (var analyzer in widget.analyzers) {
                            if (!analyzer.paired! || analyzer.paired == null) {
                              allArePaired = false;
                            }
                          }
                          if (!allArePaired) {
                            snackBarCreator(
                                context,
                                "Tous les analyzers n'ont pas été configurés",
                                SoulPotTheme.spPaleRed);
                          } else {
                            await Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const SignInView(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.spPaleGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 2.h),
                        ),
                        child: Text(
                          "Continuer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.spBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                    ],
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
