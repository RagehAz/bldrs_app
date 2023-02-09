import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/lib/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:super_text/super_text.dart';

class BldrsBulletPoints extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsBulletPoints({
    @required this.bulletPoints,
    this.bubbleWidth,
    this.centered,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Verse> bulletPoints;
  final double bubbleWidth;
  final bool centered;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _bubbleWidth = Bubble.clearWidth(
      context: context,
      bubbleWidthOverride: bubbleWidth,
    );

    return BulletPoints(
      boxWidth: _bubbleWidth,
      bulletPoints: Verse.bakeVerses(
        context: context,
        verses: bulletPoints,
      ),
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      textDirection: UiProvider.getAppTextDir(context),
      centered: centered,

      // textColor: Colorz.blue255,
      // showBottomLine: true,
    );

  }
/// --------------------------------------------------------------------------
}
