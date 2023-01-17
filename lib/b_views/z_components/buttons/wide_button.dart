import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class WideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideButton({
    this.verse,
    this.onTap,
    this.icon,
    this.isActive = true,
    this.color,
    this.verseColor = Colorz.white255,
    this.width,
    this.iconSizeFactor = 0.6,
    this.verseScaleFactor = 1,
    this.bubble = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  final Function onTap;
  final Verse verse;
  final bool isActive;
  final Color color;
  final Color verseColor;
  final double width;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final bool bubble;
  /// --------------------------------------------------------------------------
  static const double height = 50;
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      height: height,
      width: width ?? BldrsAppBar.width(context),
      verse: verse,
      verseColor: verseColor,
      verseScaleFactor: verseScaleFactor,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      verseCentered: false,
      margins: const EdgeInsets.only(bottom: Ratioz.appBarPadding),
      isDisabled: !isActive,
      onTap: onTap,
      color: color,
      bubble: bubble,
    );

  }
  /// --------------------------------------------------------------------------
}
