import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:soulpot/utilities/Firebase/firestore.dart';
import 'package:soulpot/widgets/single/plant_viewer.dart';

import '../../models/Analyzer.dart';
import '../../models/Plant.dart';
import '../../theme.dart';

class PlantsView extends StatefulWidget {
  const PlantsView(List<Plant> codex, {Key? key})
      : this._codex = codex,
        super(key: key);

  final List<Plant> _codex;

  @override
  State<PlantsView> createState() => _PlantsViewState();
}

class _PlantsViewState extends State<PlantsView> {
  // MOCKED DATAS
  List<Analyzer> userAnalyzers = [];
  List<Widget> viewers = [];
  PageController _pageController = PageController();
  List<Plant> userPlants = [];
  ValueNotifier<int> _pageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreManager.getAnalyzersByUserID(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length,
                  pageSnapping: false,
                  onPageChanged: (index) {
                    _pageNotifier.value = index;
                  },
                  itemBuilder: (context, position) {
                    final document = snapshot.data!.docs[position];
                    Plant plant = widget._codex
                        .where(
                            (element) => element.plantID == document["plantID"])
                        .first;
                    return Column(
                      children: [
                        PlantViewer(
                          Analyzer(
                            document.id,
                            true,
                            battery: document["battery"],
                            temperature: document["temperature"],
                            humidity: document["humidity"],
                            luminosity: document["luminosity"],
                            wifiName: document["wifiName"],
                            imageURL: plant.gif_url,
                            recommendations: plant.recommendations,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              CirclePageIndicator(
                                currentPageNotifier: _pageNotifier,
                                itemCount: snapshot.data!.docs.length,
                                size: 10,
                                selectedSize: 12,
                                selectedDotColor: SoulPotTheme.SPGreen,
                                dotColor: Colors.grey,
                              ),
                              Spacer(),
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
