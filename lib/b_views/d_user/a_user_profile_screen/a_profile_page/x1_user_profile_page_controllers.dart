import 'dart:async';

import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:space_time/space_time.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// OLD USER PROFILE TABS

// --------------------
/*
/// USER SCREEN TABS

// ---------------------------------
int getInitialUserScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final UserTab _currentTab = _uiProvider.currentUserTab;
  final int _index = UserModel.getUserTabIndex(_currentTab);
  return _index;
}
// ---------------------------------
void onChangeUserScreenTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeUserScreenTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// ---------------------------------
void onChangeUserScreenTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final UserTab _newUserTab = UserModel.userProfileTabsList[index];
  final UserTab _previousUserTab = _uiProvider.currentUserTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newUserTab != _previousUserTab){
    // blog('index is $index');
    _uiProvider.setCurrentUserTab(_newUserTab);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
 */
// -----------------------------------------------------------------------------

/// USER PROFILE PAGE

// --------------------
void onUserPicTap(){
  blog('user pic tapped');
}
// --------------------
Future<void> onUserContactTap({
  @required BuildContext context,
  @required ContactModel contact,
}) async {

  await Launcher.launchContactModel(
      context: context,
      contact: contact
  );

}
// --------------------
///
Future<void> onUserLocationTap(GeoPoint geoPoint) async {

  Atlas.blogGeoPoint(
    point: geoPoint,
    invoker: 'onUserLocationTap',
  );

}
// -----------------------------------------------------------------------------
