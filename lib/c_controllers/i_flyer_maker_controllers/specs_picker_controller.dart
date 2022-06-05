import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/spec_picker_screen.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// SPECS PICKERS SCREEN

// -----------------------------------
Future<void> onSpecPickerTap({
  @required BuildContext context,
  @required SpecPicker specPicker,
  @required List<SpecPicker> sourceSpecPickers,
  @required ValueNotifier<List<SpecPicker>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  // blog('_onSpecPickerTap : chainID : ${specPicker?.chainID} : groupID : ${specPicker?.groupID}');
  // final Chain _specChain = superGetChain(context, specPicker.chainID);

  // if (_specChain.sons.runtimeType != DataCreator) {
    await _goToSpecPickerScreen(
      context: context,
      specPicker: specPicker,
      sourceSpecPickers: sourceSpecPickers,
      selectedSpecs: selectedSpecs,
      refinedPickers: refinedPickers,
    );
  // }

  // else {
  //   blog('this picker as a Data creator');
  //   specPicker.blogSpecPicker();
  //   _specChain.blogChain();
  // }

  // else if (_specChain.sons == DataCreator.price) {
  //   await _goToSpecPickerScreen(specPicker);
  // }
  //
  // else if (_specChain.sons == DataCreator.currency) {
  //   await _runCurrencyDialog(specPicker);
  // }
  //
  // else if (_specChain.sons == DataCreator.integerIncrementer) {
  //   blog('aho');
  //   await _goToSpecPickerScreen(specPicker);
  // }
  //
  // else if (_specChain.sons == DataCreator.doubleCreator) {
  //   blog('aho');
  //   await _goToSpecPickerScreen(specPicker);
  // }

}
// -----------------------------------
Future<void> _goToSpecPickerScreen({
  @required BuildContext context,
  @required SpecPicker specPicker,
  @required List<SpecPicker> sourceSpecPickers,
  @required ValueNotifier<List<SpecPicker>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  final List<SpecModel> _result = await Nav.goToNewScreen(
    context: context,
    screen: SpecPickerScreen(
      specPicker: specPicker,
      selectedSpecs: selectedSpecs,
    ),
    transitionType: Nav.superHorizontalTransition(context),
  );

  SpecModel.blogSpecs(_result);

  _updateSpecsPickersAndGroups(
    context: context,
    specPicker: specPicker,
    specPickerResult: _result,
    refinedPickers: refinedPickers,
    selectedSpecs: selectedSpecs,
    sourceSpecPickers: sourceSpecPickers,
  );

}
// -----------------------------------
void _updateSpecsPickersAndGroups({
  @required BuildContext context,
  @required dynamic specPickerResult,
  @required SpecPicker specPicker,
  @required List<SpecPicker> sourceSpecPickers,
  @required ValueNotifier<List<SpecPicker>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {

  final Chain _specChain = superGetChain(context, specPicker.chainID);

  // -------------------------------------------------------------
  if (specPickerResult != null) {
    // ------------------------------------
    /// A - SONS ARE FROM DATA CREATOR
    if (_specChain.sons.runtimeType == DataCreator) {}
    // ------------------------------------
    /// B - WHEN FROM LIST OF KWs
    if (ObjectChecker.objectIsListOfSpecs(specPickerResult)) {
      // Spec.printSpecs(_allSelectedSpecs);

      selectedSpecs.value = specPickerResult;

      refinedPickers.value = SpecPicker.applyDeactivatorsToSpecsPickers(
        sourceSpecsPickers: sourceSpecPickers,
        selectedSpecs: specPickerResult,
      );

    }
    // ------------------------------------
    /// C - WHEN SOMETHING GOES WRONG
    else {
      blog('RED ALERT : result : ${specPickerResult.toString()}');
    }
    // ------------------------------------
  }
  // -------------------------------------------------------------
}
// -----------------------------------
void onRemoveSpecs({
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required List<SpecModel> specs,
}){

  blog('should remove these specs from the list');
  SpecModel.blogSpecs(specs);

  final List<SpecModel> _newList = SpecModel.removeSpecsFromSpecs(
    sourceSpecs: selectedSpecs.value,
    specsToRemove: specs,
  );

  selectedSpecs.value = _newList;

}
// -----------------------------------------------------------------------------

/// SPEC PICKER SCREEN

// -----------------------------------
Future<void> onSelectSpec({
  @required BuildContext context,
  @required String phid,
  @required SpecPicker picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {
  blog('received kw id : $phid');

  // spec.printSpec();
  final SpecModel _spec = SpecModel(
    pickerChainID: picker.chainID,
    value: phid,
  );

  final bool _alreadySelected = SpecModel.specsContainThisSpec(
      specs: selectedSpecs.value,
      spec: _spec
  );

  final int _specIndex = selectedSpecs.value.indexWhere(
          (SpecModel sp) => sp.value == _spec.value
  );

  // ----------------------------------------------------------
  /// A - ALREADY SELECTED SPEC
  if (_alreadySelected == true) {
    /// A1 - CAN PICK MANY
    if (picker.canPickMany == true) {
      final List<SpecModel> _specs = [...selectedSpecs.value];
      _specs.removeAt(_specIndex);
      selectedSpecs.value = _specs;

      // _selectedSpecs.value.removeAt(_specIndex);
    }

    /// A2 - CAN NOT PICK MANY
    else {
      final List<SpecModel> _specs = [...selectedSpecs.value];
      _specs.removeAt(_specIndex);
      selectedSpecs.value = _specs;

      // _selectedSpecs.value.removeAt(_specIndex);

    }
  }
  // ----------------------------------------------------------
  /// B - NEW SELECTED SPEC
  else {
    /// B1 - WHEN CAN PICK MANY
    if (picker.canPickMany == true) {
      final List<SpecModel> _specs = [...selectedSpecs.value, _spec];
      selectedSpecs.value = _specs;

      // _selectedSpecs.value .add(_spec);

    }

    /// B2 - WHEN CAN NOT PICK MANY
    else {
      final int _specIndex = selectedSpecs.value
          .indexWhere((SpecModel spec) => spec.pickerChainID == picker.chainID);

      /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
      if (_specIndex == -1) {
        final List<SpecModel> _specs = [...selectedSpecs.value, _spec];
        selectedSpecs.value = _specs;

        // _selectedSpecs.value.add(_spec);

      }

      /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
      else {
        final List<SpecModel> _specs = [...selectedSpecs.value];
        _specs.removeAt(_specIndex);
        _specs.add(_spec);
        selectedSpecs.value = _specs;

        // _selectedSpecs.value.removeAt(_specIndex);
        // _selectedSpecs.value.add(_spec);

      }
    }
  }
  // ----------------------------------------------------------

  // _selectedSpecs.notifyListeners();
}
// -----------------------------------
void onCurrencyChanged({
  @required CurrencyModel currency,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {

  final SpecModel _currencySpec = SpecModel(
    pickerChainID: 'phid_s_currency',
    value: currency.id,
  );

  final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
    parentSpecs: selectedSpecs.value,
    inputSpecs: <SpecModel>[_currencySpec],
    canPickMany: false,
  );

  selectedSpecs.value = _updatedList;
}
// -----------------------------------
void onPriceChanged({
  @required String price,
  @required SpecPicker picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {

  final double _priceDouble = Numeric.transformStringToDouble(price);

  final SpecModel _priceSpec = SpecModel(
      pickerChainID: picker.chainID,
      value: _priceDouble,
  );

  final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
    parentSpecs: selectedSpecs.value,
    inputSpecs: <SpecModel>[_priceSpec],
    canPickMany: picker.canPickMany,
  );

  selectedSpecs.value = _updatedList;
}
// -----------------------------------
void onAddSpecs({
  @required List<SpecModel> specs,
  @required SpecPicker picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {


  final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
    parentSpecs: selectedSpecs.value,
    inputSpecs: specs,
    canPickMany: picker.canPickMany,
  );

  selectedSpecs.value = _updatedList;
}
// -----------------------------------
void onAddDouble({
  @required double num,
  @required SpecPicker picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {

  blog('received double : $num');
  final SpecModel _doubleSpec = SpecModel(
    pickerChainID: picker.chainID,
    value: num,
  );

  final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
    parentSpecs: selectedSpecs.value,
    inputSpecs: <SpecModel>[_doubleSpec],
    canPickMany: picker.canPickMany,
  );

  selectedSpecs.value = _updatedList;
}
// -----------------------------------
void onGoBackToSpecsPickersScreen({
  @required BuildContext context,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {
  Nav.goBack(context, passedData: selectedSpecs.value);
}
// -----------------------------------------------------------------------------

/*
              List<SpecModel> _createSpecs(){
                final List<SpecModel> _output = <SpecModel>[];

                /// when there is value
                if (stringIsNotEmpty(controller.text) == true){
                  final SpecModel _valueSpec = SpecModel(
                    pickerChainID: widget.specPicker.chainID,
                    value: controller.text,
                  );
                  _output.add(_valueSpec);

                  /// when there is unit chain
                  if (widget.specPicker.unitChainID != null){
                    final SpecModel _unitSpec = SpecModel(
                      pickerChainID: widget.specPicker.unitChainID,
                      value: _selectedUnit.value,
                    );
                    _output.add(_unitSpec);
                  }

                }

                return _output;
              }

 */
