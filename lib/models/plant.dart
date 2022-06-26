import 'recommendations.dart';

class Plant {

  String plantID;
  String alias;
  String display_pid;
  String gifURL;
  String? family;
  String? recoText;
  String? shortDescription;

  Recommendations recommendations;

  Plant(this.plantID, this.alias, this.display_pid, this.gifURL, this.recommendations, [this.family, this.recoText, this.shortDescription]);
}