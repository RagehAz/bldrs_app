import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/b_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ChainInstructions extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ChainInstructions({
    this.verseOverride,
    this.chain,
    this.picker,
    this.leadingIcon,
    this.iconSizeFactor = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verseOverride;
  final PickerModel picker;
  final Chain chain;
  final String leadingIcon;
  final double iconSizeFactor;
  /// --------------------------------------------------------------------------
  String _getInstructions({
    @required Chain specChain,
    @required PickerModel picker,
  }) {
    String _instructions;

    if (specChain?.sons?.runtimeType == DataCreator) {
      _instructions = 'Specify this';
    }

    else {
      _instructions = picker.canPickMany == true ?
      'You may pick multiple specifications from this list'
          :
      'You can pick only one specification from this list';
    }

    return _instructions;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    final String _instructions = verseOverride ?? _getInstructions(
      picker: picker,
      specChain: chain,
    );

    return Container(
      width: _screenWidth,
      height: SpecPickerScreen.instructionBoxHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
          horizontal: Ratioz.appBarMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DreamBox(
            height: 35,
            width: 35,
            icon: leadingIcon,
            corners: 10,
            margins: const EdgeInsets.symmetric(vertical: 5),
            iconSizeFactor: iconSizeFactor,
            bubble: false,
            color: Colorz.white20,
          ),

          const SizedBox(
            width: 10,
          ),

          Container(
            height: SpecPickerScreen.instructionBoxHeight,
            constraints: BoxConstraints(
              maxWidth: _screenWidth * 0.7,
            ),
            // width: _screenWidth * 0.7,
            child: SuperVerse(
              verse: _instructions,
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
}
