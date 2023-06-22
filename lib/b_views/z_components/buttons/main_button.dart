import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class MainButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MainButton({
    @required this.verse,
    @required this.icon,
    @required this.onTap,
    this.buttonColor,
    this.splashColor = Colorz.yellow255,
    this.verseShadow = true,
    this.iconSizeFactor = 0.6,
    this.verseColor = Colorz.white255,
    this.verseWeight = VerseWeight.bold,
    this.iconColor,
    this.isDisabled = false,
    this.verseCentered = false,
    this.verseItalic = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final dynamic icon;
  final Color buttonColor;
  final Color splashColor;
  final bool verseShadow;
  final dynamic onTap;
  final double iconSizeFactor;
  final Color verseColor;
  final VerseWeight verseWeight;
  final Color iconColor;
  final bool isDisabled;
  final bool verseCentered;
  final bool verseItalic;
  /// --------------------------------------------------------------------------
  static double getButtonWidth({
    @required BuildContext context,
  }) {
    return  Scale.superWidth(context, 0.7);
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _buttonWidth = getButtonWidth(
        context: context,
    );
    const double _buttonHeight = 50 * 0.85;
    // --------------------
    return BldrsBox(
      isDisabled: isDisabled,
      width: _buttonWidth,
      height: _buttonHeight,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      iconColor: iconColor,
      verse: verse,
      verseScaleFactor: 0.7 / iconSizeFactor,
      verseCentered: verseCentered,
      verseColor: verseColor,
      verseWeight: verseWeight,
      verseMaxLines: 3,
      onTap: onTap,
      color: buttonColor,
      splashColor: splashColor,
      verseShadow: verseShadow,
      margins: const EdgeInsets.only(bottom: 5),
      verseItalic: verseItalic,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
