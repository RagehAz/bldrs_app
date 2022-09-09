import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarButton({
    this.verse,
    this.verseColor = Colorz.white255,
    this.buttonColor = Colorz.white20,
    this.onTap,
    this.icon,
    this.bubble = true,
    this.isDeactivated = false,
    this.translate = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Color verseColor;
  final Color buttonColor;
  final Function onTap;
  final dynamic icon;
  final bool bubble;
  final bool isDeactivated;
  final bool translate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: Ratioz.appBarButtonSize,
      width: verse == null ? Ratioz.appBarButtonSize : null,
      // width: Ratioz.appBarButtonSize * 3.5,
      margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      verse: verse,
      translateVerse: translate,
      icon: icon,
      verseColor: verseColor,
      verseScaleFactor: 0.9,
      color: buttonColor,
      iconSizeFactor: 0.6,
      bubble: bubble,
      onTap: onTap,
      isDeactivated: isDeactivated,
      // loading: loading,
    );

  }
  /// --------------------------------------------------------------------------
}
