import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/MockedData.dart';

import '../../theme.dart';
import '../../widgets/CardInfoAnalyzer.dart';

class AnalyzersView extends StatefulWidget {
  const AnalyzersView({Key? key}) : super(key: key);

  @override
  State<AnalyzersView> createState() => _AnalyzersViewState();
}

class _AnalyzersViewState extends State<AnalyzersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.SPBackgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CardInfoAnalyzer(
                analyzer: MockedData.analyzer1,
              ),
              CardInfoAnalyzer(
                analyzer: MockedData.analyzer1,
              ),
              CardInfoAnalyzer(
                analyzer: MockedData.analyzer1,
              ),
              CardInfoAnalyzer(
                analyzer: MockedData.analyzer1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                child: ElevatedButton(
                  onPressed: () {
                    //TODO
                  },
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    primary: SoulPotTheme.SPPaleGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: SoulPotTheme.SPPurple,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, bottom: 0.3.h),
                        child: Text(
                          "Ajouter un Analyzer",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: SoulPotTheme.SPPurple,
                            fontFamily: "Greenhouse",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
