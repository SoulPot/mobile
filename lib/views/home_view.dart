import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/views/analyzers_views/analyzers_view.dart';
import 'package:soulpot/views/recommendations_views/recommendations_view.dart';
import 'package:soulpot/views/objectives_views/objectives_view.dart';
import '../theme.dart';
import 'plants_views/plants_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  Widget _analyzerPage = AnalyzersView();
  Widget _informationPage = RecommendationsView();
  Widget _mainPage = PlantsView();
  Widget _objectivePage = ObjectivesView();

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
      return this._mainPage;
    } else if (this._selectedIndex == 1) {
      return this._analyzerPage;
    } else if (this._selectedIndex == 2) {
      return this._informationPage;
    } else {
      return this._objectivePage;
    }
  }
}
