import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class SettingsWideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SettingsWideButton({
    @required this.verse,
    @required this.onTap,
    this.isOn = true,
    this.icon,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final String icon;
  final Function onTap;
  final bool isOn;
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
      verse: verse.toUpperCase(),
      icon: icon,
      width: width,
      margins: 5,
      iconSizeFactor: iconSizeFactor,
      verseCentered: icon == null,
      verseMaxLines: 2,
      verseItalic: true,
      color: Colorz.white20,
      verseScaleFactor: 1.2,
      onTap: onTap,
    );

  }
}
