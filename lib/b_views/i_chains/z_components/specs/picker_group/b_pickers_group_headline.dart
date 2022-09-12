import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PickersGroupHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersGroupHeadline({
    @required this.headline,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse headline;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('PickersGroupHeadline'),
      width: Scale.superScreenWidth(context),
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
