import 'dart:math';


import 'package:soulpot/global/models/plant.dart';

import 'recommendations.dart';

class Analyzer {
  Analyzer(this.name, this.paired,
      {this.id,
      this.temperature,
      this.humidity,
      this.luminosity,
      this.wifiName,
      this.imageURL,
      this.recommendations,
      this.plant})
      : needSprinkle = recommendations != null
            ? humidity! < recommendations.recommendedHumidity.reduce(min)
            : false;
  String? id;
  String name;
  bool? paired;
  int? temperature;
  int? luminosity;
  int? humidity;
  String? imageURL;
  String? wifiName;
  Plant? plant;
  Recommendations? recommendations =
      Recommendations([20, 25], [40, 50], [1000, 2000]);
  bool needSprinkle;
}
