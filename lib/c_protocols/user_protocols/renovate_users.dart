import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/auth_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/user_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/bz_record_real_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class RenovateUserProtocols {
  // -----------------------------------------------------------------------------

  const RenovateUserProtocols();

  // -----------------------------------------------------------------------------

  /// USER MODEL EDITS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateMyUserModel({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) async {

    blog('RenovateUserProtocols.renovateMyUserModel : START');

    UserModel _uploadedModel;

    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _modelsAreIdentical = UserModel.checkUsersAreIdentical(
        user1: newUserModel,
        user2: _oldUserModel
    );

    if (_modelsAreIdentical == false){

      /// UPDATE USER IN FIRE STORE
      _uploadedModel = await UserFireOps.updateUser(
        context: context,
        newUserModel: newUserModel,
        oldUserModel: _oldUserModel,
      );

      await updateLocally(
        context: context,
        newUserModel: _uploadedModel,
      );

    }

    blog('RenovateUserProtocols.renovateMyUserModel : END');

    return _uploadedModel ?? newUserModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) async {

    blog('RenovateUserProtocols.updateLocally : START');

    final UserModel _oldUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _modelsAreIdentical = UserModel.checkUsersAreIdentical(
        user1: newUserModel,
        user2: _oldUserModel
    );

    if (_modelsAreIdentical == false){

      final UserModel _fixedModel = await UserProtocols.completeUserZoneModels(
          userModel: newUserModel,
          context: context
      );

      /// UPDATE USER AND AUTH IN PRO
      UsersProvider.proUpdateUserAndAuthModels(
        context: context,
        userModel: _fixedModel,
        notify: true,
      );

      /// UPDATE USER MODEL IN LDB
      await UserLDBOps.updateUserModel(_fixedModel);

      /// UPDATE AUTH MODEL IN LDB
      final AuthModel _authModel = UsersProvider.proGetAuthModel(
        context: context,
        listen: false,
      );
      await AuthLDBOps.updateAuthModel(_authModel);

    }

    blog('UserProtocol.updateLocally : END');

  }
  // -----------------------------------------------------------------------------

  /// SAVING AND FOLLOWING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> followingProtocol({
    @required BuildContext context,
    @required bool followIsOn,
    @required String bzID,
  }) async {

    blog('RenovateUserProtocols.followingProtocol : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (followIsOn == true){

      await BzRecordRealOps.followBz(
        bzID: bzID,
      );

      final UserModel _updatedModel = UserModel.addBzIDToUserFollows(
        userModel: _userModel,
        bzIDToFollow: bzID,
      );

      await UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    else {

      await BzRecordRealOps.unfollowBz(
        bzID: bzID,
      );

      final UserModel _updatedModel = UserModel.removeBzIDFromMyFollows(
        userModel: _userModel,
        bzIDToUnFollow: bzID,
      );

      await UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    blog('RenovateUserProtocols.followingProtocol : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> savingFlyerProtocol({
    @required BuildContext context,
    @required bool flyerIsSaved,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {
    blog('RenovateUserProtocols.savingFlyerProtocol : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (flyerIsSaved == true){

      await FlyerRecordRealOps.saveFlyer(
          flyerID: flyerID,
          bzID: bzID,
          slideIndex: slideIndex
      );

      final UserModel _updatedModel = UserModel.addFlyerIDToSavedFlyersIDs(
        userModel: _userModel,
        flyerIDToAdd: flyerID,
      );

      await UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    else {

      await FlyerRecordRealOps.unSaveFlyer(
        flyerID: flyerID,
        bzID: bzID,
        slideIndex: slideIndex,
      );

      final UserModel _updatedModel = UserModel.removeFlyerIDFromSavedFlyersIDs(
        userModel: _userModel,
        flyerIDToRemove: flyerID,
      );

      await UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    blog('RenovateUserProtocols.savingFlyerProtocol : END');
  }
  // -----------------------------------------------------------------------------

  /// UPDATE DEVICE MODEL

  // --------------------
  ///
  static Future<void> refreshUserDeviceModel({
    @required BuildContext context,
  }) async {

    // blog('refreshUserDeviceModel START');

    if (AuthModel.userIsSignedIn() == true){

      /// TASK : UNSUBSCRIBING FROM TOKEN INSTRUCTIONS
      /*
         - Unsubscribe stale tokens from topics
         Managing topics subscriptions to remove stale registration
         tokens is another consideration. It involves two steps:

         - Your app should resubscribe to topics once per month and/or
          whenever the registration token changes. This forms a self-healing
          solution, where the subscriptions reappear automatically
          when an app becomes active again.

         - If an app instance is idle for 2 months (or your own staleness window)
         you should unsubscribe it from topics using the Firebase Admin
         SDK to delete the token/topic mapping from the FCM backend.

         - The benefit of these two steps is that your fanouts will occur
         faster since there are fewer stale tokens to fan out to, and your
          stale app instances will automatically resubscribe once they are active again.

     */

      /// THIS DEVICE MODEL
      final DeviceModel _thisDevice = await DeviceModel.generateDeviceModel();

      /// USER DEVICE MODEL
      final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      );

      /// TASK : ACTUALLY SHOULD REBOOT SYSTEM IF DEVICE CHANGED
      final bool _userIsUsingSameDevice = DeviceModel.checkDevicesAreIdentical(
        device1: _thisDevice,
        device2: _myUserModel.device,
      );

      if (_myUserModel.device == null || _userIsUsingSameDevice == false){

        /// SHOULD REFETCH, and I will explain why
        /// user using device A renovated his user model and updated firebase
        /// closed device A and opens device B
        /// which did not listen to firebase but has an old model in LDB
        /// while checking this device has been changed
        /// we should get the most updated version of his model
        /// so we refetch model
        /// cheers
        UserModel _refetchedUser = await UserProtocols.refetchUser(
            context: context,
            userID: _myUserModel.id,
        );

        _refetchedUser = _refetchedUser.copyWith(
          device: _thisDevice,
        );

        await Future.wait(<Future>[

          _resubscribeToAllMyTopics(
            context: context,
          ),

          UserProtocols.renovateMyUserModel(
            context: context,
            newUserModel: _refetchedUser,
          ),

        ]);

      }

    }

    // blog('refreshUserDeviceModel END');

  }
  // --------------------
  /// TASK : COMPLETE THIS
  static Future<void> _resubscribeToAllMyTopics({
    @required BuildContext context,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final List<String> _topics = _myUserModel.fcmTopics;

    blog('SHOULD CONCLUDE WHICH TOPICS NEED SUBSCRIPTION');
    blog('OR FETCH SOMEHOW HOW TO GET MY SUBSCRIPTIONS AND RESUBSCRIBE');
    blog('_userID : ${_myUserModel.id} : _topics : $_topics');

  }
  // -----------------------------------------------------------------------------
}
