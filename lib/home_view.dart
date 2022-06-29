import 'package:flutter/material.dart';
import 'package:soulpot/plants_viewer/views/plants_view.dart';
import '../models/objective.dart';
import '../models/plant.dart';
import 'analyzers_viewer/views/analyzers_view.dart';
import 'codex_viewer/views/codex_view.dart';
import 'global/utilities/theme.dart';
import 'objectives_viewer/views/objectives_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.codex, required this.objectives})
      : super(key: key);

  final List<Plant> codex;
  final List<Objective> objectives;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: SoulPotTheme.spPurple,
        unselectedItemColor: SoulPotTheme.spGreen,
        items: const [
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
    if (_selectedIndex == 0) {
      return PlantsView(codex: widget.codex);
    } else if (_selectedIndex == 1) {
      return AnalyzersView(codex: widget.codex);
    } else if (_selectedIndex == 2) {
      return CodexView(codex: widget.codex);
    } else {
      return ObjectivesView(objectives: widget.objectives);
    }
  }
}
