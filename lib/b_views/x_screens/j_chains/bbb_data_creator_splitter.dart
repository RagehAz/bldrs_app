import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/a_phids_data_creator.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/b_price_data_creator.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/c_number_data_creator.dart';
import 'package:bldrs/b_views/z_components/texting/no_result_found.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DataCreatorSplitter extends StatelessWidget {

  const DataCreatorSplitter({
    @required this.height,
    @required this.picker,
    @required this.selectedSpecs,
    @required this.onlyUseCityChains,
    @required this.zone,
    @required this.onSelectPhid,
    @required this.onAddSpecs,
    @required this.onKeyboardSubmitted,
    @required this.isMultipleSelectionMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final PickerModel picker;
  final List<SpecModel> selectedSpecs;
  final bool onlyUseCityChains;
  final ZoneModel zone;
  final ValueChanged<String> onSelectPhid;
  final ValueChanged<List<SpecModel>> onAddSpecs;
  final Function onKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  /// --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
// ----------------------------------------
    final Chain _chain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker.chainID,
      onlyUseCityChains: onlyUseCityChains,
    );
// --------------------
    final DataCreator _dataCreatorType = Chain.decipherDataCreator(_chain.sons);
// ----------------------------------------
    final bool _isPhids = Chain.checkSonsArePhids(_chain?.sons);
    final bool _isCurrencies = Chain.checkSonsAreCurrencies(_chain?.sons);
// ----------------------------------------
    final bool _isIntegerKeyboard = Chain.checkSonsAreDataCreatorOfType(
      sons: _chain?.sons,
      dataCreator: DataCreator.integerKeyboard,
    );
// ----------------------------------------
    final bool _isDoubleKeyboard = Chain.checkSonsAreDataCreatorOfType(
      sons: _chain?.sons,
      dataCreator: DataCreator.doubleKeyboard,
    );
// ----------------------------------------

    /// PHIDS
    if (_isPhids == true){

      final List<SpecModel> _selectedSpecs =
      isMultipleSelectionMode == false ? null
          :
      SpecModel.getSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      return PhidsDataCreator(
        height: height,
        specPicker: picker,
        selectedSpecs: _selectedSpecs,
        onPhidTap: onSelectPhid,
        onlyUseCityChains: onlyUseCityChains,
      );

    }

    /// CURRENCIES
    else if (_isCurrencies == true){

      /// INITIAL VALUE
      final SpecModel _initialCurrencyID = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      return PriceDataCreator(
        dataCreatorType: _dataCreatorType,
        picker: picker,
        zone: zone,
        initialValue: _initialCurrencyID,
        onKeyboardSubmitted: onKeyboardSubmitted,
        onExportSpecs: onAddSpecs,
      );

    }

    /// INTEGER - DOUBLE
    else if (_isIntegerKeyboard == true || _isDoubleKeyboard == true){

      /// INITIAL VALUE
      final SpecModel _valueSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      /// INITIAL UNIT
      final SpecModel _unitUnit = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.unitChainID,
      );

      return NumberDataCreator(
        dataCreatorType: _dataCreatorType,
        initialValue: _valueSpec?.value,
        initialUnit: _unitUnit?.value,
        zone: zone,
        onExportSpecs: onAddSpecs,
        picker: picker,
        onKeyboardSubmitted: onKeyboardSubmitted,
      );

    }

    /// OTHERWISE
    else {
      return const NoResultFound(color: Colorz.red255);
    }

  }

}
