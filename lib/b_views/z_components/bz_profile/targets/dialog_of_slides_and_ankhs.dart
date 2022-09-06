import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DialogOfSlidesAndAnkhs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogOfSlidesAndAnkhs({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static Future<void> show({BuildContext context}) async {
    await CenterDialog.showCenterDialog(
      context: context,
      height: Scale.superScreenHeight(context) - Ratioz.appBarMargin * 4,
      confirmButtonVerse:  'Tamam',
      titleVerse:  'Ankhs & Slides',
      bodyVerse:  'Blah blah blah',
      child: Column(
        children: const <Widget>[
          SuperVerse(
            verse:  'Blo blo blo',
            size: 1,
          ),
        ],
      ),
    );
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SuperVerse(
          verse:  'Blo blo blo',
          size: 1,
        ),
      ],
    );
  }
  /// --------------------------------------------------------------------------
}
