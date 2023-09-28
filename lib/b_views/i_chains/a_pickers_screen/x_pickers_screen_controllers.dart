import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/b_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BUILDING THE CHAINS

// --------------------
/*
/// TESTED : WORKS PERFECT
bool allChainsCanNotBeBuiltt({
  required BuildContext context,
}){

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  final Chain _propertyChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.property,
    onlyUseZoneChains: true,
  );
  final Chain _designChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.design,
    onlyUseZoneChains: true,
  );
  final Chain _tradesChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.trade,
    onlyUseZoneChains: true,
  );
  final Chain _productChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.product,
    onlyUseZoneChains: true,
  );
  final Chain _equipmentChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.equipment,
    onlyUseZoneChains: true,
  );

  bool _allCanNotBeBuilt = false;

  if (
      canBuildChain(_propertyChain) == false &&
      canBuildChain(_designChain) == false &&
      canBuildChain(_tradesChain) == false &&
      canBuildChain(_productChain) == false &&
      canBuildChain(_equipmentChain) == false
  ){
    _allCanNotBeBuilt = true;
  }

  return _allCanNotBeBuilt;


}
 */
// --------------------
/*
/// TESTED : WORKS PERFECT
bool canBuildChain(Chain chain){
  return Mapper.checkCanLoopList(chain?.sons) == true;
}
 */
// -----------------------------------------------------------------------------

/// NAVIGATION & SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoBackFromPickersScreen({
  required BuildContext context,
  required bool isMultipleSelectionMode,
  required ValueNotifier<List<SpecModel>> selectedSpecs,
  required List<SpecModel>? widgetSelectedSpecs,
}) async {

  bool _canContinue = true;

  if (isMultipleSelectionMode == true){
    final bool _specsChanged = SpecModel.checkSpecsListsAreIdentical(
        widgetSelectedSpecs ?? [],
        selectedSpecs.value
    ) == false;

    if (_specsChanged == true){
      _canContinue = await Dialogs.discardChangesGoBackDialog();
    }
  }

  if (_canContinue == true){
    await Nav.goBack(
      context: context,
      invoker: 'SpecPickerScreen.goBack',
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToPickerScreen({
  required BuildContext context,
  required PickerModel picker,
  required ValueNotifier<List<SpecModel>> selectedSpecsNotifier,
  required bool onlyUseZoneChains,
  required bool isMultipleSelectionMode,
  required ValueNotifier<List<PickerModel>> refinedPickersNotifier,
  required List<PickerModel> allPickers,
  required ZoneModel? zone,
  required bool mounted,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
    context: context,
    pageTransitionType: Nav.superHorizontalTransition(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    ),
    screen: PickerScreen(
      picker: picker,
      selectedSpecs: selectedSpecsNotifier,
      onlyUseZoneChains: onlyUseZoneChains,
      showInstructions: isMultipleSelectionMode,
      isMultipleSelectionMode:  isMultipleSelectionMode,
      zone: zone,
    ),
  );

  if (_result != null){

    /// WHILE SELECTING MULTIPLE PHIDS
    if (isMultipleSelectionMode == true){

      _updateSelectedSpecsAndRefinePickers(
        picker: picker,
        selectedSpecs: selectedSpecsNotifier,
        refinedPickers: refinedPickersNotifier,
        sourcePickers: allPickers,
        specPickerResult: _result,
        mounted: mounted,
      );

    }

    /// WHILE SELECTING ONLY ONE PHID
    else {
      await Nav.goBack(
        context: context,
        invoker: 'onSpecPickerTap',
        passedData: _result,
      );
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void _updateSelectedSpecsAndRefinePickers({
  required dynamic specPickerResult,
  required PickerModel picker,
  required List<PickerModel> sourcePickers,
  required ValueNotifier<List<PickerModel>> refinedPickers,
  required ValueNotifier<List<SpecModel>> selectedSpecs,
  required bool mounted,
}) {

  final Chain? _specChain = ChainsProvider.proFindChainByID(
    chainID: picker.chainID,
  );

  // -------------------------------------------------------------
  if (specPickerResult != null && _specChain != null) {
    // ------------------------------------
    /// A - SONS ARE FROM DATA CREATOR
    if (_specChain.sons.runtimeType == DataCreator) {}
    // ------------------------------------
    /// B - WHEN FROM LIST OF KWs
    if (SpecModel.objectIsListOfSpecs(specPickerResult)) {
      // Spec.printSpecs(_allSelectedSpecs);

      setNotifier(
          notifier: selectedSpecs,
          mounted: mounted,
          value: specPickerResult
      );

      setNotifier(
          notifier: refinedPickers,
          mounted: mounted,
          value: PickerModel.applyBlockersAndSort(
            sourcePickers: sourcePickers,
            selectedSpecs: specPickerResult,
            sort: true,
          ),
      );

    }
    // ------------------------------------
    /// C - WHEN SOMETHING GOES WRONG
    else {
      blog('RED ALERT : result : $specPickerResult');
    }
    // ------------------------------------
  }
  // -------------------------------------------------------------
}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
void onRemoveSpecs({
  required ValueNotifier<List<SpecModel>> selectedSpecsNotifier,
  required SpecModel? valueSpec,
  required SpecModel? unitSpec,
  required List<PickerModel> pickers,
  required bool mounted,
}){

  blog('should remove these specs from the list');

  List<SpecModel> _newList = SpecModel.removeSpecFromSpecs(
    specs: selectedSpecsNotifier.value,
    spec: valueSpec,
  );

  final bool _specsIncludeOtherSpecUsingThisUnit = SpecModel.specsIncludeOtherSpecUsingThisUnit(
    specs: selectedSpecsNotifier.value,
    pickers: pickers,
    unitSpec: unitSpec,
  );

  if (_specsIncludeOtherSpecUsingThisUnit == false){
    _newList = SpecModel.removeSpecFromSpecs(
      specs: selectedSpecsNotifier.value,
      spec: unitSpec,
    );
  }

  setNotifier(
      notifier: selectedSpecsNotifier,
      mounted: mounted,
      value: _newList
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAddSpecs({
  required List<SpecModel> specs,
  required PickerModel? picker,
  required ValueNotifier<List<SpecModel>> selectedSpecs,
  required bool mounted,
}) {

  final List<SpecModel> _updatedList = SpecModel.putSpecsInSpecs(
    parentSpecs: selectedSpecs.value,
    inputSpecs: specs,
    canPickMany: picker?.canPickMany,
  );

  setNotifier(
      notifier: selectedSpecs,
      mounted: mounted,
      value: _updatedList
  );


}
// -----------------------------------------------------------------------------
