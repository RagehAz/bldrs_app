import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/a_phids_data_creator.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/b_price_data_creator.dart';
import 'package:bldrs/b_views/x_screens/j_chains/components/specs/data_creators/c_number_data_creator.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
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
    final Chain _valueChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker.chainID,
      onlyUseCityChains: onlyUseCityChains,
      // includeChainSInSearch: true,
    );
// --------------------
    final Chain _unitChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker.unitChainID,
      onlyUseCityChains: onlyUseCityChains,
      // includeChainSInSearch: true,
    );
// --------------------
    final DataCreator _dataCreatorType = Chain.decipherDataCreator(_valueChain?.sons);
// ----------------------------------------
    final bool _isPhids = Chain.checkSonsArePhidsss(_valueChain?.sons);
    final bool _hasCurrencyUnit = picker.unitChainID == 'phid_s_currency';
// ----------------------------------------
    final bool _isIntegerKeyboard = Chain.checkSonsAreDataCreatorOfType(
      sons: _valueChain?.sons,
      dataCreator: DataCreator.integerKeyboard,
    );
// ----------------------------------------
    final bool _isDoubleKeyboard = Chain.checkSonsAreDataCreatorOfType(
      sons: _valueChain?.sons,
      dataCreator: DataCreator.doubleKeyboard,
    );
// ----------------------------------------

    blog('DataCreatorSplitter - BUILDING');
    picker.blogPicker();
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    _valueChain.blogChain();
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    _unitChain?.blogChain();
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

    blog('_dataCreatorType : $_dataCreatorType');
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    blog('_isPhids : $_isPhids');
    blog('_hasCurrencyUnit : $_hasCurrencyUnit');
    blog('_isIntegerKeyboard : $_isIntegerKeyboard');
    blog('_isDoubleKeyboard : $_isDoubleKeyboard');
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    SpecModel.blogSpecs(selectedSpecs);
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');

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
    else if (_hasCurrencyUnit == true){

      /// INITIAL VALUE
      final SpecModel _initialPrice = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      final SpecModel _initialCurrencySpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.unitChainID,
      );

      return PriceDataCreator(
        dataCreatorType: _dataCreatorType,
        picker: picker,
        zone: zone,
        initialValue: _initialPrice,
        initialCurrencyID: _initialCurrencySpec?.value,
        onKeyboardSubmitted: onKeyboardSubmitted,
        onExportSpecs: onAddSpecs,
        onlyUseCityChains: onlyUseCityChains,
      );

    }

    /// INTEGER - DOUBLE
    else if (_isIntegerKeyboard == true || _isDoubleKeyboard == true){


      /// INITIAL VALUE
      final SpecModel _valueSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      blog('aho');
      _valueSpec?.blogSpec();

      /// INITIAL UNIT
      final SpecModel _unitSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.unitChainID,
      );

      return NumberDataCreator(
        dataCreatorType: _dataCreatorType,
        initialValue: _valueSpec,
        initialUnit: _unitSpec?.value,
        zone: zone,
        onExportSpecs: onAddSpecs,
        picker: picker,
        onKeyboardSubmitted: onKeyboardSubmitted,
        onlyUseCityChains: onlyUseCityChains,
      );

    }

    /// OTHERWISE
    else {
      return const NoResultFound(color: Colorz.red255);
    }

  }

}
