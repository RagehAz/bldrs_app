import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoBackFromPickerScreen({
  required BuildContext context,
  required List<SpecModel> specsToPassBack,
  required String? phidToPassBack,
  required bool isMultipleSelectionMode,
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
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectPhidInPickerScreen({
  required BuildContext context,
  required String? phid,
  required bool isMultipleSelectionMode,
  required PickerModel? picker,
  required ValueNotifier<List<SpecModel>> selectedSpecsNotifier,
  required bool mounted,
}) async {

  picker?.blogPicker();
  blog('onSelectPhidInPickerScreen : phid : ${Phider.removeIndexFromPhid(phid: phid)} : isMultipleSelectionMode : $isMultipleSelectionMode');

  if (isMultipleSelectionMode == true){
    await _insertPhidToSelectedSpecs(
      context: context,
      phid: Phider.removeIndexFromPhid(phid: phid),
      picker: picker,
      selectedSpecs: selectedSpecsNotifier,
      mounted: mounted,
    );
  }

  else {
    await onGoBackFromPickerScreen(
      context: context,
      phidToPassBack: Phider.removeIndexFromPhid(phid: phid),
      isMultipleSelectionMode: isMultipleSelectionMode,
      specsToPassBack: selectedSpecsNotifier.value,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _insertPhidToSelectedSpecs({
  required BuildContext context,
  required String? phid,
  required PickerModel? picker,
  required ValueNotifier<List<SpecModel>> selectedSpecs,
  required bool mounted,
}) async {

  if (picker != null && picker.chainID != null){

    final SpecModel _spec = SpecModel(
      pickerChainID: picker.chainID,
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
      if (Mapper.boolIsTrue(picker.canPickMany) == true) {

        final List<SpecModel> _specs = [...selectedSpecs.value];
        _specs.removeAt(_specIndex);

        setNotifier(
            notifier: selectedSpecs,
            mounted: mounted,
            value: _specs,
        );

        // _selectedSpecs.value.removeAt(_specIndex);
      }

      /// A2 - CAN NOT PICK MANY
      else {

        final List<SpecModel> _specs = [...selectedSpecs.value];
        _specs.removeAt(_specIndex);

        setNotifier(
            notifier: selectedSpecs,
            mounted: mounted,
            value: _specs,
        );

        // _selectedSpecs.value.removeAt(_specIndex);

      }
    }
    // ----------------------------------------------------------
    /// B - NEW SELECTED SPEC
    else {
      /// B1 - WHEN CAN PICK MANY
      if (Mapper.boolIsTrue(picker.canPickMany) == true) {
        final List<SpecModel> _specs = [...selectedSpecs.value, _spec];

        setNotifier(
            notifier: selectedSpecs,
            mounted: mounted,
            value: _specs,
        );

        // _selectedSpecs.value .add(_spec);

      }

      /// B2 - WHEN CAN NOT PICK MANY
      else {
        final int _specIndex = selectedSpecs.value
            .indexWhere((SpecModel spec) => spec.pickerChainID == picker.chainID);

        /// C1 - WHEN NO SPEC OF THIS KIND IS SELECTED
        if (_specIndex == -1) {
          final List<SpecModel> _specs = [...selectedSpecs.value, _spec];

          setNotifier(
              notifier: selectedSpecs,
              mounted: mounted,
              value: _specs,
          );


          // _selectedSpecs.value.add(_spec);

        }

        /// C2 - WHEN A SPEC OF THIS KIND ALREADY EXISTS TO BE REPLACED
        else {

          final List<SpecModel> _specs = [...selectedSpecs.value];
          _specs.removeAt(_specIndex);
          _specs.add(_spec);

          setNotifier(
              notifier: selectedSpecs,
              mounted: mounted,
              value: _specs,
          );


          // _selectedSpecs.value.removeAt(_specIndex);
          // _selectedSpecs.value.add(_spec);

        }
      }
    }
    // ----------------------------------------------------------

  }


}
// -----------------------------------------------------------------------------
