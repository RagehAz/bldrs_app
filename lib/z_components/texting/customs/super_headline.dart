import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SuperHeadline extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const SuperHeadline({
    required this.verse,
    this.width,
    this.color = Colorz.white255,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Verse verse;
  final double? width;
  final Color color;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: BldrsText(
        verse: verse,
        width: width ?? Bubble.bubbleWidth(context: context),
        size: 5,
        maxLines: 2,
        color: color,
        centered: false,
        margin: 20,
        shadow: true,
        italic: true,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
