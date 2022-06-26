import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, position) {
                    final document = snapshot.data!.docs[position];
                    Plant plant = widget.codex
                        .where(
                            (element) => element.plantID == document["plantID"])
                        .first;
                    return CardInfoAnalyzer(
                      analyzer: Analyzer(
                        document["name"],
                        false,
                        id: document.id,
                        battery: document["battery"],
                        temperature: document["temperature"],
                        humidity: document["humidity"],
                        luminosity: document["luminosity"],
                        wifiName: document["wifiName"],
                        imageURL: plant.gifURL,
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
