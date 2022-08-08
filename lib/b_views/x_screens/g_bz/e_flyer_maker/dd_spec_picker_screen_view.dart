import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/d_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/a_strings_data_creator.dart';
import 'package:bldrs/b_views/z_components/specs/data_creators/c_integer_data_creator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreenView({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.screenHeight,
    @required this.showInstructions,
    @required this.inSelectionMode,
    @required this.onSelectSpec,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SpecPicker specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final double screenHeight;
  final bool showInstructions;
  final bool inSelectionMode;
  final ValueChanged<String> onSelectSpec;
  /// --------------------------------------------------------------------------
  double _getListZoneHeight(){

    final double _instructionsBoxHeight = showInstructions == true ?
    SpecPickerScreen.instructionBoxHeight
        :
    0;

    final double _listZoneHeight = screenHeight - Ratioz.stratosphere - _instructionsBoxHeight;

    return _listZoneHeight;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Chain _specChain = ChainsProvider.superGetChain(
      context: context,
      chainID: specPicker.chainID,
      searchOnlyCityKeywordsChainsAndSpecs: false,
    );
    final bool _isNumberDataCreator = Chain.checkSonsAreDataCreator(_specChain.sons);

    final double _listZoneHeight = _getListZoneHeight();

    return Column(
      children: <Widget>[

        const Stratosphere(),

        /// INSTRUCTIONS BOX
        if (showInstructions == true)
          SpecPickerInstructions(
            chain: _specChain,
            picker: specPicker,
          ),

        /// SPECS PICKER FOR SELECTING MULTIPLE SPECS
        if (inSelectionMode == true)
        ValueListenableBuilder(
          valueListenable: selectedSpecs,
          builder: (BuildContext ctx, List<SpecModel> specs, Widget child) {


            /// SPECS PICKER SELECTOR
            if (_isNumberDataCreator == false){
              return StringsDataCreator(
                height: _listZoneHeight,
                specPicker: specPicker,
                selectedSpecs: SpecModel.getSpecsByPickerChainID(
                  specs: specs,
                  pickerChainID: specPicker.chainID,
                ),
                onSpecTap: onSelectSpec,
              );
            }

            /// PRICE SPECS CREATOR
            // else if (_specChain.sons == DataCreator.price){
            //
            //   final List<SpecModel> _priceSpec = SpecModel.getSpecsByPickerChainID(
            //     specs: specs,
            //     pickerChainID: specPicker.chainID,
            //   );
            //
            //   final double _initialPriceValue = Mapper.canLoopList(_priceSpec) ?
            //   _priceSpec[0].value
            //       :
            //   null;
            //
            //   return PriceDataCreator(
            //     initialPriceValue: _initialPriceValue,
            //     onCurrencyChanged: (CurrencyModel currency) => onCurrencyChanged(
            //       currency: currency,
            //       selectedSpecs: selectedSpecs,
            //     ),
            //     onValueChanged: (String value) => onPriceChanged(
            //       price: value,
            //       picker: specPicker,
            //       selectedSpecs: selectedSpecs,
            //     ),
            //     onSubmitted: () => onGoBackToSpecsPickersScreen(
            //       context: context,
            //       selectedSpecs: selectedSpecs,
            //     ),
            //   );
            //
            // }

            /// INTEGER INCREMENTER SPECS CREATOR
            else if (
            _specChain.sons == DataCreator.integerKeyboard
            ||
            _specChain.sons == DataCreator.doubleKeyboard
            ){

              final SpecModel _valueSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
                  specs: selectedSpecs.value,
                  pickerChainID: specPicker.chainID,
              );

              final SpecModel _unitSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
                  specs: selectedSpecs.value,
                  pickerChainID: specPicker.unitChainID,
              );


              return IntegerAndDoubleDataCreator(
                dataCreatorType: _specChain.sons,
                initialValue: _valueSpec?.value,
                initialUnit: _unitSpec?.value,
                onExportSpecs: (List<SpecModel> specs) => onAddSpecs(
                  specs: specs,
                  picker: specPicker,
                  selectedSpecs: selectedSpecs,
                ),
                specPicker: specPicker,

                onKeyboardSubmitted: () => onGoBackToSpecsPickersScreen(
                  context: context,
                  selectedSpecs: selectedSpecs,
                ),
              );
            }

            else {
              return const SizedBox();
            }

          },
        ),

        /// SPEC PICKER FOR KEYWORD SELECTION
        if (inSelectionMode == false && _isNumberDataCreator == false)
          StringsDataCreator(
            height: _listZoneHeight,
            specPicker: specPicker,
            selectedSpecs: null,
            onSpecTap: onSelectSpec,
          ),

      ],
    );

  }
}

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

    if (specChain.sons.runtimeType == DataCreator) {
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
