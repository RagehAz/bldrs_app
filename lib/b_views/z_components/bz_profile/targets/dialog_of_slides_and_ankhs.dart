import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:scale/scale.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class DialogOfSlidesAndAnkhs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogOfSlidesAndAnkhs({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  static Future<void> show({BuildContext context}) async {
    await CenterDialog.showCenterDialog(
      height: Scale.screenHeight(context) - Ratioz.appBarMargin * 4,
      confirmButtonVerse: Verse.plain('Tamam'),
      titleVerse: Verse.plain('Ankhs & Slides'),
      bodyVerse: Verse.plain('Blah blah blah'),
      child: Column(
        children: const <Widget>[
          BldrsText(
            verse: Verse(
              id: 'Blo blo blo',
              translate: false,
            ),
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
        BldrsText(
          verse:  Verse(
            id: 'Blo blo blo',
            translate: false,
          ),
          size: 1,
        ),
      ],
    );
  }
  /// --------------------------------------------------------------------------
}
