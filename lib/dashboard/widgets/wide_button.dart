import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String icon;
  final Function onTap;
  final String verse;
  final bool isActive;
  final Color color;
  final Color verseColor;

  const WideButton({
    @required this.verse,
    this.onTap,
    this.icon,
    this.isActive = true,
    this.color,
    this.verseColor = Colorz.White255,
  });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return
      DreamBox(
        height: 50,
        width: _screenWidth - (2 * Ratioz.appBarMargin),
        verse: verse,
        verseColor: verseColor,
        icon: icon,
        iconSizeFactor: 0.6,
        verseScaleFactor: 1,
        verseCentered: false,
        margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        inActiveMode: !isActive,
        onTap: onTap,
        color: color,
      );

  }
}
