import 'recommendations.dart';

class Plant {
  String plantID;
  String alias;
  String display_pid;
  String gifURL;
  String? family;
  String? recoText;
  String? shortDescription;
  String? origin;
  String? infos;
  String? height;
  String? flower_color;
  String? cutting;
  String? sowing;
  String? flowering_season;
  String? picture_url;
  String? plant_type;
  String? planting_season;

  Recommendations recommendations;

  Plant(this.plantID, this.alias, this.display_pid, this.gifURL,
      this.recommendations,
      [this.family,
      this.recoText,
      this.shortDescription,
      this.origin,
      this.infos,
      this.height,
      this.flower_color,
      this.cutting,
      this.sowing,
      this.flowering_season,
      this.picture_url,
      this.plant_type,
      this.planting_season]);
}
