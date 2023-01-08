import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';


import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class RemainingSlidesCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RemainingSlidesCounter({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const int _numberOfSlides = 125;

    return DreamBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 1.3,
      verse: Verse(
          text: '$_numberOfSlides '
                '${Verse.transBake(context, 'phid_slides')}',
          translate: false
      ),
      verseItalic: true,
      verseMaxLines: 2,
      verseScaleFactor: 0.5,
      secondLine: const Verse(
        text: 'phid_available',
        translate: true,
      ),
      secondLineScaleFactor: 0.9,
      verseCentered: false,
      bubble: false,
      color: Colorz.white20,
      onTap: () async {
        final dynamic _result = await CenterDialog.showCenterDialog(
          context: context,
          boolDialog: true,
          titleVerse: const Verse(
            text: 'phid_no_slides_left',
            translate: true,
          ),
          bodyVerse: const Verse(
            pseudo: "You don't have any more slides to add\nWould you wish to get more slides ?",
            text: 'phid_no_slides_left_description',
            translate: true,
          ),
        );

        if (_result == false) {
          blog('No');
        } else {
          blog('yes');
        }
      },
    );
  }
/// --------------------------------------------------------------------------
}
