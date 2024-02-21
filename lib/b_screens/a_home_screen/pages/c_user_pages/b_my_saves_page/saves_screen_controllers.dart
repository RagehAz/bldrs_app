import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// FLYER SELECTION

// ---------------------------------
void onSelectFlyerFromSavedFlyers({
  required FlyerModel flyer,
}) {

  blog('onSelectFlyerFromSavedFlyers : selecting flyer');

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(getMainContext(), listen: false);
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

  blog('onSelectFlyerFromSavedFlyers _selectedFlyers : ${_flyersProvider.selectedFlyers.length} : '
      '_alreadySelected : $_alreadySelected : ${flyer.id}');


}
// -----------------------------------------------------------------------------

/// AUTO UPDATE MY SAVED FLYERS IDS

// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> removeMissingSavedFlyer({
  required String flyerID,
}) async {

  blog('removeMissingSavedFlyer : START');

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  final UserModel? _myUpdatedModel = UserModel.removeFlyerFromSavedFlyers(
    oldUser: _userModel,
    flyerIDToRemove: flyerID,
  );

  await UserProtocols.renovate(
    newUser: _myUpdatedModel,
    oldUser: _userModel,
    invoker: 'removeMissingSavedFlyer',
  );

  await FlyerProtocols.deleteFlyersLocally(
    flyersIDs: [flyerID],
  );

  blog('removeMissingSavedFlyer : END');

}
// -----------------------------------------------------------------------------
