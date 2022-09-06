import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// AUTO UPDATE MY FOLLOWED BZ IDS

// --------------------
Future<void> autoDeleteThisBzIDFromMyFollowedBzzIDs({
  @required BuildContext context,
  @required String bzID,
}) async {

  blog('autoDeleteThisBzIDFromMyFollowedBzzIDs : START');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  final UserModel _myUpdatedModel = UserModel.removeBzIDFromMyFollows(
    userModel: _userModel,
    bzIDToUnFollow: bzID,
  );

  await UserProtocols.renovateMyUserModel(
    context: context,
    newUserModel: _myUpdatedModel,
  );

  blog('autoDeleteThisBzIDFromMyFollowedBzzIDs : END');

}
// -----------------------------------------------------------------------------
