import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/firebase_management/firestore.dart';
import 'package:soulpot/plants_viewer/widgets/plant_viewer.dart';

import '../../models/analyzer.dart';
import '../../models/plant.dart';
import '../../global/utilities/theme.dart';
import '../widgets/disconnect_dialog.dart';

class PlantsView extends StatefulWidget {
  const PlantsView({Key? key, required this.codex}) : super(key: key);

  final List<Plant> codex;

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  List<Analyzer> userAnalyzers = [];
  List<Widget> viewers = [];
  final PageController _pageController = PageController();
  List<Plant> userPlants = [];
  final ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

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
                return snapshot.data!.docs.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              child: Image.asset(
                                "assets/images/LogoSoulPot.png",
                                height: 25.h,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: Text(
                                "Aucun analyzer n'a été configuré pour votre compte.\n\nRendez vous dans l'onglet Analyzers pour en configurer un.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Greenhouse"),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) =>
                                        const DisconnectDialog());
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                primary: SoulPotTheme.spRed,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 3.w),
                                child: Text(
                                  "Déconnexion",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: SoulPotTheme.spBackgroundWhite,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        pageSnapping: true,
                        onPageChanged: (index) {
                          _pageNotifier.value = index;
                        },
                        itemBuilder: (context, position) {
                          final document = snapshot.data!.docs[position];
                          Plant plant = widget.codex
                              .where((element) =>
                                  element.plantID == document["plantID"])
                              .first;
                          return Column(
                            children: [
                              PlantViewer(
                                analyzer: Analyzer(
                                  document["name"],
                                  true,
                                  id: document.id,
                                  temperature: document
                                          .data()
                                          .toString()
                                          .contains("temperature")
                                      ? document["temperature"].toInt()
                                      : -255,
                                  humidity: document
                                          .data()
                                          .toString()
                                          .contains("humidity")
                                      ? document["humidity"].toInt()
                                      : -255,
                                  luminosity: document
                                          .data()
                                          .toString()
                                          .contains("luminosity")
                                      ? document["luminosity"].toInt()
                                      : -255,
                                  wifiName: document["wifiName"],
                                  imageURL: plant.gifURL,
                                  recommendations: plant.recommendations,
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.h),
                              child: Row(
                                  children: [
                                    const Spacer(),
                                    CirclePageIndicator(
                                      currentPageNotifier: _pageNotifier,
                                      itemCount: snapshot.data!.docs.length,
                                      size: 10,
                                      selectedSize: 12,
                                      selectedDotColor: SoulPotTheme.spGreen,
                                      dotColor: Colors.grey,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
            }
          },
        ),
      ),
    );
  }
}
