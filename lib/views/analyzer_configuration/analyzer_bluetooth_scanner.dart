import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/views/analyzer_configuration/analyzer_count_picker.dart';
import 'package:soulpot/widgets/single/analyzer_pairing_dialog.dart';
import 'package:soulpot/widgets/single/custom_snackbar.dart';
import 'package:soulpot/widgets/single/rename_dialog.dart';

import '../../models/Analyzer.dart';
import 'analyzer_wifi_setup.dart';

class AnalyzerBluetoothScanner extends StatefulWidget {
  const AnalyzerBluetoothScanner({Key? key, required List<Analyzer> analyzers})
      : _analyzers = analyzers,
        super(key: key);

  final List<Analyzer> _analyzers;

  @override
  State<AnalyzerBluetoothScanner> createState() =>
      _AnalyzerBluetoothScannerState();
}

class _AnalyzerBluetoothScannerState extends State<AnalyzerBluetoothScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                '${widget._analyzers[index].name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: SoulPotTheme.SPBlack,
                                  fontSize: 20,
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
                                                    analyzer: widget
                                                        ._analyzers[index],
                                                  ))
                                          .then((value) => setState(() {}));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                    primary: SoulPotTheme.SPPaleGreen,
                                    textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: Text(
                                    'Renommer',
                                    style: TextStyle(
                                      color: SoulPotTheme.SPBlack,
                                      fontSize: 12,
                                      fontFamily: 'Greenhouse',
                                    ),
                                  ),
                                ),
                                widget._analyzers[index].paired
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
                                              ))
                                              .then((value) => setState(() {}));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                          primary: SoulPotTheme.SPBT,
                                          textStyle: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        child: Text(
                                          'Paramètrer',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
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
                              child: AnalyzerCountPicker(),
                            ),
                          );
                        },
                        child: Text(
                          "Précédent",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: SoulPotTheme.SPBlack),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.SPPaleRed,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          bool allArePaired = true;
                          widget._analyzers.forEach((element) {
                            if (!element.paired) {
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
                                child: AnalyzerWifiSetup(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Continuer",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: SoulPotTheme.SPBlack),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: SoulPotTheme.SPPaleGreen,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
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
