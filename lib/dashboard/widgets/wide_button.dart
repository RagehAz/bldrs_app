import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final String icon;
  final Function onTap;
  final String title;

  const WideButton({
    @required this.title,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    // double _screenHeight = Scale.superScreenHeight(context);

    return
      DreamBox(
        height: 50,
        width: _screenWidth - (2 * Ratioz.appBarMargin),
        verse: title,
        icon: icon,
        iconSizeFactor: 0.6,
        verseScaleFactor: 1,
        verseCentered: false,
        margins: const EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        onTap: onTap,
      );

  }
}
