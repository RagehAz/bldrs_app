import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/c_currencies_screen/c_currencies_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// CURRENCY DATA CREATOR

// ------------------------------
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
// ------------------------------
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
// ------------------------------
Future<void> onCurrencySelectorButtonTap({
  @required BuildContext context,
  @required ZoneModel zone,
  @required ValueNotifier<String> selectedCurrencyID,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController textController,
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

    validateField(formKey);

    _createSpecsFromLocalDataAndExport(
      textController: textController,
      specValue: specValue,
      picker: picker,
      selectedUnitID: selectedCurrencyID.value,
      onExportSpecs: onExportSpecs,
    );

  }

}
// ------------------------------
String currencyFieldValidator({
  @required BuildContext context,
  @required ValueNotifier<String> selectedCurrencyID,
  @required TextEditingController textController,
}) {
  String _output;

  final CurrencyModel selectedCurrency = ZoneProvider.proGetCurrencyByCurrencyID(
      context: context,
      currencyID: selectedCurrencyID.value,
      listen: false
  );

  if (selectedCurrency != null){

    final int _maxDigits = selectedCurrency.digits;

    final String _numberString = textController.text;
    final String _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(_numberString, '.');
    final int _numberOfFractions = _fractionsStrings.length;
    final bool _invalidDigits = _numberOfFractions > _maxDigits;

    // blog('_numberOfFractions : $_numberOfFractions : _numberString : $_numberString : _fractionsStrings : $_fractionsStrings');

    if (_invalidDigits == true) {
      final String _error = 'Can not add more than $_maxDigits fractions';
      // blog(_error);
      _output = _error;
    }

    // else {
    //   blog('tamam');
    //   return null;
    // }

  }

  return _output;
}
// ------------------------------
/// TASK : DELETE ME WHEN EVERYTHING IS GOOD : OLD CURRENCIES DIALOG
/*
  static Future<void> showCurrencyDialog({
    @required BuildContext context,
    @required ValueChanged<CurrencyModel> onSelectCurrency,
    // @required
  }) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CurrencyModel> _allCurrencies = _zoneProvider.allCurrencies;
    final CurrencyModel _currentCurrency = _zoneProvider.currentCurrency;
    final CurrencyModel _usdCurrency =
    CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _allCurrencies,
      countryID: 'usa',
    );

    final double _clearWidth = BottomDialog.clearWidth(context);

    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      child: SizedBox(
        width: _clearWidth,
        height: BottomDialog.clearHeight(context: context, draggable: true),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            CurrencyButton(
              width: _clearWidth,
              currency: _currentCurrency,
              countryID: _currentCurrency.countriesIDs[0],
              onTap: onSelectCurrency,
            ),

            CurrencyButton(
              width: _clearWidth,
              currency: _usdCurrency,
              countryID: 'USA',
              onTap: onSelectCurrency,
            ),

            const DotSeparator(),

            DreamBox(
              height: 60,
              width: _clearWidth,
              verse: '##More Currencies',
              verseShadow: false,
              verseWeight: VerseWeight.thin,
              verseCentered: false,
              verseItalic: true,
              icon: Iconz.dollar,
              iconSizeFactor: 0.6,
              color: Colorz.blackSemi255,
              bubble: false,
              onTap: () async {
                await BottomDialog.showBottomDialog(
                  context: context,
                  draggable: true,
                  child: SizedBox(
                    width: _clearWidth,
                    height: BottomDialog.clearHeight(
                        context: context, draggable: true),
                    child: OldMaxBounceNavigator(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _allCurrencies.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            final CurrencyModel _currency =
                                _allCurrencies[index];

                            return CurrencyButton(
                              width: _clearWidth,
                              currency: _currency,
                              countryID: _currency.countriesIDs[0],
                              onTap: (CurrencyModel currency) {

                                onSelectCurrency(currency);

                                Nav.goBack(
                                  context: context,
                                  invoker: 'PriceDataCreator',
                                );

                              },
                            );
                          }
                          ),
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _onCurrencyTap() async {

    await PriceDataCreator.showCurrencyDialog(
      context: context,
      onSelectCurrency: (CurrencyModel currency) => _onSelectCurrency(currency),
    );

  }

 */
// -----------------------------------------------------------------------------

/// NUMBER DATA CREATOR

// ------------------------------
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
  // ---------------------------------
  specValue.value = _fixValueDataType(
    value: initialValue?.value,
    dataCreatorType: dataCreatorType,
  );

  blog('a77aaaa :${specValue.value}');

  textController.text = specValue.value?.toString() ?? '';
// ---------------------------------
  final Chain _unitChain = ChainsProvider.proFindChainByID(
    context: context,
    chainID: picker.unitChainID,
  );
// ---------------------------------
  _initializeNumberUnit(
    initialUnit: initialUnit,
    selectedUnitID: selectedUnitID,
    unitChain: _unitChain,
  );
// ---------------------------------

}
// ------------------------------
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
// ------------------------------
String numberFieldValidator() {

  /// NEED TO VALIDATE IF FIELD IS REQUIRED
  /// IF ITS INT OR DOUBLE

  // final int _maxDigits = _currency.value.digits;
  //
  // final String _numberString = controller.text;
  // final String _fractionsStrings = TextMod.removeTextBeforeFirstSpecialCharacter(_numberString, '.');
  // final int _numberOfFractions = _fractionsStrings.length;
  //
  // bool _invalidDigits = _numberOfFractions > _maxDigits;
  //
  // print('_numberOfFractions : $_numberOfFractions : _numberString : $_numberString : _fractionsStrings : $_fractionsStrings');
  //
  // if (_invalidDigits == true){
  //
  //   final String _error = 'Can not add more than ${_maxDigits} fractions';
  //
  //   print(_error);
  //
  //   return _error;
  //
  // } else {
  //
  //   print('tamam');
  //
  //   return null;
  //
  // }

  return null;
}
// ------------------------------
Future<void> onUnitSelectorButtonTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required TextEditingController textController,
  @required ValueNotifier<String> selectedUnitID,
  @required ValueNotifier<dynamic> specValue,
  @required DataCreator dataCreatorType,
  @required GlobalKey<FormState> formKey,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}) async {
// ---------------------------------
  final Chain _unitChain = ChainsProvider.proFindChainByID(
    context: context,
    chainID: picker.unitChainID,
  );
// ---------------------------------
  Keyboard.closeKeyboard(context);

  final bool _arePhids = Chain.checkSonsArePhids(_unitChain.sons) == true;

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
                final String _unitName = _unitID;

                return BottomDialog.wideButton(
                  context: context,
                  verse: _unitName,
                  icon: phidIcon(context, _unitID),
                  verseCentered: true,
                  onTap: () async {

                    _onSelectUnit(
                      unitID: _unitID,
                      formKey: formKey,
                      textController: textController,
                      dataCreatorType: dataCreatorType,
                      specValue: specValue,
                      picker: picker,
                      selectedUnitID: selectedUnitID,
                      onExportSpecs: onExportSpecs,
                    );

                    Nav.goBack(
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
    blog('_onUnitSelectorTap : OTHERWISE : wtf man : ${_unitChain.sons}');
  }

}
// ---------------------------------
void _onSelectUnit({
  @required String unitID,
  @required TextEditingController textController,
  @required ValueNotifier<String> selectedUnitID,
  @required PickerModel picker,
  @required ValueNotifier<dynamic> specValue,
  @required DataCreator dataCreatorType,
  @required GlobalKey<FormState> formKey,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}){

  blog('selected unit : $unitID');

  selectedUnitID.value = unitID;

  onKeyboardChanged(
    textController: textController,
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

// ------------------------------
void onKeyboardChanged({
  @required GlobalKey<FormState> formKey,
  @required TextEditingController textController,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}) {

  validateField(formKey);

  _fixValueDataTypeAndSetValue(
    controller: textController,
    dataCreatorType: dataCreatorType,
    specValue: specValue,
  );

  _createSpecsFromLocalDataAndExport(
    textController: textController,
    specValue: specValue,
    picker: picker,
    selectedUnitID: selectedUnitID,
    onExportSpecs: onExportSpecs,
  );

}
// ------------------------------
Future<void> onKeyboardSubmitted({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController textController,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
  @required Function onKeyboardSubmitted,
}) async {

  onKeyboardChanged(
    formKey: formKey,
    textController: textController,
    dataCreatorType: dataCreatorType,
    specValue: specValue,
    picker: picker,
    selectedUnitID: selectedUnitID,
    onExportSpecs: onExportSpecs,
  );

  Keyboard.closeKeyboard(context);

  await Future<void>.delayed(Ratioz.durationSliding400,
          () async {
        await onKeyboardSubmitted();
      });
}
// ----------------------------------------
/// TASK : TEST THIS
void _fixValueDataTypeAndSetValue({
  @required TextEditingController controller,
  @required DataCreator dataCreatorType,
  @required ValueNotifier<dynamic> specValue,
}){
  // NOTE : controller.text = '$_value'; => can not redefine controller, it bugs text field

  /// OLD WAY AND WORKS
  // /// IF INT
  // if (isIntDataCreator(dataCreatorType) == true){
  //   final double _doubleFromString = Numeric.transformStringToDouble(controller.text);
  //   specValue.value = _doubleFromString.toInt();
  // }
  //
  // /// IF DOUBLE
  // else if (isDoubleDataCreator(dataCreatorType) == true){
  //   specValue.value = Numeric.transformStringToDouble(controller.text);
  // }
  //
  // /// OTHERWISE
  // else {
  //   specValue.value = controller.text;
  // }

  /// TASK : TEST THIS
  specValue.value = _fixValueDataType(
    value: controller.text,
    dataCreatorType: dataCreatorType,
  );

}
// ----------------------------------------
/// TASK : TEST THIS
dynamic _fixValueDataType({
  @required dynamic value,
  @required DataCreator dataCreatorType,
}){

  /// IF INT
  if (isIntDataCreator(dataCreatorType) == true){
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
  else if (isDoubleDataCreator(dataCreatorType) == true){
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
// ------------------------------
void validateField(GlobalKey<FormState> formKey) {
  formKey.currentState.validate();
}
// -----------------------------------------------------------------------------
void _createSpecsFromLocalDataAndExport({
  @required TextEditingController textController,
  @required ValueNotifier<dynamic> specValue,
  @required PickerModel picker,
  @required String selectedUnitID,
  @required ValueChanged<List<SpecModel>> onExportSpecs,
}){

  final List<SpecModel> _specs = _createSpecsForValueAndUnit(
    controller: textController,
    value: specValue.value,
    picker: picker,
    selectedUnitID: selectedUnitID,
  );

  onExportSpecs(_specs);
}
// -----------------------------------------------------------------------------
/// TASK : TEST THIS
List<SpecModel> _createSpecsForValueAndUnit({
  @required TextEditingController controller,
  @required PickerModel picker,
  @required dynamic value,
  @required String selectedUnitID,
}){
  final List<SpecModel> _output = <SpecModel>[];

  /// when there is value
  if (TextCheck.isEmpty(controller.text) == false){

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
