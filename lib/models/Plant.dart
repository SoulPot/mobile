import 'package:soulpot/models/Recommendations.dart';

class Plant {

  String plantID;
  String alias;
  String gif_url;
  Recommendations recommendations;

  Plant(this.plantID, this.alias, this.gif_url, this.recommendations);
}