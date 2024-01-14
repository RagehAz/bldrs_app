import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/components/texting/super_text/super_text.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BldrsBulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsBulletPoints({
    required this.bulletPoints,
    this.bubbleWidth,
    this.centered = false,
    this.showBottomLine = true,
    this.verseSizeFactor = 1,
    this.showDots = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Verse>? bulletPoints;
  final double? bubbleWidth;
  final bool centered;
  final bool showBottomLine;
  final double verseSizeFactor;
  final bool showDots;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: bubbleWidth,
    );

    return BulletPoints(
      boxWidth: _bubbleWidth,
      textHeight: BldrsText.superVerseRealHeight(context: context, size: 2, sizeFactor: verseSizeFactor, hasLabelBox: false),
      bulletPoints: Verse.bakeVerses(
        verses: bulletPoints,
      ),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      textDirection: UiProvider.getAppTextDir(),
      centered: centered,
      font: BldrsText.superVerseFont(VerseWeight.thin),
      showDots: showDots,
      showBottomLine: showBottomLine,
      // textColor: Colorz.blue255,
    );

  }
/// --------------------------------------------------------------------------
}
