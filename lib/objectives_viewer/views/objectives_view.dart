import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/models/MockedData.dart';
import 'package:soulpot/models/Objective.dart';
import 'package:soulpot/theme.dart';
import 'package:soulpot/widgets/CardObjective.dart';
import 'package:soulpot/utilities/Firebase/firestore.dart';

class ObjectivesView extends StatefulWidget {
  const ObjectivesView(List<Objective> objectives, {Key? key})
      : this.objectives = objectives,
        super(key: key);

  final List<Objective> objectives;

  @override
  State<ObjectivesView> createState() => _ObjectivesViewState();
}

class _ObjectivesViewState extends State<ObjectivesView> {
  final Stream<QuerySnapshot> _objectivesStream = FirebaseFirestore.instance
      .collection(
          'users/${FirebaseAuth.instance.currentUser!.uid}/objectives_owned')
      .snapshots();

  late int totalObjectives;
  late int objectivesOwned;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _objectivesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  Map<String, dynamic> userObjectiveData =
                      Map<String, dynamic>();

                  snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        userObjectiveData["${document.id}"] = data;
                      })
                      .toList()
                      .cast();
                  return displayCards(userObjectiveData);
                },
              )),
        ),
      ),
    );
  }

  Widget displayCards(Map<String, dynamic> userObjectiveData) {
    //Concats static objectives and user's objectives satuts
    userObjectiveData.keys.forEach((element) {
      for (int i = 0; i < widget.objectives.length; i++) {
        if (element == widget.objectives[i].id) {
          widget.objectives[i].owned = userObjectiveData[element]["owned"];
          widget.objectives[i].stateValue =
              userObjectiveData[element]["status"];
        }
      }
    });

    var ownedObjectives = [];
    var notOwnedObjectives = [];
    for (int i = 0; i < widget.objectives.length; i++) {
      if (widget.objectives[i].owned == true) {
        ownedObjectives.add(widget.objectives[i]);
      } else {
        notOwnedObjectives.add(widget.objectives[i]);
      }
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Text(
            "Objectifs à réaliser",
            style: TextStyle(fontSize: 18.sp),
          ),
        ),
        displayCardsNotOwned(notOwnedObjectives),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
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
      card = CardObjective(data[i]);
      if (i + 1 < data.length) {
        cardBis = CardObjective(data[i + 1]);
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
      card = CardObjective(data[i]);
      if (i + 1 < data.length) {
        cardBis = CardObjective(data[i+1]);
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
