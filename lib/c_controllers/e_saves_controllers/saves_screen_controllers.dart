import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
int getInitialSavedFlyersTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final FlyerType _currentTab = _uiProvider.currentSavedFlyerTypeTab;
  final int _index = FlyerTyper.getFlyerTypeIndexFromSectionsTabs(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
void onChangeSavedFlyersTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeSavedFlyersTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -----------------------------------------------------------------------------
void onChangeSavedFlyersTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final FlyerType _newFlyerType = FlyerTyper.savedFlyersTabs[index];
  final FlyerType _previousTab = _uiProvider.currentSavedFlyerTypeTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newFlyerType != _previousTab){

    // blog('index is $index');

    _uiProvider.setCurrentFlyerTypeTab(
      flyerType: _newFlyerType,
      notify: true,
    );

    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );

  }

}
// -----------------------------------------------------------------------------
void onSelectFlyerFromSavedFlyers({
  @required BuildContext context,
  @required FlyerModel flyer,
}) {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final List<FlyerModel> _selectedFlyers = _flyersProvider.selectedFlyers;


  final bool _alreadySelected = FlyerModel.flyersContainThisID(
    flyers: _selectedFlyers,
    flyerID: flyer.id,
  );

  if (_alreadySelected == true) {

    _flyersProvider.removeFlyerFromSelectedFlyers(flyer);
    // _tabModels = createTabModels();

  }

  else {
    _flyersProvider.addFlyerToSelectedFlyers(flyer);
    // _tabModels = createTabModels();
  }

}
// -----------------------------------------------------------------------------
Future<void> autoRemoveSavedFlyerThatIsNotFound({
  @required BuildContext context,
  @required String flyerID,
}) async {

  blog('autoRemoveSavedFlyerThatIsNotFound : START');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  final UserModel _myUpdatedModel = UserModel.removeFlyerIDFromSavedFlyersIDs(
    userModel: _userModel,
    flyerIDToRemove: flyerID,
  );

  await UserProtocols.renovateMyUserModel(
    context: context,
    newUserModel: _myUpdatedModel,
  );

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.removeFlyerFromProFlyers(
      flyerID: flyerID,
      notify: true,
  );

  blog('autoRemoveSavedFlyerThatIsNotFound : END');

}
