import 'dart:ui';

class Objective{
  Objective(this.id, this.label, this.description, this.backgroundColor, this.fontColor, this.objectiveValue, this.type, {this.stateValue, this.owned});
  final String id;
  final String label;
  final String description;
  final Color backgroundColor;
  final Color fontColor;
  final int objectiveValue;
  final String type;
  int? stateValue;
  bool? owned;
}