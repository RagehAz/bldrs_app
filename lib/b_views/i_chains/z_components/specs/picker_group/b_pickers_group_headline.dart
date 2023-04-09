import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:scale/scale.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class PickersGroupHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersGroupHeadline({
    @required this.headline,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse headline;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('PickersGroupHeadline'),
      width: width ?? Scale.screenWidth(context),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: BldrsAligners.superCenterAlignment(context),
      child: BldrsText(
        verse: headline,
        weight: VerseWeight.black,
        centered: false,
        margin: 10,
        size: 3,
        scaleFactor: 0.85,
        italic: true,
        color: Colorz.yellow125,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
