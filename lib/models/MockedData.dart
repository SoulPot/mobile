import 'package:soulpot/models/Analyzer.dart';
import 'package:soulpot/models/Recommendations.dart';

class MockedData {
  static Analyzer analyzer1 = Analyzer(
    "Analyzer Acacia",
    true,
    battery: 100,
    temperature: 23,
    humidity: 98,
    luminosity: 2050,
    wifiName: "Livebox-14A0",
    recommendations: Recommendations([22, 27],[40, 50],[1000, 2000]),
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
}
