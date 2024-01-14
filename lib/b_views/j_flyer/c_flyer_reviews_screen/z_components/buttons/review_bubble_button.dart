import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class ReviewBubbleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleButton({
    required this.phid,
    required this.count,
    required this.icon,
    required this.onTap,
    required this.isOn,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? phid;
  final int? count;
  final String icon;
  final Function onTap;
  final bool isOn;
  // --------------------------------------------------------------------------
  /// TESTED :
  static Verse? generateCounterVerse({
    required BuildContext context,
    required int? count,
    required String? phid,
  }){

    if (phid == null){
      return null;
    }
    else {
      String? _output = getWord(phid);

      final int _count = count ?? 0;

      if (_count == 0){
        // _output = word(phid);
      }

      else {
        final String? _formattedCount = getCounterCaliber(_count);
        _output = '$_formattedCount $_output';
      }

      return Verse(
        id: _output,
        translate: false,
      );
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: 38,
      // width: 80,
      icon: icon,
      verse: generateCounterVerse(
        context: context,
        count: count,
        phid: phid,
      ),
      verseWeight: isOn == true ? VerseWeight.bold : VerseWeight.thin,
      iconColor: isOn == true ? null : Colorz.white255,
      iconSizeFactor: 0.55,
      verseScaleFactor: 0.8 / 0.6,
      bubble: false,
      color: isOn == true ? Colorz.black150 : Colorz.white20,
      verseColor: isOn == true ? Colorz.white255 : Colorz.white255,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
