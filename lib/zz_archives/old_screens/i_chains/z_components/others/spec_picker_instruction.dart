import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/zz_archives/old_screens/i_chains/b_picker_screen/b_picker_screen.dart';
import 'package:flutter/material.dart';

class ChainInstructions extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainInstructions({
    required this.instructions,
    this.leadingIcon,
    this.iconSizeFactor = 1,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Verse instructions;
  final String? leadingIcon;
  final double iconSizeFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);

    return Container(
      width: _screenWidth,
      height: PickerScreen.instructionBoxHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: Ratioz.appBarMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// LEADING ICON
          if (leadingIcon != null)
            BldrsBox(
              height: 35,
              width: 35,
              icon: leadingIcon,
              corners: 10,
              margins: const EdgeInsets.symmetric(vertical: 5),
              iconSizeFactor: iconSizeFactor,
              bubble: false,
              color: Colorz.white20,
            ),

          /// LEADING ICON SPACER
          if (leadingIcon != null)
            const SizedBox(
              width: 10,
            ),

          /// INSTRUCTION VERSE
          Container(
            height: PickerScreen.instructionBoxHeight,
            constraints: BoxConstraints(
              maxWidth: _screenWidth * 0.7,
            ),
            child: BldrsText(
              verse: instructions,
              maxLines: 3,
              weight: VerseWeight.thin,
              italic: true,
              color: Colorz.white125,
              centered: leadingIcon == null,
              labelColor: Colorz.white20,
              scaleFactor: 0.8,
            ),
          ),

        ],
      ),
      // color: Colorz.white10,
    );

  }
  // -----------------------------------------------------------------------------
}
