import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/b_picker_screen.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/bbb_data_creator_splitter.dart';
import 'package:bldrs/b_views/i_chains/z_components/others/spec_picker_instruction.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PickersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PickersScreenView({
    @required this.picker,
    @required this.selectedSpecs,
    @required this.screenHeight,
    @required this.showInstructions,
    @required this.isMultipleSelectionMode,
    @required this.onSelectPhid,
    @required this.onlyUseCityChains,
    @required this.zone,
    @required this.onAddSpecs,
    @required this.onKeyboardSubmitted,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final PickerModel picker;
  final ValueNotifier<List<SpecModel>> selectedSpecs;
  final double screenHeight;
  final bool showInstructions;
  final bool isMultipleSelectionMode;
  final ValueChanged<String> onSelectPhid;
  final bool onlyUseCityChains;
  final ZoneModel zone;
  final ValueChanged<List<SpecModel>> onAddSpecs;
  final Function onKeyboardSubmitted;
  final AppBarType appBarType;
  // -----------------------------------------------------------------------------
  double _getListZoneHeight(){

    final double _instructionsBoxHeight = showInstructions == true ?
    PickerScreen.instructionBoxHeight
        :
    0;

    final double _listZoneHeight = screenHeight - Ratioz.stratosphere - _instructionsBoxHeight;

    return _listZoneHeight;
  }
  // -----------------------------------------------------------------------------
  /// SINGLE PICKER INSTRUCTIONS
  String _getInstructions(BuildContext context){
    String _instructions;

    final Chain _chain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker?.chainID,
      onlyUseCityChains: onlyUseCityChains,
    );

    final bool _sonsAreDataCreator = DataCreation.checkIsDataCreator(_chain?.sons);

    if (_sonsAreDataCreator == true) {
      _instructions = 'Specify this';
    }

    else {
      _instructions = picker?.canPickMany == true ?
      'You may pick multiple specifications from this list'
          :
      'You can pick only one specification from this list';
    }

    return _instructions;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _listZoneHeight = _getListZoneHeight();
    // --------------------
    return Column(
      children: <Widget>[

        const Stratosphere(),

        /// INSTRUCTIONS BOX
        if (showInstructions == true)
          ChainInstructions(
            instructions: _getInstructions(context),
          ),

        /// DATA CREATOR SPLITTER
        ValueListenableBuilder(
          valueListenable: selectedSpecs,
          builder: (BuildContext ctx, List<SpecModel> specs, Widget child) {

            return DataCreatorSplitter(
              appBarType: appBarType,
              height: _listZoneHeight,
              picker: picker,
              onlyUseCityChains: onlyUseCityChains,
              onSelectPhid: onSelectPhid,
              selectedSpecs: specs,
              zone: zone,
              onAddSpecs: onAddSpecs,
              onKeyboardSubmitted: onKeyboardSubmitted,
              isMultipleSelectionMode: isMultipleSelectionMode,
            );

            //////// /// SPECS PICKER SELECTOR
            //////// if (_isPhids == true){
            ////////
            ////////   return PhidsDataCreator(
            ////////     height: _listZoneHeight,
            ////////     specPicker: specPicker,
            ////////     selectedSpecs: SpecModel.getSpecsByPickerChainID(
            ////////       specs: specs,
            ////////       pickerChainID: specPicker.chainID,
            ////////     ),
            ////////     onlyUseCityChains: onlyUseCityChains,
            ////////     onPhidTap: onSelectPhid,
            ////////   );
            //////// }

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
            // else
            //   if (_isIntegerKeyboard == true || _isDoubleKeyboard == true){
            //
            //   final SpecModel _valueSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
            //       specs: selectedSpecs.value,
            //       pickerChainID: specPicker.chainID,
            //   );
            //
            //   final SpecModel _unitSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
            //       specs: selectedSpecs.value,
            //       pickerChainID: specPicker.unitChainID,
            //   );
            //
            //   return IntegerAndDoubleDataCreator(
            //     dataCreatorType: Chain.decipherDataCreator(_chain.sons),
            //     initialValue: _valueSpec?.value,
            //     initialUnit: _unitSpec?.value,
            //     zone: zone,
            //     onExportSpecs: (List<SpecModel> specs) => onAddSpecs(
            //       specs: specs,
            //       picker: specPicker,
            //       selectedSpecs: selectedSpecs,
            //     ),
            //     specPicker: specPicker,
            //     onKeyboardSubmitted: () => onGoBackFromSpecPickerScreen(
            //       context: context,
            //       selectedSpecs: selectedSpecs,
            //       isMultipleSelectionMode: isMultipleSelectionMode,
            //       phid: null,
            //     ),
            //   );
            //
            // }

            /// OTHER WISE
            // else {
            //
            //   return const NoResultFound(color: Colorz.red255);
            //
            //   // return const SizedBox();
            //
            // }

          },
        ),

      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
