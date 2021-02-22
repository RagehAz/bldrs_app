import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/bt_back.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

AlertDialog superAlert (BuildContext context, BuildContext ctx, dynamic error) {
  return
    AlertDialog(
      title: SuperVerse(verse: 'error man', color: Colorz.BlackBlack,),
      content: SuperVerse(verse: 'error is : ${error.toString()}',
        color: Colorz.BlackBlack,
        maxLines: 10,),
      backgroundColor: Colorz.Grey,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
      contentPadding: EdgeInsets.all(10),
      actionsOverflowButtonSpacing: 10,
      actionsPadding: EdgeInsets.all(5),
      insetPadding: EdgeInsets.symmetric(
          vertical: (superScreenHeight(context) * 0.32), horizontal: 35),
      buttonPadding: EdgeInsets.all(5),
      titlePadding: EdgeInsets.all(20),
      actions: <Widget>[BldrsBackButton(onTap: () => goBack(ctx)),],
    );
}