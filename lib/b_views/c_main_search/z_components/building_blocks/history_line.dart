import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/tile_bubble/tile_bubble.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class HistoryLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const HistoryLine({
    required this.verse,
    required this.icon,
    this.bigIcon = false,
    this.boldText = false,
    super.key
  });
  // --------------------
  final Verse? verse;
  final String? icon;
  final bool bigIcon;
  final bool boldText;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _iconFactor = bigIcon == true ? 1 : 0.6;
    final double? _maxWidth = TileBubble.childWidth(context: context);

    return BldrsBox(
      maxWidth: _maxWidth,
      verse: verse,
      verseWeight: boldText == true ? VerseWeight.black : VerseWeight.regular,
      height: 27,
      icon: icon,
      iconSizeFactor: _iconFactor,
      verseScaleFactor: 1 / _iconFactor,
      margins: Scale.superInsets(
        context: context,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        // enRight: 5,
        // bottom: 5,
      ),
      // verseMaxLines: 1,
      corners: 5,
      color: Colorz.white10,
      bubble: false,
    );

  }
  // -----------------------------------------------------------------------------
}
