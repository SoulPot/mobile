import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/views/analyzer_page.dart';
import 'package:soulpot/views/informations_page.dart';
import 'package:soulpot/views/objectives_page.dart';
import 'MyPlant_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  Widget _analyzerPage = AnalyzerPage();
  Widget _informationPage = InformationPage();
  Widget _mainPage = MyPlantPage();
  Widget _objectivePage = ObjectivePage();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        selectedItemColor: Color(0xff178C23),
        unselectedItemColor: Color(0xffB5EF85),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "Analyzer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_heart),
            label: "Informations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: "Ma Plante",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified),
            label: "Objectifs",
          )
        ],
      onTap: (int index) {
        this.onTapHandler(index);
      },
      ),
    );
  }

  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._analyzerPage;
    } else if(this.selectedIndex==1) {
      return this._informationPage;
    } else if(this.selectedIndex==2) {
      return this._mainPage;
    } else {
      return this._objectivePage;
    }
  }

  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

}
