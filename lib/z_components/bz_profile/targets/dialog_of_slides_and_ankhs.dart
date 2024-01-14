import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

class DialogOfSlidesAndAnkhs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DialogOfSlidesAndAnkhs({
    super.key
  });
  /// --------------------------------------------------------------------------
  static Future<void> show({
    required BuildContext context,
  }) async {
    await BldrsCenterDialog.showCenterDialog(
      height: Scale.screenHeight(context) - Ratioz.appBarMargin * 4,
      confirmButtonVerse: Verse.plain('Tamam'),
      titleVerse: Verse.plain('Ankhs & Slides'),
      bodyVerse: Verse.plain('Blah blah blah'),
      child: const Column(
        children: <Widget>[
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
    return const Column(
      children: <Widget>[
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
