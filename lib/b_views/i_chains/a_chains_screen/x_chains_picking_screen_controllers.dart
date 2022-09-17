import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/chain/dd_data_creation.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_picking_screen.dart';
import 'package:bldrs/b_views/i_chains/b_pickers_screen/b_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
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

/// SETTING ACTIVE PHIDK

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSectionButtonTap(BuildContext context) async {

  final dynamic result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: ChainsPickingScreen(
      flyerTypesChainFilters: null,
      onlyUseCityChains: true,
      isMultipleSelectionMode: false,
      pageTitleVerse: const Verse(
        text: 'phid_browse_flyers_by_keyword',
        translate: true,
      ),
      zone: ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
      ),
    ),
  );

  if (result != null && result is String){

    await _setActivePhidK(
      context: context,
      phidK: result,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _setActivePhidK({
  @required BuildContext context,
  @required String phidK,
}) async {

  const bool deactivated = false;

  final List<Chain> allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: false,
      listen: false
  );

  final String _chainID = Chain.getRootChainIDOfPhid(
    allChains: allChains,
    phid: phidK,
  );

  final FlyerType _flyerType = FlyerTyper.concludeFlyerTypeByChainID(
    chainID: _chainID,
  );

  /// A - if section is not active * if user is author or not
  if (deactivated == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: _flyerType
    );

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse(
        text: '##Section "$_flyerTypePhid" is\nTemporarily closed in $_currentCityID',
        translate: true,
        variables: [_flyerTypePhid, _currentCityID]
      ),
      bodyVerse: Verse(
        text: '##The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        translate: true,
        variables: _currentCityID,
      ),
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: const Verse(
              text: 'phid_inform_a_friend',
              translate: true,
            ),
            width: 133,
            onTap: () => Launcher.shareLink(
              context : context,
              link: Standards.bldrsWebSiteLink,
            ),
          ),

          DialogButton(
            verse: const Verse(
              text: 'phid_go_back',
              translate: true,
            ),
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(
              context: context,
              invoker: '_setActivePhidK.centerDialog',
            ),
          ),

        ],
      ),
    );
  }

  /// A - if section is active
  else {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);
    await _keywordsProvider.changeHomeWallFlyerType(
      context: context,
      flyerType: _flyerType,
      phid: phidK,
      notify: true,
    );

  }


}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
Future<void> onPickerTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required List<SpecModel> originalSpecs,
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
      originalSpecs: originalSpecs,
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
