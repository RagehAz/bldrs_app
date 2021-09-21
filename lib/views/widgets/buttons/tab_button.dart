import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final bool isSelected;
  final String icon;
  final String verse;
  final Function onTap;

  const TabButton({
    @required this.isSelected,
    @required this.icon,
    this.verse,
    this.onTap,
});

  @override
  Widget build(BuildContext context) {

    Color _buttonColor = isSelected == true ? Colorz.Yellow255 : null;
    Color _iconColor = isSelected == true ? Colorz.Black255 : null;

    return DreamBox(
      height: Ratioz.appBarButtonSize,
      // width: Ratioz.appBarButtonSize * 4,
      icon: icon,//Iconizer.sectionIconOff(section),
      iconSizeFactor: 0.85,
      verse: verse,
      verseColor: _iconColor,
      color: _buttonColor,
      iconColor: _iconColor,
      verseMaxLines: 2,
      verseCentered: false,
      bubble: true,
      verseScaleFactor: 0.7,
      margins: EdgeInsets.symmetric(vertical: 5),
      onTap: onTap,//() => _onSetSection(index),
    );
  }
}

