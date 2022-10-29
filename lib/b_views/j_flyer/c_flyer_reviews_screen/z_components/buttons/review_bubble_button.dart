import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewBubbleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleButton({
    @required this.phid,
    @required this.count,
    @required this.icon,
    @required this.onTap,
    @required this.isOn,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String phid;
  final int count;
  final String icon;
  final Function onTap;
  final bool isOn;
  // --------------------------------------------------------------------------
  /// TESTED :
  static Verse generateCounterVerse({
    @required BuildContext context,
    @required int count,
    @required String phid,
  }){

    if (phid == null){
      return null;
    }
    else {
      String _output = xPhrase(context, phid);

      final int _count = count ?? 0;

      if (_count == 0){
        // _output = xPhrase(context, phid);
      }

      else {
        final String _formattedCount = Numeric.formatNumToCounterCaliber(context, _count);
        _output = '$_formattedCount $_output';
      }

      return Verse(
        text: _output,
        translate: false,
      );
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: 30,
      icon: icon,
      verse: generateCounterVerse(
        context: context,
        count: count,
        phid: phid,
      ),
      verseWeight: isOn == true ? VerseWeight.bold : VerseWeight.thin,
      iconColor: isOn == true ? null : Colorz.white255,
      iconSizeFactor: 0.6,
      bubble: false,
      color: isOn == true ? Colorz.black150 : Colorz.white20,
      verseColor: isOn == true ? Colorz.white255 : Colorz.white255,
      onTap: onTap,
    );

  }
  // -----------------------------------------------------------------------------
}
