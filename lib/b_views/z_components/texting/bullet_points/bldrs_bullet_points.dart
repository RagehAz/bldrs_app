import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:super_text/super_text.dart';

class BldrsBulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsBulletPoints({
    @required this.bulletPoints,
    this.bubbleWidth,
    this.centered,
    this.showBottomLine = true,
    this.verseSizeFactor = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Verse> bulletPoints;
  final double bubbleWidth;
  final bool centered;
  final bool showBottomLine;
  final double verseSizeFactor;
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
        context: context,
        verses: bulletPoints,
      ),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      textDirection: UiProvider.getAppTextDir(context),
      centered: centered,
      font: BldrsText.superVerseFont(VerseWeight.thin),
      showBottomLine: showBottomLine,
      // textColor: Colorz.blue255,
    );

  }
/// --------------------------------------------------------------------------
}
