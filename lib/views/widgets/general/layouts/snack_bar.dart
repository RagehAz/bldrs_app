import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, AnimationController _snackController) {
  double screenHeight = Scale.superScreenHeight(context);
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colorz.BloodTest,
    shape: RoundedRectangleBorder(
        borderRadius: Borderers.superBorderOnly(context: context, enTopLeft: 20, enBottomLeft: 0, enBottomRight: 0, enTopRight: 20)),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    content: SuperVerse(
      verse: 'wtf',
      labelColor: Colorz.BloodTest,
    ),
    duration: Duration(seconds: 2),
    animation: CurvedAnimation(
      parent: _snackController,
      curve: Curves.easeIn,
    ),
    action: SnackBarAction(
      label: 'koko',
      onPressed: () {},
    ),

    margin: EdgeInsets.only(top: screenHeight * 0.5),
  ));
}
