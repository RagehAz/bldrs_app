import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CensusFieldLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CensusFieldLine({
    @required this.phid,
    @required this.icon,
    @required this.count,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String phid;
  final String icon;
  final int count;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    final String _num = Numeric.formatNumToSeparatedKilos(
      number: count ?? 0,
      fractions: 0,
    );

    final String _text = Verse.transBake(context, phid);

    return DreamBox(
      height: 30,
      width: width,
      icon: icon,
      verse: Verse(
        text: '$_num : $_text',
        translate: false,
      ),
      iconSizeFactor: 0.7,
      bubble: false,
      color: Colorz.black50,
      verseCentered: false,
      verseWeight: VerseWeight.thin,
    );

    // return BzPgCounter(
    //   flyerBoxWidth: Scale.screenWidth(context),
    //   verse: phid,
    //   count: count,
    //   icon: icon,
    //   iconSizeFactor: 0.95,
    // );

  }
/// --------------------------------------------------------------------------
}
