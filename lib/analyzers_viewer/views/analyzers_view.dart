import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/analyzers_viewer/widgets/add_analyzer_dialog.dart';
import 'package:soulpot/models/analyzer.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';

import '../../models/plant.dart';
import '../../global/utilities/theme.dart';
import '../widgets/analyzer_infos_card.dart';

class AnalyzersView extends StatefulWidget {
  const AnalyzersView({Key? key, required this.codex}) : super(key: key);

  final List<Plant> codex;

  @override
  State<AnalyzersView> createState() => _AnalyzersViewState();
}

class _AnalyzersViewState extends State<AnalyzersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreManager.getAnalyzersByUserID(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text('Loading...');
              default:
                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, position) {
                        final document = snapshot.data!.docs[position];
                        Plant plant = widget.codex
                            .where((element) =>
                                element.plantID == document["plantID"])
                            .first;
                        return CardInfoAnalyzer(
                          analyzer: Analyzer(
                            document["name"],
                            false,
                            id: document.id,
                            temperature: document.data().toString().contains("temperature") ? document["temperature"].toInt() : -255,
                            humidity: document.data().toString().contains("humidity") ? document["humidity"].toInt() : -255,
                            luminosity: document.data().toString().contains("luminosity") ? document["luminosity"].toInt() : -255,
                            wifiName: document["wifiName"],
                            imageURL: plant.gifURL,
                          ),
                        );
                      },
                    ),
                    snapshot.data!.docs.length < 5
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 20.w),
                            child: Align(
                              alignment: snapshot.data!.docs.isEmpty ? Alignment.center : Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AddAnalyzerDialog(
                                            codex: widget.codex,
                                          )).then((value) => setState(() {}));
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  primary: SoulPotTheme.spPurple,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: SoulPotTheme.spPaleGreen,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 3.w),
                                      child: Text(
                                        "Ajouter un analyser",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: SoulPotTheme.spBackgroundWhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
