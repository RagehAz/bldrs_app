import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/c_currencies_screen/c_currencies_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// CURRENCY DATA CREATOR

// --------------------
/// TESTED : WORKS PERFECT
void initializeCurrencyData({
  @required BuildContext context,
  @required ValueNotifier<String> selectedCurrencyID,
  @required ZoneModel zone,
  @required TextEditingController textController,
  @required SpecModel initialValue,
  @required ValueNotifier<double> priceValue,
  @required DataCreator dataCreatorType,
  @required String initialCurrencyID,
}){

  /// INITIALIZE CURRENCY
  _initializeInitialCurrency(
    context: context,
    selectedCurrencyID: selectedCurrencyID,
    zone: zone,
    initialCurrencyID: initialCurrencyID,
  );

  /// INITIALIZE PRICE VALUE
  priceValue.value = _fixValueDataType(
    value: initialValue?.value,
    dataCreatorType: dataCreatorType,
  );
  textController.text = priceValue.value?.toString() ?? '';

}
// --------------------
/// TESTED : WORKS PERFECT
void _initializeInitialCurrency({
  @required BuildContext context,
  @required String initialCurrencyID,
  @required ZoneModel zone,
  @required ValueNotifier<String> selectedCurrencyID,
}){

  String _initialCurrencyID = initialCurrencyID;

  if (_initialCurrencyID == null){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _countryID = zone?.countryID ?? _zoneProvider.currentZone?.countryID;
    final CurrencyModel _initialCurrency = ZoneProvider.proGetCurrencyByCountryID(
      context: context,
      countryID: _countryID,
      listen: false,
    );

    _initialCurrencyID = _initialCurrency?.id ?? CurrencyModel.usaCurrencyID;

  }

  selectedCurrencyID.value = _initialCurrencyID;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCurrencySelectorButtonTap({
  @required BuildContext context,
  @required ZoneModel zone,
  @required ValueNotifier<String> selectedCurrencyID,
  @required GlobalKey<FormState> formKey,
  @required String text,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}) async {

  final CurrencyModel _currency = await Nav.goToNewScreen(
    context: context,
    screen: CurrenciesScreen(
      countryIDCurrencyOverride: zone?.countryID,
    ),
  );

  if (_currency != null){

    selectedCurrencyID.value = _currency.id;

    Formers.validateForm(formKey);

    _createSpecsFromLocalDataAndExport(
      text: text,
      specValue: specValue,
      picker: picker,
      selectedUnitID: selectedCurrencyID.value,
      onExportSpecs: onExportSpecs,
    );

  }

}
// -----------------------------------------------------------------------------

/// NUMBER DATA CREATOR

// --------------------
/// TESTED : WORKS PERFECT
void initializeNumberData({
  @required BuildContext context,
  @required SpecModel initialValue,
  @required TextEditingController textController,
  @required ValueNotifier<String> selectedUnitID,
  @required PickerModel picker,
  @required ValueNotifier<dynamic> specValue,
  @required DataCreator dataCreatorType,
  @required String initialUnit,
}){
  // --------------------
  specValue.value = _fixValueDataType(
    value: initialValue?.value,
    dataCreatorType: dataCreatorType,
  );

  blog('a77aaaa :${specValue.value}');

  textController.text = specValue.value?.toString() ?? '';
// --------------------
  final Chain _unitChain = ChainsProvider.proFindChainByID(
    context: context,
    chainID: picker.unitChainID,
  );
// --------------------
  _initializeNumberUnit(
    initialUnit: initialUnit,
    selectedUnitID: selectedUnitID,
    unitChain: _unitChain,
  );
// --------------------

}
// --------------------
/// TESTED : WORKS PERFECT
void _initializeNumberUnit({
  @required String initialUnit,
  @required Chain unitChain,
  @required ValueNotifier<String> selectedUnitID,
}){
  String _initialUnit;

  if (unitChain != null){

    /// UNIT IS DEFINED FROM OUTSIDE THE CLASS
    if (initialUnit != null){
      _initialUnit = initialUnit;
    }

    /// UNIT IS STILL NOT DEFINED
    else {
      _initialUnit =  unitChain.sons[0];
    }

  }

  selectedUnitID.value = _initialUnit;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onUnitSelectorButtonTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required String text,
  @required ValueNotifier<String> selectedUnitID,
  @required ValueNotifier<dynamic> specValue,
  @required DataCreator dataCreatorType,
  @required GlobalKey<FormState> formKey,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}) async {
// --------------------
  final Chain _unitChain = ChainsProvider.proFindChainByID(
    context: context,
    chainID: picker.unitChainID,
  );
// --------------------
  Keyboard.closeKeyboard(context);

  final bool _arePhids = Phider.checkIsPhids(_unitChain?.sons) == true;

  /// SONS ARE PHIDS
  if (_arePhids == true){

    final List<String> _units = _unitChain.sons;

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        buttonHeight: 40,
        numberOfWidgets: _unitChain.sons.length,
        builder: (_, PhraseProvider pro){


          return List.generate(_unitChain.sons.length,
                  (index){

                final String _unitID = _units[index];

                return BottomDialog.wideButton(
                  context: context,
                  verse: Verse(
                    text: Phider.removeIndexFromPhid(phid: _unitID),
                    translate: true,
                  ),
                  icon: phidIcon(context, _unitID),
                  verseCentered: true,
                  onTap: () async {

                    _onSelectUnit(
                      unitID: _unitID,
                      formKey: formKey,
                      text: text,
                      dataCreatorType: dataCreatorType,
                      specValue: specValue,
                      picker: picker,
                      selectedUnitID: selectedUnitID,
                      onExportSpecs: onExportSpecs,
                    );

                    await Nav.goBack(
                      context: context,
                      invoker: 'IntegerAndDoubleDataCreator._onSelectUnit',
                    );

                  },
                );

              }
          );

        }
    );

  }

  /// OTHERWISE
  else {
    blog('_onUnitSelectorTap : OTHERWISE : wtf man : ${_unitChain?.sons}');
  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _onSelectUnit({
  @required String unitID,
  @required String text,
  @required ValueNotifier<String> selectedUnitID,
  @required PickerModel picker,
  @required ValueNotifier<dynamic> specValue,
  @required DataCreator dataCreatorType,
  @required GlobalKey<FormState> formKey,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}){

  blog('selected unit : $unitID');

  selectedUnitID.value = unitID;

  onDataCreatorKeyboardChanged(
    text: text,
    formKey: formKey,
    dataCreatorType: dataCreatorType,
    specValue: specValue,
    picker: picker,
    selectedUnitID: selectedUnitID.value,
    onExportSpecs: onExportSpecs,
  );

}
// -----------------------------------------------------------------------------

/// SHARED METHODS

// --------------------
/// TESTED : WORKS PERFECT
void onDataCreatorKeyboardChanged({
  @required GlobalKey<FormState> formKey,
  @required String text,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}) {

  Formers.validateForm(formKey);

  _fixValueDataTypeAndSetValue(
    text: text,
    dataCreatorType: dataCreatorType,
    specValue: specValue,
  );

  _createSpecsFromLocalDataAndExport(
    text: text,
    specValue: specValue,
    picker: picker,
    selectedUnitID: selectedUnitID,
    onExportSpecs: onExportSpecs,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDataCreatorKeyboardSubmittedAnd({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required String text,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
  ValueChanged<String> onKeyboardSubmitted,
}) async {

  onDataCreatorKeyboardChanged(
    formKey: formKey,
    text: text,
    dataCreatorType: dataCreatorType,
    specValue: specValue,
    picker: picker,
    selectedUnitID: selectedUnitID,
    onExportSpecs: onExportSpecs,
  );

  Keyboard.closeKeyboard(context);

  if (onKeyboardSubmitted != null){
    await Future<void>.delayed(Ratioz.durationSliding400,
            () async {
          onKeyboardSubmitted(text);
        });
  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _fixValueDataTypeAndSetValue({
  @required String text,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
}){
  // NOTE : controller.text = '$_value'; => can not redefine controller, it bugs text field

  /// OLD WAY AND WORKS
  /// IF INT
  if (DataCreation.checkIsIntDataCreator(dataCreatorType) == true){
    final double _doubleFromString = Numeric.transformStringToDouble(text);
    specValue.value = _doubleFromString.toInt();
  }

  /// IF DOUBLE
  else if (DataCreation.checkIsDoubleDataCreator(dataCreatorType) == true){
    specValue.value = Numeric.transformStringToDouble(text);
  }

  /// OTHERWISE
  else {
    specValue.value = text;
  }

  /// TASK : TEST THIS
  // specValue.value = _fixValueDataType(
  //   value: text,
  //   dataCreatorType: dataCreatorType,
  // );

}
// --------------------
/// TESTED : WORKS PERFECT
dynamic _fixValueDataType({
  @required dynamic value,
  @required DataCreator dataCreatorType,
}){

  /// IF INT
  if (DataCreation.checkIsIntDataCreator(dataCreatorType) == true){
    int _output;

    if (value is String){
      _output = Numeric.transformStringToInt(value);
    }
    else if (value is num){
      _output = value.toInt();
    }

    return _output;
  }

  /// IF DOUBLE
  else if (DataCreation.checkIsDoubleDataCreator(dataCreatorType) == true){
    double _output;

    if (value is String){
      _output = Numeric.transformStringToDouble(value);
    }
    else if (value is num){
      _output = value.toDouble();
    }

    return _output;
  }


  /// OTHERWISE
  else {
    return value;
  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _createSpecsFromLocalDataAndExport({
  @required String text,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}){

  final List<SpecModel> _specs = _createSpecsForValueAndUnit(
    text: text,
    value: specValue.value,
    picker: picker,
    selectedUnitID: selectedUnitID,
  );

  onExportSpecs(_specs);
}
// --------------------
/// TESTED : WORKS PERFECT
List<SpecModel> _createSpecsForValueAndUnit({
  @required String text,
  @required PickerModel picker,
  @required dynamic value,
  @required String selectedUnitID,
}){
  final List<SpecModel> _output = <SpecModel>[];

  /// when there is value
  if (TextCheck.isEmpty(text) == false){

    /// CREATE SPEC FOR VALUE
    final SpecModel _valueSpec = SpecModel(
      pickerChainID: picker.chainID,
      value: value,
    );
    _output.add(_valueSpec);

    /// CREATE SPEC FOR UNIT IF EXISTS
    if (picker.unitChainID != null){

      final SpecModel _unitSpec = SpecModel(
        pickerChainID: picker.unitChainID,
        value: selectedUnitID,
      );
      _output.add(_unitSpec);

    }

  }

  return _output;
}
// -----------------------------------------------------------------------------
