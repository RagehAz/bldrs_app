import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// NAVIGATION

// -----------------------------------
void onGoBackFromPickerScreen({
  @required BuildContext context,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required String passPhidBack,
  @required bool isMultipleSelectionMode,
}) {

  if (isMultipleSelectionMode == true){
    Nav.goBack(
      context: context,
      invoker: 'onGoBackFromSpecPickerScreen : isMultipleSelectionMode : $isMultipleSelectionMode',
      passedData: selectedSpecs.value,
    );
  }

  else {
    Nav.goBack(
        context: context,
        invoker: 'onGoBackFromSpecPickerScreen : isMultipleSelectionMode : $isMultipleSelectionMode',
        passedData: passPhidBack
    );
  }

}



/*
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
      showInstructions: true,
      isMultipleSelectionMode: true,
      onlyUseCityChains: false,
    ),
    transitionType: Nav.superHorizontalTransition(context),
  );

  SpecModel.blogSpecs(_result);

  updateSpecsPickersAndGroups(
    context: context,
    specPicker: specPicker,
    specPickerResult: _result,
    refinedPickers: refinedPickers,
    selectedSpecs: selectedSpecs,
    sourceSpecPickers: sourceSpecPickers,
  );

}
 */
// -----------------------------------
void updatePickersAndGroups({
  @required BuildContext context,
  @required dynamic specPickerResult,
  @required PickerModel picker,
  @required List<PickerModel> sourcePickers,
  @required ValueNotifier<List<PickerModel>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) {

  final Chain _specChain = ChainsProvider.proFindChainByID(
    context: context,
    chainID: picker.chainID,
  );

  // -------------------------------------------------------------
  if (specPickerResult != null && _specChain != null) {
    // ------------------------------------
    /// A - SONS ARE FROM DATA CREATOR
    if (_specChain.sons.runtimeType == DataCreator) {}
    // ------------------------------------
    /// B - WHEN FROM LIST OF KWs
    if (ObjectChecker.objectIsListOfSpecs(specPickerResult)) {
      // Spec.printSpecs(_allSelectedSpecs);

      selectedSpecs.value = specPickerResult;

      refinedPickers.value = PickerModel.applyBlockers(
        sourcePickers: sourcePickers,
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

/// PICKER SCREEN

// -----------------------------------
Future<void> onSelectPhid({
  @required BuildContext context,
  @required String phid,
  @required bool isMultipleSelectionMode,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  if (isMultipleSelectionMode == true){
    await updateSelectedSpecsAtPhidSelection(
      context: context,
      phid: phid,
      picker: picker,
      selectedSpecs: selectedSpecs,
    );
  }

  else {
    onGoBackFromPickerScreen(
      context: context,
      passPhidBack: phid,
      isMultipleSelectionMode: isMultipleSelectionMode,
      selectedSpecs: selectedSpecs,
    );
  }

}
// -----------------------------------
Future<void> updateSelectedSpecsAtPhidSelection({
  @required BuildContext context,
  @required String phid,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  blog('received kw id : $phid');
  picker?.blogPicker();

  if (picker != null && picker.chainID != null){

    final SpecModel _spec = SpecModel(
      pickerChainID: picker?.chainID,
      value: phid,
    );

    final bool _alreadySelected = SpecModel.checkSpecsContainThisSpec(
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

  }


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
  @required PickerModel picker,
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
  @required PickerModel picker,
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
  @required PickerModel picker,
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
