import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/views/analyzer_configuration/analyzer_count_picker_view.dart';
import 'package:soulpot/views/authentication/sign_in_view.dart';
import 'package:soulpot/widgets/single/analyzer_pairing_dialog.dart';
import 'package:soulpot/widgets/single/custom_snackbar.dart';
import 'package:soulpot/widgets/single/analyzer_rename_dialog.dart';
import 'package:sizer/sizer.dart';

import '../../models/Analyzer.dart';

class AnalyzerSetupView extends StatefulWidget {
  const AnalyzerSetupView({Key? key, required List<Analyzer> analyzers})
      : _analyzers = analyzers,
        super(key: key);

  final List<Analyzer> _analyzers;

  @override
  State<AnalyzerSetupView> createState() =>
      _AnalyzerSetupViewState();
}

class _AnalyzerSetupViewState extends State<AnalyzerSetupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          width: 100.w,
          child: SafeArea(
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: List.generate(widget._analyzers.length, (index) {
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: SoulPotTheme.SPPalePurple,
                          border: Border.all(
                            color: SoulPotTheme.SPPalePurple,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        width: 40.w,
                        height: 20.h,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Text(
                                '${widget._analyzers[index].name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: SoulPotTheme.SPBlack,
                                  fontSize: 15.sp,
                                  fontFamily: 'Greenhouse',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Spacer(),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            RenameDialog(
                                              analyzer:
                                                  widget._analyzers[index],
                                            )).then((value) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    primary: SoulPotTheme.SPPaleGreen,
                                  ),
                                  child: Text(
                                    'Renommer',
                                    style: TextStyle(
                                      color: SoulPotTheme.SPBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Greenhouse',
                                    ),
                                  ),
                                ),
                                widget._analyzers[index].paired!
                                    ? Text("Connecté")
                                    : ElevatedButton(
                                        onPressed: () async {
                                          await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) =>
                                                  AnalyzerPairingDialog(
                                                    analyzer: widget
                                                        ._analyzers[index],
                                                  )).then(
                                              (value) => setState(() {}));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                          primary: SoulPotTheme.SPBT,
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
                            Spacer(),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: AnalyzerCountPickerView(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.SPPaleRed,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 2.h),
                        ),
                        child: Text(
                          "Précédent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.SPBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          bool allArePaired = true;
                          widget._analyzers.forEach((analyzer) {
                            if (!analyzer.paired! || analyzer.paired == null) {
                              allArePaired = false;
                            }
                          });
                          if (!allArePaired) {
                            snackBarCreator(
                                context,
                                "Tous les analyzers n'ont pas été configurés",
                                SoulPotTheme.SPPaleRed);
                          } else {
                            await Navigator.of(context).push(
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: SignInView(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.SPPaleGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 2.h),
                        ),
                        child: Text(
                          "Continuer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: SoulPotTheme.SPBlack,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
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
