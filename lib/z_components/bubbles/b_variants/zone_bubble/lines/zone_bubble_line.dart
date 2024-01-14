import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ZoneBubbleLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ZoneBubbleLine({
    required this.line,
    required this.icon,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? line;
  final String? icon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _clearWidth = Bubble.clearWidth(context: context);

    return BldrsBox(
      height: 30,
      width: _clearWidth,
      // color: Colorz.bloodTest,
      bubble: false,
      verseItalic: true,
      verseWeight: VerseWeight.thin,
      iconSizeFactor: 0.7,
      verseScaleFactor: 1/0.7,
      verseMaxLines: 2,
      verseCentered: false,
      icon: icon,
      verse: Verse.plain(line),

    );

  }
  /// --------------------------------------------------------------------------
}
