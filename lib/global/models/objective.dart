import 'dart:ui';

class Objective{
  Objective(this.id, this.label, this.description, this.backgroundColor, this.fontColor, this.objectiveValue, this.type, {int? pStateValue, String? ownedDate, this.owned}) {
    stateValue = pStateValue ?? 0;
    owned = owned ?? false;
    if (owned == true) {
      ownedDate = ownedDate;
    }
  }

  final String id;
  final String label;
  final String description;
  final Color backgroundColor;
  final Color fontColor;
  final int objectiveValue;
  final String type;
  String? ownedDate;
  int? stateValue;
  bool? owned;
}