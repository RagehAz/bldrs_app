import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';

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
    this.onDisabledTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic icon;
  final Function? onTap;
  final Verse? verse;
  final bool isActive;
  final Color? color;
  final Color verseColor;
  final double? width;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final bool bubble;
  final Function? onDisabledTap;
  /// --------------------------------------------------------------------------
  static const double height = 50;
  static EdgeInsets margins = const EdgeInsets.only(bottom: Ratioz.appBarPadding);
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      height: height,
      width: width ?? Bubble.bubbleWidth(context: context),
      verse: verse,
      verseColor: verseColor,
      verseScaleFactor: verseScaleFactor,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      verseCentered: false,
      margins: margins,
      isDisabled: !isActive,
      onDisabledTap: onDisabledTap,
      onTap: onTap,
      color: color,
      bubble: bubble,
    );

  }
  /// --------------------------------------------------------------------------
}
