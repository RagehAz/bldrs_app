import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/helpers/widgets/drawing/spacing.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CurrencyTileButton extends StatelessWidget {
  // --------------------------------------------------------------------------
  const CurrencyTileButton({
    required this.currencyModel,
    required this.onTap,
    required this.highlightController,
    required this.isSelected,
    super.key
  });
  // --------------------
  final CurrencyModel currencyModel;
  final Function onTap;
  final TextEditingController? highlightController;
  final bool isSelected;
  // --------------------------------------------------------------------------
  static const double height = 40;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------

    final double _boxWidth = Bubble.bubbleWidth(context: context);
    const double _spacing = 5;
    const double _symbolButtonWidth = height * 1.3;
    final double _currencyButtonWidth = _boxWidth - _spacing - _symbolButtonWidth;

    return Container(
      width: _boxWidth,
      height: height,
      margin: const EdgeInsets.only(
        bottom: 5
      ),
      child: Row(
        children: <Widget>[

          /// BUTTON
          BldrsBox(
            height: height,
            width: _currencyButtonWidth,
            color: isSelected == true ? Colorz.yellow125 : Colorz.white10,
            icon: Flag.getCountryIcon(currencyModel.countriesIDs?.first.toLowerCase()),
            verse: Verse(
              id: currencyModel.id,
              translate: true,
            ),
            iconSizeFactor: 0.7,
            verseCentered: false,
            bubble: false,
            verseHighlight: highlightController,
            onTap: onTap,
            onLongTap: (){
              blog('currency : ${currencyModel.countriesIDs?.first}');
            },
          ),

          /// SPACING
          const Spacing(size: _spacing),

          BldrsBox(
            height: height,
            width: _symbolButtonWidth,
            color: isSelected == true ? Colorz.yellow125 : Colorz.white10,
            verse: Verse(
              id: currencyModel.symbol,
              translate: false,
            ),
            bubble: false,
            verseScaleFactor: 0.55,
            verseWeight: VerseWeight.thin,
          ),

        ],
      ),
    );
    // --------------------
  }

  // --------------------------------------------------------------------------
}
