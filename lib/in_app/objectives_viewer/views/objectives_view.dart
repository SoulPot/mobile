import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/objective.dart';
import '../../../global/utilities/firebase_management/authentication.dart';
import '../../../global/utilities/theme.dart';
import '../widgets/objectives_viewer.dart';

class ObjectivesView extends StatefulWidget {
  const ObjectivesView({Key? key, required this.objectives}) : super(key: key);

  final List<Objective> objectives;

  @override
  State<ObjectivesView> createState() => _ObjectivesViewState();
}

class _ObjectivesViewState extends State<ObjectivesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SoulPotTheme.spBackgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection(
                    'users/${AuthenticationManager.auth.currentUser!.uid}/objectives_owned')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Text('Loading...');
                default:
                  Map<String, dynamic> userObjectiveData = <String, dynamic>{};
                  List<Objective> ownedObjectives = [];
                  List<Objective> availableObjectives = [];

                  snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        userObjectiveData[document.id] = data;
                      })
                      .toList()
                      .cast();

                  for (var element in userObjectiveData.keys) {
                    for (int i = 0; i < widget.objectives.length; i++) {
                      if (element == widget.objectives[i].id) {
                        widget.objectives[i].owned =
                            userObjectiveData[element]["owned"];
                        if (widget.objectives[i].owned!) {
                          widget.objectives[i].ownedDate =
                              timestampToFormattedDateString(
                                  userObjectiveData[element]["ownedDate"]
                                      as Timestamp);
                          widget.objectives[i].stateValue =
                              userObjectiveData[element]["status"].toInt();
                          ownedObjectives.add(widget.objectives[i]);
                        }
                        widget.objectives[i].stateValue =
                            userObjectiveData[element]["status"].toInt();
                      }
                    }
                  }

                  availableObjectives = widget.objectives
                      .where((element) => !ownedObjectives.contains(element))
                      .toList();
                  availableObjectives
                      .sort((b, a) => a.stateValue!.compareTo(b.stateValue!));

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text(
                          "Objectifs non complétés",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: "Greenhouse",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child:
                            ObjectivesViewer(objectives: availableObjectives),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: Text(
                          "Objectifs complétés",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: "Greenhouse",
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: ObjectivesViewer(objectives: ownedObjectives),
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  String timestampToFormattedDateString(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }
}
