import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// AUTO UPDATE MY FOLLOWED BZ IDS

// --------------------
Future<void> autoDeleteThisBzIDFromMyFollowedBzzIDs({
  required BuildContext context,
  required String bzID,
}) async {

  blog('autoDeleteThisBzIDFromMyFollowedBzzIDs : START');

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  final UserModel? _myUpdatedModel = UserModel.removeBzIDFromUserFollows(
    oldUser: _userModel,
    bzIDToUnFollow: bzID,
  );

  await UserProtocols.renovate(
    context: context,
    newPic: null,
    newUser: _myUpdatedModel,
    oldUser: _userModel,
    invoker: 'autoDeleteThisBzIDFromMyFollowedBzzIDs',
  );

  blog('autoDeleteThisBzIDFromMyFollowedBzzIDs : END');

}
// -----------------------------------------------------------------------------
