import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/compose_users.dart';
import 'package:bldrs/c_protocols/user_protocols/fetch_users.dart';
import 'package:bldrs/c_protocols/user_protocols/renovate_users.dart';
import 'package:bldrs/c_protocols/user_protocols/wipe_users.dart';
import 'package:flutter/material.dart';

class UserProtocols {
// -----------------------------------------------------------------------------

  UserProtocols();

// -----------------------------------------------------------------------------

/// COMPOSE

// ----------------------------------
  static Future<void> composeUser() => ComposeUserProtocols.compose();
// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------
  static Future<UserModel> fetchUser({
    @required BuildContext context,
    @required String userID
  }) => FetchUserProtocols.fetchUser(
    context: context,
    userID: userID,
  );
// ----------------------------------
  static Future<List<UserModel>> fetchUsers({
    @required BuildContext context,
    @required List<String> usersIDs,
  }) => FetchUserProtocols.fetchUsers(
    context: context,
    usersIDs: usersIDs,
  );
// -----------------------------------------------------------------------------

/// RENOVATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateMyUserModel({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) => RenovateUserProtocols.renovateMyUserModel(
    context: context,
    newUserModel: newUserModel,
  );
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) => RenovateUserProtocols.updateLocally(
      newUserModel: newUserModel,
      context: context
  );
// -----------------------------------------------------------------------------

/// WIPE

// ----------------------------------
  static Future<void> wipeUser() => WipeUserProtocols.wipeUser();
// -----------------------------------------------------------------------------
}
