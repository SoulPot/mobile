import 'recommendations.dart';

class Plant {
  String plantID;
  String alias;
  String displayPID;
  String gifURL;
  String? family;
  String? recoText;
  String? shortDescription;
  String? origin;
  String? infos;
  String? height;
  String? flowerColor;
  String? cutting;
  String? sowing;
  String? floweringSeason;
  String? pictureURL;
  String? plantType;
  String? plantingSeason;

  Recommendations recommendations;

  Plant(this.plantID, this.alias, this.displayPID, this.gifURL,
      this.recommendations,
      [this.family,
      this.recoText,
      this.shortDescription,
      this.origin,
      this.infos,
      this.height,
      this.flowerColor,
      this.cutting,
      this.sowing,
      this.floweringSeason,
      this.pictureURL,
      this.plantType,
      this.plantingSeason]);
}
