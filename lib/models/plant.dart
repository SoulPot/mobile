import 'recommendations.dart';

class Plant {

  String plantID;
  String alias;
  String display_pid;
  String gifURL;

  Recommendations recommendations;

  Plant(this.plantID, this.alias, this.display_pid, this.gifURL, this.recommendations);
}