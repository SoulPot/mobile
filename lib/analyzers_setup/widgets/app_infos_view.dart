import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';

class AppInfosView extends StatelessWidget {
  const AppInfosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: SoulPotTheme.spGreen,
                    size: 10.w,
                  )),
            ),
            const Center(
              child: Text('AppInfosView'),
            ),
          ],
        ),
      ),
    );
  }
}
