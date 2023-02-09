import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';

class ZoneBubbleLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneBubbleLine({
    @required this.line,
    @required this.icon,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String line;
  final String icon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context: context);

    return DreamBox(
      height: 25,
      width: _clearWidth,
      // color: Colorz.bloodTest,
      bubble: false,
      verseItalic: true,
      verseWeight: VerseWeight.thin,
      iconSizeFactor: 0.7,
      verseScaleFactor: 0.9,
      verseMaxLines: 2,
      verseCentered: false,

      icon: icon,
      verse: Verse.plain(line),

    );

  }
  /// --------------------------------------------------------------------------
}
