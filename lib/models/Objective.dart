
import 'dart:ui';

class Objective{
  Objective(this.label, this.description, this.backgroundColor, this.fontColor, this.objectiveValue, this.stateValue, this.owned);
  final String label;
  final String description;
  final Color backgroundColor;
  final Color fontColor;
  final int objectiveValue;
  final int stateValue;
  final bool owned;
}