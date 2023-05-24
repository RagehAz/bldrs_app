import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class HistoryLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const HistoryLine({
    @required this.verse,
    @required this.icon,
    this.bigIcon = false,
    this.boldText = false,
    Key key
  }) : super(key: key);
  // --------------------
  final Verse verse;
  final String icon;
  final bool bigIcon;
  final bool boldText;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _iconFactor = bigIcon == true ? 1 : 0.6;

    return BldrsBox(
      verse: verse,
      verseWeight: boldText == true ? VerseWeight.black : VerseWeight.regular,
      height: 27,
      icon: icon,
      iconSizeFactor: _iconFactor,
      verseScaleFactor: 1 / _iconFactor,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        enLeft: 5,
        bottom: 5,
      ),
      corners: 5,
      color: Colorz.white10,
      bubble: false,
    );

  }
  // -----------------------------------------------------------------------------
}
