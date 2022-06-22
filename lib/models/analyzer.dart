import 'dart:math';

import 'recommendations.dart';

class Analyzer {
  Analyzer(this.name, this.paired,
      {this.battery,
      this.temperature,
      this.humidity,
      this.luminosity,
      this.wifiName,
      this.imageURL,
      this.recommendations})
      : needSprinkle = recommendations != null
            ? humidity! < recommendations.recommendedHumidity.reduce(min)
            : false;
  String name;
  bool? paired;
  int? battery;
  int? temperature;
  int? luminosity;
  int? humidity;
  String? imageURL;
  String? wifiName;
  Recommendations? recommendations =
      Recommendations([20, 25], [40, 50], [1000, 2000]);
  bool needSprinkle;
}
