import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
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

    final double _width = width ?? Bubble.bubbleWidth(context: context);

    return Center(
      child: Container(
        key: const ValueKey<String>('PickersGroupHeadline'),
        width: _width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: BldrsAligners.superCenterAlignment(context),
        child: BldrsText(
          width: _width - 40,
          verse: headline,
          weight: VerseWeight.black,
          centered: false,
          margin: 10,
          size: 3,
          scaleFactor: 0.85,
          italic: true,
          color: Colorz.yellow125,
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
