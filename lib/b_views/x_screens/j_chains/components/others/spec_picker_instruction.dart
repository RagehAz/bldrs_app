import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/b_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerInstructions extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerInstructions({
    @required this.chain,
    @required this.picker,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker picker;
  final Chain chain;
  /// --------------------------------------------------------------------------
  String _getInstructions({
    @required Chain specChain,
    @required SpecPicker picker,
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

    final String _instructions = _getInstructions(
      picker: picker,
      specChain: chain,
    );

    return Container(
      width: _screenWidth,
      height: SpecPickerScreen.instructionBoxHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
      child: SuperVerse(
        verse: _instructions,
        maxLines: 3,
        weight: VerseWeight.thin,
        italic: true,
        color: Colorz.white125,
      ),
      // color: Colorz.white10,
    );

  }
}
