import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulpot/analyzers_setup/widgets/analyzer_setup_card.dart';
import 'package:soulpot/global/utilities/bluetooth_manager.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/global/utilities/mqtt_manager.dart';
import 'package:soulpot/global/utilities/theme.dart';
import 'package:soulpot/analyzers_setup/views/analyzer_count_picker_view.dart';
import 'package:soulpot/global/utilities/custom_snackbar.dart';
import 'package:sizer/sizer.dart';

import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

import '../../global/models/analyzer.dart';
import '../../global/models/plant.dart';

class AnalyzerSetupView extends StatefulWidget {
  const AnalyzerSetupView({Key? key, required this.analyzers, required this.codex})
      : super(key: key);

  final List<Analyzer> analyzers;
  final List<Plant> codex;
  @override
  State<AnalyzerSetupView> createState() => _AnalyzerSetupViewState();
}

class _AnalyzerSetupViewState extends State<AnalyzerSetupView> {

  late MQTTManager mqttManager;

  _AnalyzerSetupViewState() {
    mqttManager = MQTTManager();
    mqttManager.connect();
  }

  Future<void> previous() async {
    const String payload = "{\"reset\":\"true\"}";

    for(var i = 0; i < widget.analyzers.length; i++) {
      final analyzer = widget.analyzers[i];
      print(analyzer.id);
      mqttManager.publishMsg(payload, analyzer.id!, "");
    }

    await Navigator.of(context).push(
      PageTransition(
        type: PageTransitionType.fade,
        child: AnalyzerCountPickerView(codex: widget.codex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SafeArea(
        child: Stack(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5,
              ),
              itemCount: widget.analyzers.length,
              itemBuilder: (context, position) {
                return AnalyzerSetupCard(analyzer: widget.analyzers[position], codex: widget.codex);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: previous,
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
                          if (!analyzer.paired! || analyzer.paired == null || analyzer.plant == null) {
                            allArePaired = false;
                          }
                        }
                        if (!allArePaired) {
                          snackBarCreator(
                              context,
                              "Tous les analyzers n'ont pas été configurés",
                              SoulPotTheme.spPaleRed);
                        } else {
                          for(Analyzer analyzer in widget.analyzers) {
                            await FirestoreManager.createAnalyzer(analyzer);
                          }
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setBool('first_launch', false);
                          if(!mounted) return;
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
