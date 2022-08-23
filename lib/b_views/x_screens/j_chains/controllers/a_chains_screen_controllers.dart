import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/chain/spec_models/picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/a_chains_screen.dart';
import 'package:bldrs/b_views/x_screens/j_chains/b_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// BUILDING THE CHAINS

// --------------------------------
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
// --------------------------------
/// TESTED : WORKS PERFECT
bool canBuildChain(Chain chain){
  return Mapper.checkCanLoopList(chain?.sons) == true;
}
// -----------------------------------------------------------------------------

/// SETTING ACTIVE PHIDK

// --------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSectionButtonTap(BuildContext context) async {

  final dynamic result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: const ChainsScreen(
      flyerTypesChainFilters: null,
      onlyUseCityChains: true,
      isMultipleSelectionMode: false,
      pageTitle: 'Browse Flyers by Keyword',
    ),
  );

  if (result != null && result is String){

    await _setActivePhidK(
      context: context,
      phidK: result,
    );

  }

}
// --------------------------------
/// TESTED : WORKS PERFECT
Future<void> _setActivePhidK({
  @required BuildContext context,
  @required String phidK,
}) async {

  const bool deactivated = false;

  final List<Chain> allChains = ChainsProvider.proGetBigChainK(
      context: context,
      onlyUseCityChains: false,
      listen: false
  )?.sons;

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

    final String _flyerTypeString = FlyerTyper.translateFlyerType(
        context: context,
        flyerType: _flyerType
    );

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Section "$_flyerTypeString" is\nTemporarily closed in $_currentCityID',
      body: 'The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: 'Inform a friend',
            width: 133,
            onTap: () => Launcher.shareLink(
              context : context,
              link: LinkModel.bldrsWebSiteLink,
            ),
          ),

          DialogButton(
            verse: 'Go back',
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

// --------------------------------
Future<void> onSpecPickerTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<SpecModel>> selectedSpecs,
  @required List<SpecModel> originalSpecs,
  @required bool onlyUseCityChains,
  @required bool isMultipleSelectionMode,
  @required ValueNotifier<List<PickerModel>> refinedSpecsPickers,
  @required List<PickerModel> allSpecPickers,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: SpecPickerScreen(
      specPicker: picker,
      selectedSpecs: selectedSpecs,
      onlyUseCityChains: onlyUseCityChains,
      showInstructions: isMultipleSelectionMode,
      isMultipleSelectionMode:  isMultipleSelectionMode,
      originalSpecs: originalSpecs,
    ),
  );

  if (_result != null){

    /// WHILE SELECTING MULTIPLE PHIDS
    if (isMultipleSelectionMode == true){

      updateSpecsPickersAndGroups(
        context: context,
        specPicker: picker,
        selectedSpecs: selectedSpecs,
        refinedPickers: refinedSpecsPickers,
        sourceSpecPickers: allSpecPickers,
        specPickerResult: _result,
      );

    }

    /// WHILE SELECTING ONLY ONE PHID
    else {
      Nav.goBack(
          context: context,
          invoker: 'onSpecPickerTap',
          passedData: _result,
      );
    }

  }

}
// -----------------------------------------------------------------------------
