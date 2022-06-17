import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/models/Recommendations.dart';
import 'package:soulpot/utilities/Firebase/firestore.dart';

import '../../models/Plant.dart';
import '../../theme.dart';
import '../../widgets/CardInfoAnalyzer.dart';

class AnalyzersView extends StatefulWidget {
  const AnalyzersView(List<Plant> codex, {Key? key}) :
        this._codex = codex,
        super(key: key);

  final List<Plant> _codex;
  @override
  State<AnalyzersView> createState() => _AnalyzersViewState();
}

class _AnalyzersViewState extends State<AnalyzersView> {
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
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, position) {
                    final document = snapshot.data!.docs[position];
                    Plant plant = widget._codex
                        .where(
                            (element) => element.plantID == document["plantID"])
                        .first;
                    return CardInfoAnalyzer(
                      analyzer: Analyzer(
                        document.id,
                        false,
                        battery: document["battery"],
                        temperature: document["temperature"],
                        humidity: document["humidity"],
                        luminosity: document["luminosity"],
                        wifiName: document["wifiName"],
                        imageURL: plant.gif_url,
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
