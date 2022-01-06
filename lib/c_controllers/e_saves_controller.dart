import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
int getInitialTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final FlyerType _currentTab = _uiProvider.currentSavedFlyerTypeTab;
  final int _index = getFlyerTypeIndexFromSectionsTabs(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
void onChangeTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -----------------------------------------------------------------------------
void onChangeTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final FlyerType _newFlyerType = sectionsList[index];
  final FlyerType _previousTab = _uiProvider.currentSavedFlyerTypeTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newFlyerType != _previousTab){
    // blog('index is $index');
    _uiProvider.setCurrentFlyerTypeTab(_newFlyerType);
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
