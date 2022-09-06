import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SettingsWideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SettingsWideButton({
    @required this.verse,
    @required this.onTap,
    this.isOn = true,
    this.icon,
    this.color = Colorz.white20,
    this.verseColor = Colorz.white255,
    this.iconColor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final String icon;
  final Function onTap;
  final bool isOn;
  final Color color;
  final Color verseColor;
  final Color iconColor;
  /// --------------------------------------------------------------------------
  static const double width = 300;
  static const double height = 50;
  static const double iconSizeFactor = 0.5;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      isDeactivated: !isOn,
      height: height,
      verse: verse,
      translateVerse: true,
      verseColor: verseColor,
      verseShadow: verseColor != Colorz.black255,
      verseCasing: VerseCasing.upperCase,
      icon: icon,
      iconColor: iconColor,
      width: width,
      margins: 5,
      iconSizeFactor: iconSizeFactor,
      verseCentered: icon == null,
      verseMaxLines: 2,
      verseItalic: true,
      color: color,
      verseScaleFactor: 1.2,
      onTap: onTap,
    );

  }
// --------------------------------------------------------------------------
}
