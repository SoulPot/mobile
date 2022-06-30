import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../global/models/analyzer.dart';


class DeleteAnalyzerDialog extends StatefulWidget {
  const DeleteAnalyzerDialog({Key? key, required this.analyzer}) : super(key: key);

  final Analyzer analyzer;
  @override
  State<DeleteAnalyzerDialog> createState() => _DeleteAnalyzerDialogState();
}

class _DeleteAnalyzerDialogState extends State<DeleteAnalyzerDialog> {
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
                    child: Text(
                      'Supprimer',
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  onPressed: () => Navigator.pop(context, true),
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
