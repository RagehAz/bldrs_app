import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class RemainingSlidesCounter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RemainingSlidesCounter({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const int _numberOfSlides = 125;

    return BldrsBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 1.3,
      verse: Verse(
          id:   '$_numberOfSlides '
                '${getWord('phid_slides')}',
          translate: false
      ),
      verseItalic: true,
      verseMaxLines: 2,
      verseScaleFactor: 0.5,
      secondLine: const Verse(
        id: 'phid_available',
        translate: true,
      ),
      secondLineScaleFactor: 0.9,
      verseCentered: false,
      bubble: false,
      color: Colorz.white20,
      onTap: () async {
        final dynamic _result = await BldrsCenterDialog.showCenterDialog(
          boolDialog: true,
          titleVerse: const Verse(
            id: 'phid_no_slides_left',
            translate: true,
          ),
          bodyVerse: const Verse(
            pseudo: "You don't have any more slides to add\nWould you wish to get more slides ?",
            id: 'phid_no_slides_left_description',
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
