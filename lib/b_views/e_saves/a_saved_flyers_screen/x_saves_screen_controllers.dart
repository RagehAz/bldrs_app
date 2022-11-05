import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// FLYER SELECTION

// ---------------------------------
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

/// AUTO UPDATE MY SAVED FLYERS IDS

// ---------------------------------
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
// -----------------------------------------------------------------------------
