import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final String icon;
  final Function onTap;
  final String verse;
  final bool isActive;
  final Color color;
  final Color verseColor;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return DreamBox(
      height: 50,
      width: _screenWidth - (2 * Ratioz.appBarMargin),
      verse: verse,
      verseColor: verseColor,
      icon: icon,
      iconSizeFactor: 0.6,
      verseCentered: false,
      margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      isDeactivated: !isActive,
      onTap: onTap,
      color: color,
    );
  }
}
