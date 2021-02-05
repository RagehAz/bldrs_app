import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, AnimationController _snackController) {
  double screenHeight = superScreenHeight(context);
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: Colorz.BloodTest,
    shape: RoundedRectangleBorder(
        borderRadius: superBorderRadius(context, 20, 0, 0, 20)),
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
