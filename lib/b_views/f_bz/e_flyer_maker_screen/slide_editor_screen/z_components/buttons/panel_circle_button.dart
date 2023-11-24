import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PanelCircleButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PanelCircleButton({
    required this.size,
    required this.onTap,
    required this.verse,
    required this.icon,
    required this.isSelected,
    this.isDisabled = false,
    super.key
  });
  // ------------------------
  final double size;
  final Function onTap;
  final Verse verse;
  final dynamic icon;
  final bool isSelected;
  final bool isDisabled;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Color getBackColor({
    required bool isDisabled,
  }){
    if (isDisabled == true){
      return Colorz.black125;
    }
    else {
      return Colorz.black200;
    }
  }
  // ------------------------
  /// TESTED : WORKS PERFECT
  static Color getFrontColor({
    required bool isSelected,
  }){
    if (isSelected == true){
      return Colorz.yellow20;
    }
    else {
      return Colorz.white20;
    }
  }
  // ------------------------
  /// TESTED : WORKS PERFECT
  static Color getBorderColor({
    required bool isSelected,
  }){
    return isSelected == true ? Colorz.yellow255 : Colorz.white125;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _circleSize = size * 0.7;
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        Stack(
          children: <Widget>[

            /// BLACK BACKGROUND
            Container(
              width: _circleSize,
              height: _circleSize,
              decoration: BoxDecoration(
                color: getBackColor(isDisabled: isDisabled),
                borderRadius: BorderRadius.circular(size * 0.5),
              ),
            ),

            /// PLAY BUTTON
            BldrsBox(
              width: _circleSize,
              height: _circleSize,
              corners: size * 0.5,
              color: getFrontColor(isSelected: isSelected),
              iconColor: isSelected == true ? Colorz.yellow255 : Colorz.white255,
              borderColor: getBorderColor(isSelected: isSelected),
              icon: icon,
              iconSizeFactor: 0.5,
              splashColor: Colorz.yellow255,
              isDisabled: isDisabled,
              onTap: onTap,
            ),

          ],
        ),

        /// VERSE
        BldrsText(
          width: size * 0.7,
          verse: verse,
          scaleFactor: size * 0.01,
          weight: VerseWeight.thin,
          color: isDisabled == true ? Colorz.white125 : Colorz.white255,
        ),

        /// SPACING
        Spacing(
          size: size * 0.05,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
