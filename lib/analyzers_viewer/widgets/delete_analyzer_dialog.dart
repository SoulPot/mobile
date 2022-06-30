import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/global/utilities/firebase_management/authentication.dart';
import 'package:soulpot/global/utilities/mqtt_manager.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

import '../../models/analyzer.dart';

class DeleteAnalyzerDialog extends StatefulWidget {
  const DeleteAnalyzerDialog({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;
  @override
  State<DeleteAnalyzerDialog> createState() => _DeleteAnalyzerDialogState();
}

class _DeleteAnalyzerDialogState extends State<DeleteAnalyzerDialog> {

  late MQTTManager mqttManager;

  _DeleteAnalyzerDialogState() {
    mqttManager = MQTTManager();
    mqttManager.connect();
  }

  void resetAnalyzer() {
    String? deviceId = widget.analyzer.id;
    if (deviceId == null) {
      print('ERROR: no device id set');
      return;
    }
    String payload = "{\"reset\":\"true\"}";
    mqttManager.publishMsg(payload, deviceId, "");
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        height: 25.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Suppression de ${widget.analyzer.name}',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'Greenhouse',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              'Cette action entrainera la remise à zéro de l\'analyser, êtes-vous sûr ?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Greenhouse',
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                TextButton(
                  child: Text('Annuler',
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp)),
                  onPressed: () => Navigator.pop(context, false),
                ),
                const Spacer(),
                TextButton(
                    onPressed: resetAnalyzer,
                    child: Text(
                      'Supprimer',
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
