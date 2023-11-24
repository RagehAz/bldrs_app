import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PanelCircleButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PanelCircleButton({
    required this.size,
    required this.onTap,
    required this.verse,
    required this.icon,
    required this.isSelected,
    this.isDisabled = false,
    super.key
  });
  /// ------------------------
  final double size;
  final Function onTap;
  final Verse verse;
  final dynamic icon;
  final bool isSelected;
  final bool isDisabled;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        /// PLAY BUTTON
        BldrsBox(
          width: size * 0.7,
          height: size * 0.7,
          corners: size * 0.5,
          color: isSelected == true ? Colorz.black150 : Colorz.black80,
          iconColor: isSelected == true ? Colorz.yellow255 : Colorz.white255,
          borderColor: isSelected == true ? Colorz.yellow255 : null,
          icon: icon,
          iconSizeFactor: 0.5,
          splashColor: Colorz.yellow255,
          isDisabled: isDisabled,
          onTap: onTap,
        ),

        /// VERSE
        BldrsText(
          verse: verse,
          scaleFactor: size * 0.01,
          weight: VerseWeight.thin,
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
