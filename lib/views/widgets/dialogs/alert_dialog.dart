import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
// ----------------------------------------------------------------------
AlertDialog superAlert (BuildContext context, BuildContext ctx, dynamic error, String title) {
  return
    AlertDialog(

      title: SuperVerse(verse: title, color: Colorz.BlackBlack,),

      content: SuperVerse(
        verse: error.toString(),
        color: Colorz.BlackBlack,
        maxLines: 10,
      ),

      backgroundColor: Colorz.White,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: superBorderAll(context, 20)),
      contentPadding: EdgeInsets.all(10),
      actionsOverflowButtonSpacing: 10,
      actionsPadding: EdgeInsets.all(5),

      insetPadding: EdgeInsets.symmetric(
          vertical: (superScreenHeight(context) * 0.32), horizontal: 35
      ),

      buttonPadding: EdgeInsets.all(5),
      titlePadding: EdgeInsets.all(20),

      actions: <Widget>[

        DreamBox(
          width: 321,
          height: 50,
          color: Colorz.Yellow,
          verse: 'I Understand',
          verseColor: Colorz.BlackBlack,
          verseScaleFactor: 0.8,
          verseWeight: VerseWeight.bold,
          boxFunction: () => goBack(context),
        ),

      ],

    );
}
// ----------------------------------------------------------------------
Future<dynamic> superDialog(BuildContext context, dynamic error, String title) async {
  Future<dynamic> _dialog = showDialog(
    context: context,
    builder: (ctx)=> superAlert(context, ctx, error, title),
  );
  return _dialog;
}
// ----------------------------------------------------------------------
