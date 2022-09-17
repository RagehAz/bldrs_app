import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoBackFromPickerScreen({
  @required BuildContext context,
  @required List<SpecModel> specsToPassBack,
  @required String phidToPassBack,
  @required bool isMultipleSelectionMode,
}) async {

  if (isMultipleSelectionMode == true){
    await Nav.goBack(
      context: context,
      invoker: 'onGoBackFromSpecPickerScreen : isMultipleSelectionMode : $isMultipleSelectionMode',
      passedData: specsToPassBack,
    );
  }

  /// NOTE : if in single selection mode : phid is passes with [onSelectPhidInPickerScreen] method
  else {
    await Nav.goBack(
        context: context,
        invoker: 'onGoBackFromSpecPickerScreen : isMultipleSelectionMode : $isMultipleSelectionMode',
        passedData: phidToPassBack
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoBackFromChainsPickingScreen({
  @required BuildContext context,
  @required bool isMultipleSelectionMode,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required List<SpecModel> widgetSelectedSpecs,
}) async {

  bool _canContinue = true;

  if (isMultipleSelectionMode == true){
    final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
        widgetSelectedSpecs ?? [],
        selectedSpecs.value
    ) == false;

    if (_specsChanged == true){
      _canContinue = await Dialogs.discardChangesGoBackDialog(context);
    }
  }

  if (_canContinue == true){
    await Nav.goBack(
      context: context,
      invoker: 'SpecPickerScreen.goBack',
    );
  }

}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectPhidInPickerScreen({
  @required BuildContext context,
  @required String phid,
  @required bool isMultipleSelectionMode,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  if (isMultipleSelectionMode == true){
    await _updateSelectedSpecsAtPhidSelection(
      context: context,
      phid: phid,
      picker: picker,
      selectedSpecs: selectedSpecs,
    );
  }

  else {
    await onGoBackFromPickerScreen(
      context: context,
      phidToPassBack: phid,
      isMultipleSelectionMode: isMultipleSelectionMode,
      specsToPassBack: selectedSpecs.value,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _updateSelectedSpecsAtPhidSelection({
  @required BuildContext context,
  @required String phid,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

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
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
void onRemoveSpecs({
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required SpecModel valueSpec,
  @required SpecModel unitSpec,
  @required List<PickerModel> pickers,
}){

  blog('should remove these specs from the list');

  List<SpecModel> _newList = SpecModel.removeSpecFromSpecs(
    specs: selectedSpecs.value,
    spec: valueSpec,
  );

  final bool _specsIncludeOtherSpecUsingThisUnit = SpecModel.specsIncludeOtherSpecUsingThisUnit(
    specs: selectedSpecs.value,
    pickers: pickers,
    unitSpec: unitSpec,
  );

  if (_specsIncludeOtherSpecUsingThisUnit == false){

    _newList = SpecModel.removeSpecFromSpecs(
      specs: selectedSpecs.value,
      spec: unitSpec,
    );

  }


  selectedSpecs.value = _newList;

}
// --------------------
/// TESTED : WORKS PERFECT
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
// -----------------------------------------------------------------------------
