import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/b_picker_screen.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// BUILDING THE CHAINS

// --------------------
/// TESTED : WORKS PERFECT
bool allChainsCanNotBeBuilt({
  @required BuildContext context,
}){

  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  final Chain _propertyChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.property,
    onlyUseCityChains: true,
  );
  final Chain _designChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.design,
    onlyUseCityChains: true,
  );
  final Chain _tradesChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.trade,
    onlyUseCityChains: true,
  );
  final Chain _productChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.product,
    onlyUseCityChains: true,
  );
  final Chain _equipmentChain = _chainsProvider.getChainKByFlyerType(
    flyerType: FlyerType.equipment,
    onlyUseCityChains: true,
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
// --------------------
/// TESTED : WORKS PERFECT
bool canBuildChain(Chain chain){
  return Mapper.checkCanLoopList(chain?.sons) == true;
}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChainPickingPickerTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required bool onlyUseCityChains,
  @required bool isMultipleSelectionMode,
  @required ValueNotifier<List<PickerModel>> refinedSpecsPickers,
  @required List<PickerModel> allSpecPickers,
  @required ZoneModel zone,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: PickerScreen(
      picker: picker,
      selectedSpecs: selectedSpecs,
      onlyUseCityChains: onlyUseCityChains,
      showInstructions: isMultipleSelectionMode,
      isMultipleSelectionMode:  isMultipleSelectionMode,
      zone: zone,
    ),
  );

  if (_result != null){

    /// WHILE SELECTING MULTIPLE PHIDS
    if (isMultipleSelectionMode == true){

      _updatePickersAndGroups(
        context: context,
        picker: picker,
        selectedSpecs: selectedSpecs,
        refinedPickers: refinedSpecsPickers,
        sourcePickers: allSpecPickers,
        specPickerResult: _result,
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
void _updatePickersAndGroups({
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
    if (ObjectCheck.objectIsListOfSpecs(specPickerResult)) {
      // Spec.printSpecs(_allSelectedSpecs);

      selectedSpecs.value = specPickerResult;

      refinedPickers.value = PickerModel.applyBlockersAndSort(
        sourcePickers: sourcePickers,
        selectedSpecs: specPickerResult,
        sort: true,
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
