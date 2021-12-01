import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DialogOfSlidesAndAnkhs extends StatelessWidget {
  const DialogOfSlidesAndAnkhs({Key key}) : super(key: key);

  static Future<void> show({BuildContext context}) async {

    await CenterDialog.showCenterDialog(
      context: context,
      height: Scale.superScreenHeight(context) - Ratioz.appBarMargin * 4,
      boolDialog: false,
      confirmButtonText: 'Tamam',
      title: 'Ankhs & Slides',
      body: 'Blah blah blah',
      child: Column(
        children: <Widget>[

          SuperVerse(
            verse: 'Blo blo blo',
            size: 1,
          ),

        ],
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        SuperVerse(
          verse: 'Blo blo blo',
          size: 1,
        ),

      ],
    );
  }
}
