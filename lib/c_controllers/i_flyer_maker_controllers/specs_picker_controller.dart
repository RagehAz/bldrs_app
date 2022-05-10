import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/spec_picker_screen.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;

Future<void> onSpecPickerTap({
  @required BuildContext context,
  @required SpecPicker specPicker,
  @required List<SpecPicker> sourceSpecPickers,
  @required ValueNotifier<List<SpecPicker>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  blog('_onSpecPickerTap : chainID : ${specPicker?.chainID} : groupID : ${specPicker?.groupID}');
  final Chain _specChain = superGetChain(context, specPicker.chainID);

  if (_specChain.sons.runtimeType != DataCreator) {
    await _goToSpecPickerScreen(
      specPicker: specPicker,
      sourceSpecPickers: sourceSpecPickers,
      selectedSpecs: selectedSpecs,
      refinedPickers: refinedPickers,
      context: context,
    );
  }

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
// -----------------------------------------------------------------------------
Future<void> _goToSpecPickerScreen({
  @required BuildContext context,
  @required SpecPicker specPicker,
  @required List<SpecPicker> sourceSpecPickers,
  @required ValueNotifier<List<SpecPicker>> refinedPickers,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
}) async {

  final List<SpecModel> _result = await Nav.goToNewScreen(
    context,
    SpecPickerScreen(
      specPicker: specPicker,
      allSelectedSpecs: selectedSpecs.value,
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
void onRemoveSpec({
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required SpecModel spec,
}){

  final List<SpecModel> _newList = SpecModel.removeSpecFromSpecs(
    specs: selectedSpecs.value,
    spec: spec,
  );

  selectedSpecs.value = _newList;

}
// -----------------------------------------------------------------------------
