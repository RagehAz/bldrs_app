import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/a_phids_data_creator.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/b_price_data_creator.dart';
import 'package:bldrs/b_views/i_chains/z_components/specs/data_creators/c_number_data_creator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/customs/no_result_found.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DataCreatorSplitter extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataCreatorSplitter({
    @required this.height,
    @required this.picker,
    @required this.selectedSpecs,
    @required this.appBarType,
    @required this.searchText,
    @required this.onExportSpecs,
    @required this.onPhidTap,
    @required this.zone,
    @required this.onlyUseCityChains,
    @required this.isMultipleSelectionMode,
    @required this.onKeyboardSubmitted,
    this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final PickerModel picker;
  final List<SpecModel> selectedSpecs;
  final AppBarType appBarType;
  final ValueNotifier<dynamic> searchText;
  final ValueChanged<List<SpecModel>> onExportSpecs;
  final Function(String path, String phid) onPhidTap;
  final ZoneModel zone;
  final ValueChanged<String> onKeyboardSubmitted;
  final bool isMultipleSelectionMode;
  final bool onlyUseCityChains;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final Chain _valueChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker?.chainID,
      onlyUseCityChains: onlyUseCityChains,
      // includeChainSInSearch: true,
    );
    // --------------------
    /*
    final Chain _unitChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker?.unitChainID,
      onlyUseCityChains: onlyUseCityChains,
      // includeChainSInSearch: true,
    );
     */
    // --------------------
    final DataCreator _dataCreatorType = DataCreation.decipherDataCreator(_valueChain?.sons);
    // --------------------
    final bool _isChains = Chain.checkIsChains(_valueChain?.sons);
    final bool _isPhids = Phider.checkIsPhids(_valueChain?.sons);
    final bool _hasCurrencyUnit = picker?.unitChainID == 'phid_s_currency';
    // --------------------
    final bool _isIntegerKeyboard = DataCreation.checkIsDataCreatorOfType(
      sons: _valueChain?.sons,
      dataCreator: DataCreator.integerKeyboard,
    );
    // --------------------
    final bool _isDoubleKeyboard = DataCreation.checkIsDataCreatorOfType(
      sons: _valueChain?.sons,
      dataCreator: DataCreator.doubleKeyboard,
    );
    // --------------------
    /*
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    // blog('DataCreatorSplitter - BUILDING');
    // picker?.blogPicker();
    // blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    // _valueChain?.blogChain();
    // blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    // _unitChain?.blogChain();
    // blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    blog('_dataCreatorType : $_dataCreatorType');
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    blog('_isChains : $_isChains');
    blog('_isPhids : $_isPhids');
    blog('_hasCurrencyUnit : $_hasCurrencyUnit');
    blog('_isIntegerKeyboard : $_isIntegerKeyboard');
    blog('_isDoubleKeyboard : $_isDoubleKeyboard');
    // blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
    // SpecModel.blogSpecs(selectedSpecs);
    blog('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~');
     */
    // --------------------
    /// PHIDS OR CHAINS
    if (_isPhids == true || _isChains == true){

      final List<SpecModel> _selectedSpecs =
      isMultipleSelectionMode == false ? null
          :
      SpecModel.getSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      return PhidsDataCreator(
        allowableHeight: height,
        width: width,
        specPicker: picker,
        selectedSpecs: _selectedSpecs,
        searchText: searchText,
        onPhidTap: onPhidTap,
        isMultipleSelectionMode: isMultipleSelectionMode,
        onlyUseCityChains: onlyUseCityChains,
        zone: zone,
        onDataCreatorKeyboardSubmitted: onKeyboardSubmitted,
      );

    }
    // --------------------
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
        width: width,
        picker: picker,
        zone: zone,
        initialValue: _initialPrice,
        initialCurrencyID: _initialCurrencySpec?.value,
        onKeyboardSubmitted: onKeyboardSubmitted,
        onlyUseCityChains: onlyUseCityChains,
        appBarType: appBarType,
        onExportSpecs: onExportSpecs,
      );

    }
    // --------------------
    /// INTEGER - DOUBLE
    else if (_isIntegerKeyboard == true || _isDoubleKeyboard == true){

      /// INITIAL VALUE
      final SpecModel _valueSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.chainID,
      );

      /// INITIAL UNIT
      final SpecModel _unitSpec = SpecModel.getFirstSpecFromSpecsByPickerChainID(
        specs: selectedSpecs,
        pickerChainID: picker.unitChainID,
      );

      return NumberDataCreator(
        width: width,
        appBarType: appBarType,
        dataCreatorType: _dataCreatorType,
        initialValue: _valueSpec,
        initialUnit: _unitSpec?.value,
        zone: zone,
        picker: picker,
        onKeyboardSubmitted: onKeyboardSubmitted,
        onlyUseCityChains: onlyUseCityChains,
        onExportSpecs: onExportSpecs,
      );

    }
    // --------------------
    /// OTHERWISE
    else {
      return const NoResultFound(
        color: Colorz.white50,
        verse: Verse(text: '....', translate: false),
      );
    }
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
