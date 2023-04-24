import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarButton({
    this.verse,
    this.verseColor = Colorz.white255,
    this.buttonColor = Colorz.white20,
    this.onTap,
    this.onDeactivatedTap,
    this.icon,
    this.bubble = true,
    this.isDeactivated = false,
    this.bigIcon = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final Color verseColor;
  final Color buttonColor;
  final Function onTap;
  final Function onDeactivatedTap;
  final dynamic icon;
  final bool bubble;
  final bool isDeactivated;
  final bool bigIcon;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: Ratioz.appBarButtonSize,
      width: verse == null ? Ratioz.appBarButtonSize : null,
      // width: Ratioz.appBarButtonSize * 3.5,
      margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      verse: verse,
      icon: icon,
      verseColor: verseColor,
      // verseScaleFactor: 1,
      color: buttonColor,
      iconSizeFactor: bigIcon == true ? 1 : 0.6,
      bubble: bubble,
      onTap: onTap,
      isDisabled: isDeactivated,
      onDisabledTap: onDeactivatedTap,
      verseMaxLines: 2,
      // loading: loading,
    );

  }
  /// --------------------------------------------------------------------------
}
