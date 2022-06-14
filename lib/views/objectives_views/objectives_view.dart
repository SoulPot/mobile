import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/MockedData.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/widgets/CardObjective.dart';

class ObjectivesView extends StatefulWidget {
  const ObjectivesView({Key? key}) : super(key: key);

  @override
  State<ObjectivesView> createState() => _ObjectivesViewState();
}

class _ObjectivesViewState extends State<ObjectivesView> {
  late int totalObjectives;
  late int objectivesOwned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: displayCard(),
          ),
        ),
      ),
    );
  }

  displayCard() {
    var data = MockedData.objectives;
    var ownedObjectives = [];
    var notOwnedObjectives = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].owned == true) {
        ownedObjectives.add(data[i]);
      } else {
        notOwnedObjectives.add(data[i]);
      }
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            "Objectifs à réaliser",
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        displayCardsNotOwned(notOwnedObjectives),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8),
          child: Text(
            "Objectifs Réalisés",
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        displayCardsOwned(ownedObjectives),
      ],
    );
  }

  displayCardsOwned(data) {
    var rows = <Widget>[];

    for (int i = 0; i < data.length; i += 2) {
      var card, cardBis;
      card = CardObjective(
          label: data[i].label,
          description: data[i].description,
          backgroundColor: data[i].backgroundColor,
          fontColor: data[i].fontColor,
          objectiveValue: data[i].objectiveValue,
          stateValue: data[i].stateValue);
      if (i + 1 < data.length) {
        cardBis = CardObjective(
            label: data[i + 1].label,
            description: data[i + 1].description,
            backgroundColor: data[i + 1].backgroundColor,
            fontColor: data[i + 1].fontColor,
            objectiveValue: data[i + 1].objectiveValue,
            stateValue: data[i + 1].stateValue);
      } else {
        //Yen a pas
        cardBis = Container();
      }

      var rowUnique = Row(
        children: [card, cardBis],
      );
      rows.add(rowUnique);
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center, children: rows);
  }

  displayCardsNotOwned(data) {
    var rows = <Widget>[];

    for (int i = 0; i < data.length; i += 2) {
      var card, cardBis;
      card = CardObjective(
          label: data[i].label,
          description: data[i].description,
          backgroundColor: data[i].backgroundColor,
          fontColor: data[i].fontColor,
          objectiveValue: data[i].objectiveValue,
          stateValue: data[i].stateValue);
      if (i + 1 < data.length) {
        cardBis = CardObjective(
            label: data[i + 1].label,
            description: data[i + 1].description,
            backgroundColor: data[i + 1].backgroundColor,
            fontColor: data[i + 1].fontColor,
            objectiveValue: data[i + 1].objectiveValue,
            stateValue: data[i + 1].stateValue);
      } else {
        //Yen a pas
        cardBis = Container();
      }

      var rowUnique = Row(
        children: [card, cardBis],
      );
      rows.add(rowUnique);
    }

    return Column(children: rows);
  }
}
