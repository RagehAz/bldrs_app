import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
int getInitialMyBzScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final BzTab _currentTab = _uiProvider.currentBzTab;
  final int _index = getBzTabIndex(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
void onChangeMyBzScreenTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeMyBzScreenTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -----------------------------------------------------------------------------
void onChangeMyBzScreenTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final BzTab _newBzTab = bzTabsList[index];
  final BzTab _previousBzTab = _uiProvider.currentBzTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newBzTab != _previousBzTab){
    // blog('index is $index');
    _uiProvider.setCurrentBzTab(_newBzTab);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
// -----------------------------------------------------------------------------
