import 'package:soulpot/models/Recommendations.dart';

class Analyzer {
  Analyzer(this.name, this.paired,
      {this.battery, this.temperature, this.humidity, this.luminosity, this.wifiName, this.recommendations});

  String name;
  bool paired;
  int? battery;
  int? temperature;
  int? luminosity;
  int? humidity;
  String? wifiName;
  Recommendations? recommendations;
}
