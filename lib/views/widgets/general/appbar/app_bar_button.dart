import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final String verse;
  final Color verseColor;
  final Color buttonColor;
  final Function onTap;

  const AppBarButton({
    @required this.verse,
    this.verseColor = Colorz.white255,
    this.buttonColor = Colorz.white20,
    this.onTap,
  });
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return
      DreamBox(
        height: Ratioz.appBarButtonSize,
        // width: Ratioz.appBarButtonSize * 3.5,
        margins: const EdgeInsets.symmetric(horizontal: Ratioz.appBarPadding),
        verse: verse,
        verseColor: verseColor,
        verseScaleFactor: 0.9,
        color: buttonColor,
        // icon: loading ? null : Iconz.AddFlyer,
        bubble: true,
        iconSizeFactor: 0.6,
        onTap: onTap,
        // loading: loading,
      );
  }
}
