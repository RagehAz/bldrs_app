import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class QuestionButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionButton({
    @required this.verse,
    @required this.icon,
    @required this.count,
    @required this.buttonWidth,
    @required this.buttonHeight,
    @required this.onTap,
    this.iconColor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final String icon;
  final Color iconColor;
  final int count;
  final double buttonWidth;
  final double buttonHeight;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DreamBox(
      width: buttonWidth,
      height: buttonHeight,
      icon: icon,
      verse: verse,
      iconSizeFactor: 0.5,
      verseCentered: false,
      iconColor: iconColor,
      secondLine: counterCaliber(context, count),
      bubble: false,
      color: Colorz.white20,
      onTap: onTap,
    );

  }
}
