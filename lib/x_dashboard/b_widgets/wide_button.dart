import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideButton({
    @required this.verse,
    this.onTap,
    this.icon,
    this.isActive = true,
    this.color,
    this.verseColor = Colorz.white255,
    this.width,
    this.iconSizeFactor = 0.6,
    this.verseScaleFactor = 1,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  final Function onTap;
  final String verse;
  final bool isActive;
  final Color color;
  final Color verseColor;
  final double width;
  final double iconSizeFactor;
  final double verseScaleFactor;
  /// --------------------------------------------------------------------------
  static const double height = 50;
  @override
  Widget build(BuildContext context) {

    final double _buttonWith = width ?? BldrsAppBar.width(context);

    return DreamBox(
      height: height,
      width: _buttonWith,
      verse: verse,
      verseColor: verseColor,
      verseScaleFactor: verseScaleFactor,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      verseCentered: false,
      margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      isDeactivated: !isActive,
      onTap: onTap,
      color: color,
    );

  }
}
