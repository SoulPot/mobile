import 'package:flutter/material.dart';
import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/models/Objective.dart';
import 'package:soulpot/models/Recommendations.dart';
import 'package:soulpot/theme.dart';

class MockedData {
  static Analyzer analyzer1 = Analyzer(
    "Analyzer Acacia",
    true,
    battery: 100,
    temperature: 23,
    humidity: 4,
    luminosity: 1002,
    wifiName: "Livebox-14A0",
    recommendations: Recommendations([22, 27], [40, 50], [100000, 200000]),
  );

  static Analyzer analyzer2 = Analyzer(
    "Analyzer Tomates",
    true,
    battery: 10,
    temperature: 2,
    humidity: 75,
    luminosity: 500,
    wifiName: "uifeedu75",
  );

  static Analyzer analyzer3 = Analyzer(
    "Analyzer Laurier",
    true,
    battery: 15,
    temperature: 25,
    humidity: 50,
    luminosity: 1000,
    wifiName: "Livebox-14A0",
  );

  static Analyzer analyzer4 = Analyzer(
    "Analyzer Sapin",
    true,
    battery: 45,
    temperature: 37,
    humidity: 90,
    luminosity: 50000,
    wifiName: "Livebox-14A0",
  );

  static List<Objective> objectives = [
    Objective( "1",
        "Analyzer Neophyte ", "Avoir 2 Analyzers en fonction", SoulPotTheme.SPRedPale,
        SoulPotTheme.SPBlack, 2, "easy"),
    Objective( "2",
        "Analyzer Pro", "Posséder 5 Analyzers", SoulPotTheme.SPRed,
        SoulPotTheme.SPBlack, 5, "hard"),
    Objective( "3",
        "Analyzer Neophyte ", "descritpzssdvgfwdfb", SoulPotTheme.SPRedPale,
        SoulPotTheme.SPBlack, 5, "advanced"),
    Objective( "4",
        "Analyzer Débutant", "Posséder un Analyzer", SoulPotTheme.SPGreen,
        Colors.white70, 1, "easy"),
  ];
}
