import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/b_spec_picker_screen.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/a_strings_data_creator.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/c_integer_data_creator.dart';
import 'package:bldrs/b_views/z_components/texting/no_result_found.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SpecPickerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecPickerScreenView({
    @required this.specPicker,
    @required this.selectedSpecs,
    @required this.screenHeight,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onSelectPhid,
    @required this.onlyUseCityChains,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel specPicker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final double screenHeight;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final ValueChanged<String> onSelectPhid;
  final bool onlyUseCityChains;
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

    final Chain _chain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: specPicker.chainID,
      onlyUseCityChains: onlyUseCityChains,
    );

    final bool _isNumberDataCreator = Chain.checkSonsAreDataCreator(_chain?.sons);
    blog('fuck thisssss : _chain?.sons.runtimetyoe : ${_chain?.sons?.runtimeType} : specPicker.chainID, : ${specPicker.chainID} : _isNumberDataCreator : $_isNumberDataCreator : ${_chain?.sons}');

    blog(_chain?.sons);

    final double _listZoneHeight = _getListZoneHeight();


    return Column(
      children: <Widget>[

        const Stratosphere(),

        /// INSTRUCTIONS BOX
        if (showInstructions == true)
          ChainInstructions(
            chain: _chain,
            picker: specPicker,
          ),

        /// SPECS PICKER FOR SELECTING MULTIPLE SPECS
        if (isMultipleSelectionMode == true)
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
                onlyUseCityChains: onlyUseCityChains,
                onPhidTap: onSelectPhid,
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
            _chain.sons == DataCreator.integerKeyboard
            ||
            _chain.sons == DataCreator.doubleKeyboard
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
                dataCreatorType: _chain.sons,
                initialValue: _valueSpec?.value,
                initialUnit: _unitSpec?.value,
                onExportSpecs: (List<SpecModel> specs) => onAddSpecs(
                  specs: specs,
                  picker: specPicker,
                  selectedSpecs: selectedSpecs,
                ),
                specPicker: specPicker,

                onKeyboardSubmitted: () => onGoBackFromSpecPickerScreen(
                  context: context,
                  selectedSpecs: selectedSpecs,
                  isMultipleSelectionMode: isMultipleSelectionMode,
                  phid: null,
                ),
              );
            }

            else {
              return NoResultFound();

              return const SizedBox();
            }

          },
        ),

        /// SPEC PICKER FOR KEYWORD SELECTION
        if (isMultipleSelectionMode == false && _isNumberDataCreator == false)
          StringsDataCreator(
            height: _listZoneHeight,
            specPicker: specPicker,
            selectedSpecs: null,
            onPhidTap: onSelectPhid,
            onlyUseCityChains: onlyUseCityChains,
          ),

      ],
    );

  }
}
