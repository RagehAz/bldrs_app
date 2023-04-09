import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyerTypeButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerTypeButton({
    @required this.isSelected,
    @required this.icon,
    this.iconSizeFactor = 0.85,
    this.verse,
    this.onTap,
    this.triggerIconColor = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isSelected;
  final String icon;
  final double iconSizeFactor;
  final Verse verse;
  final Function onTap;
  final bool triggerIconColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Color _buttonColor = isSelected == true ? Colorz.yellow255 : null;
    final Color _iconColor = isSelected == true && triggerIconColor == true ? Colorz.black255 : null;
    final Color _verseColor = isSelected == true ? Colorz.black255 : Colorz.white255;
    // --------------------
    return BldrsBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 4,
      icon: icon, //Iconizer.sectionIconOff(section),
      iconSizeFactor: iconSizeFactor,
      verse: verse,
      verseColor: _verseColor,
      color: _buttonColor,
      iconColor: _iconColor,
      verseMaxLines: 2,
      verseCentered: false,
      verseScaleFactor: 0.7 / iconSizeFactor,
      margins: const EdgeInsets.symmetric(vertical: 5),
      onTap: onTap, //() => _onSetSection(index),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
