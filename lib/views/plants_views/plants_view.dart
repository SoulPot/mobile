import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  List<Plant> userPlants = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Analyzer> userAnalyzers = [];
    List<Widget> viewers = [];
    PageController _pageController = PageController(initialPage: 0);

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
                  itemBuilder: (context, position) {
                    final document = snapshot.data!.docs[position];
                    Plant plant = widget._codex
                        .where(
                            (element) => element.plantID == document["plantID"])
                        .first;
                    return PlantViewer(
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
