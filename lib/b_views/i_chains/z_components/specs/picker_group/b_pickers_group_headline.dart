import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
      width: width ?? Scale.superScreenWidth(context),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Aligners.superCenterAlignment(context),
      child: SuperVerse(
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
