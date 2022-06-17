import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/utilities/Firebase/firestore.dart';
import 'package:soulpot/views/analyzers_views/analyzers_view.dart';
import 'package:soulpot/views/recommendations_views/recommendations_view.dart';
import 'package:soulpot/views/objectives_views/objectives_view.dart';
import '../models/Analyzer.dart';
import '../models/Plant.dart';
import '../theme.dart';
import 'plants_views/plants_view.dart';

class HomeView extends StatefulWidget {
  const HomeView(List<Plant> codex, {Key? key})
      : this.codex = codex,
        super(key: key);

  final List<Plant> codex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this._selectedIndex,
        selectedItemColor: SoulPotTheme.SPPurple,
        unselectedItemColor: SoulPotTheme.SPGreen,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: "Plantes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "Analyzers",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: "Codex",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified),
            label: "Objectifs",
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget getBody() {
    if (this._selectedIndex == 0) {
      return PlantsView(widget.codex);
    } else if (this._selectedIndex == 1) {
      return AnalyzersView(widget.codex);
    } else if (this._selectedIndex == 2) {
      return RecommendationsView();
    } else {
      return ObjectivesView();
    }
  }
}
