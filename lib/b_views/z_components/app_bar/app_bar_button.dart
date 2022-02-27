import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarButton({
    @required this.verse,
    this.verseColor = Colorz.white255,
    this.buttonColor = Colorz.white20,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Color verseColor;
  final Color buttonColor;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DreamBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 3.5,
      margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
      verse: verse,
      verseColor: verseColor,
      verseScaleFactor: 0.9,
      color: buttonColor,
      iconSizeFactor: 0.6,
      onTap: onTap,
      // loading: loading,
    );
  }
}
