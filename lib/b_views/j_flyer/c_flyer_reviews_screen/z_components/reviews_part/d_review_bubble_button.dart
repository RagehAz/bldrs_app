import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ReviewBubbleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubbleButton({
    @required this.verse,
    @required this.count,
    @required this.icon,
    @required this.onTap,
    @required this.isOn,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final int count;
  final String icon;
  final Function onTap;
  final bool isOn;
  /// --------------------------------------------------------------------------
  static String generateCounterVerse({
    @required BuildContext context,
    @required int count,
    @required String verse,
  }){

    String _output = verse;

    final int _count = count ?? 0;

    if (_count == 0){
      _output = verse;
    }

    else {
      final String _formattedCount = Numeric.formatNumToCounterCaliber(context, _count);
      _output = '$_formattedCount $verse';
    }

    return _output;
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
        verse: verse,
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
