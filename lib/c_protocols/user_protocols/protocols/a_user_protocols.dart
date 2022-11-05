import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/compose_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/fetch_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/renovate_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/wipe_users.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProtocols {
  // -----------------------------------------------------------------------------

  const UserProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  static Future<AuthModel> composeUser({
    @required BuildContext context,
    @required bool authSucceeds,
    @required String authError,
    @required UserCredential userCredential,
    @required AuthType authType,
  }) => ComposeUserProtocols.compose(
    context: context,
    authSucceeds: authSucceeds,
    authError: authError,
    userCredential: userCredential,
    authType: authType,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> fetchUser({
    @required BuildContext context,
    @required String userID
  }) => FetchUserProtocols.fetchUser(
    context: context,
    userID: userID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> fetchUsers({
    @required BuildContext context,
    @required List<String> usersIDs,
  }) => FetchUserProtocols.fetchUsers(
    context: context,
    usersIDs: usersIDs,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> refetchUser({
    @required BuildContext context,
    @required String userID
  }) async {
    await UserLDBOps.deleteUserOps(userID);
    final UserModel _user = await fetchUser(context: context, userID: userID);
    return _user;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateMyUserModel({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) => RenovateUserProtocols.renovateMyUserModel(
    context: context,
    newUserModel: newUserModel,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateUser({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) => RenovateUserProtocols.renovateUser(
    context: context,
    newUserModel: newUserModel,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) => RenovateUserProtocols.updateLocally(
      newUserModel: newUserModel,
      context: context
  );
  // --------------------

  static Future<UserModel> completeUserZoneModels({
    @required UserModel userModel,
    @required BuildContext context,
  }) async {
    UserModel _output;

    if (userModel != null){

      final ZoneModel _completeZoneModel = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: userModel.zone,
      );

      final ZoneModel _completeNeedZoneModel = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: userModel.need?.zone,
      );

      _output = userModel.copyWith(
        zone: _completeZoneModel,
        need: userModel.need?.copyWith(
          zone: _completeNeedZoneModel,
        ),
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> followingProtocol({
    @required BuildContext context,
    @required bool followIsOn,
    @required String bzID,
  }) => RenovateUserProtocols.followingProtocol(
    context: context,
    followIsOn: followIsOn,
    bzID: bzID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> savingFlyerProtocol({
    @required BuildContext context,
    @required bool flyerIsSaved,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) => RenovateUserProtocols.savingFlyerProtocol(
    context: context,
    flyerIsSaved: flyerIsSaved,
    flyerID: flyerID,
    bzID: bzID,
    slideIndex: slideIndex,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> refreshUserDeviceModel({
    @required BuildContext context,
  }) => RenovateUserProtocols.refreshUserDeviceModel(
    context: context,
  );
  // --------------------
  ///
  static Future<void> updateUserTopics({
    @required BuildContext context,
    @required String topicID,
  }) async {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    final List<String> _userSubscribedTopics = _userModel.fcmTopics;

    final UserModel updated = _userModel.copyWith(
      fcmTopics: Stringer.addOrRemoveStringToStrings(
        strings: _userSubscribedTopics,
        string: topicID,
      ),
    );

    await UserProtocols.renovateMyUserModel(
      context: context,
      newUserModel: updated,
    );


  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeUser({
    @required BuildContext context,
    @required bool showWaitDialog,
  }) => WipeUserProtocols.wipeMyUserModel(
    context: context,
    showWaitDialog: showWaitDialog,
  );
  // -----------------------------------------------------------------------------

}
