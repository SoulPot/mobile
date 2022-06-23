import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:soulpot/sign_in_sign_up/views/sign_in_view.dart';

class DisconnectDialog extends StatefulWidget {
  const DisconnectDialog({Key? key}) : super(key: key);

  @override
  State<DisconnectDialog> createState() => _DisconnectDialogState();
}

class _DisconnectDialogState extends State<DisconnectDialog> {
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
              'Déconnexion',
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Greenhouse',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              'Vous allez être déconnecté, êtes-vous sûr ?',
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                TextButton(
                    child: Text(
                      'Déconnexion',
                      style: TextStyle(
                          fontFamily: "Greenhouse",
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                              alignment: Alignment.bottomCenter,
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeftWithFade,
                              child: const SignInView(),
                              childCurrent: context.widget),
                          (route) => false);
                    }),
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
