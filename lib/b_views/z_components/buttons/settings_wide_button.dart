import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/b_views/z_components/buttons/main_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class SettingsWideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SettingsWideButton({
    required this.verse,
    required this.onTap,
    this.isOn = true,
    this.icon,
    this.color = Colorz.white20,
    this.verseColor = Colorz.white255,
    this.iconColor,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse verse;
  final String icon;
  final Function onTap;
  final bool isOn;
  final Color color;
  final Color verseColor;
  final Color iconColor;
  /// --------------------------------------------------------------------------
  static double getWidth(){
    // return Bubble.bubbleWidth(context: getMainContext());
    // return Scale.adaptiveWidth(getMainContext(), 0.5);
    return MainButton.getButtonWidth(context: getMainContext());
  }
  // --------------------------------------------------------------------------
  static const double height = 50;
  static const double iconSizeFactor = 0.5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainButton(
      verse: verse.copyWith(casing: Casing.upperCase),
      icon: icon,
      verseColor: verseColor,
      iconColor: iconColor,
      iconSizeFactor: iconSizeFactor,
      buttonColor: color,
      verseShadow: verseColor != Colorz.black255,
      onTap: onTap,
      isDisabled: !isOn,
      verseCentered: icon == null,
      verseItalic: true,
      // verseWeight: VerseWeight.bold,
      // splashColor: Colorz.yellow255,
    );

  }
// --------------------------------------------------------------------------
}
