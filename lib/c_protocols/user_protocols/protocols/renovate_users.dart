import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/real/bz_record_real_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';

class RenovateUserProtocols {
  // -----------------------------------------------------------------------------

  const RenovateUserProtocols();

  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TASK : TEST ME
  static Future<UserModel> renovateUser({
    @required BuildContext context,
    @required UserModel newUserModel,
    @required PicModel newPic,
  }) async {

    UserModel _uploadedModel;

    if (newUserModel != null){

      final UserModel _oldUserModel = await UserProtocols.refetch(
          context: context,
          userID: newUserModel.id,
      );

      final bool _modelsAreIdentical = UserModel.usersAreIdentical(
          user1: newUserModel,
          user2: _oldUserModel
      );

      if (_modelsAreIdentical == false){

        await Future.wait(<Future>[

          /// FIRE UPDATE USER
          UserFireOps.updateUser(
            newUserModel: newUserModel,
            oldUserModel: _oldUserModel,
          ).then((UserModel uploadedModel){
            _uploadedModel = uploadedModel;
          }),

          /// STORAGE RENOVATE PIC
          if (newPic != null)
          PicProtocols.renovatePic(newPic),

        ]);

        /// UPDATE LOCALLY
        await updateLocally(
          context: context,
          newUserModel: _uploadedModel,
        );

      }

    }

    return _uploadedModel;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updateLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) async {

    blog('RenovateUserProtocols.updateLocally : START');

    final UserModel _oldUserModel = await UserProtocols.fetch(
      context: context,
      userID: newUserModel.id,
    );

    final bool _modelsAreIdentical = UserModel.usersAreIdentical(
        user1: newUserModel,
        user2: _oldUserModel
    );

    if (_modelsAreIdentical == false){

      await Future.wait(<Future>[

        /// UPDATE LDB USER MODEL
        UserLDBOps.updateUserModel(newUserModel),

        /// UPDATE LDB AUTHOR MODEL
        if (UserModel.checkItIsMe(newUserModel.id) == true)
          AuthLDBOps.updateAuthModel(UsersProvider.proGetAuthModel(
            context: context,
            listen: false,
          )),

      ]);

      /// UPDATE PRO USER AND AUTH MODELS
      if (UserModel.checkItIsMe(newUserModel.id) == true){
        UsersProvider.proSetMyUserAndAuthModels(
          context: context,
          userModel: newUserModel,
          notify: true,
        );
      }

    }

    blog('UserProtocol.updateLocally : END');

  }
  // -----------------------------------------------------------------------------

  /// USER ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
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

      await UserProtocols.renovate(
        context: context,
        newPic: null,
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

      await UserProtocols.renovate(
        context: context,
        newPic: null,
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

      await UserProtocols.renovate(
        context: context,
        newPic: null,
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

      await UserProtocols.renovate(
        context: context,
        newUserModel: _updatedModel,
        newPic: null,
      );

    }

    blog('RenovateUserProtocols.savingFlyerProtocol : END');
  }
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateMyUserTopics({
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

    await UserProtocols.renovate(
      context: context,
      newUserModel: updated,
      newPic: null,
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE DEVICE MODEL

  // --------------------
  /// TASK : TEST ME
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
        UserModel _refetchedUser = await UserProtocols.refetch(
            context: context,
            userID: _myUserModel.id,
        );

        _refetchedUser = _refetchedUser.copyWith(
          device: _thisDevice,
        );

        /// TAKES TOO LONG AND NOTHING DEPENDS ON IT
        unawaited(_resubscribeToAllMyTopics(
          context: context,
        ));

        await UserProtocols.renovate(
          context: context,
          newPic: null,
          newUserModel: _refetchedUser,
        );

      }

    }

    // blog('refreshUserDeviceModel END');

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _resubscribeToAllMyTopics({
    @required BuildContext context,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (_myUserModel != null){

      final List<String> _userTopics = _myUserModel.fcmTopics;

      final List<String> _topicsIShouldSubscribeTo = <String>[];
      for (final String topicID in _userTopics){

        final bool _containUnderscore = TextCheck.stringContainsSubString(
          string: topicID,
          subString: '_',
        );

        if (_containUnderscore == true){
          _topicsIShouldSubscribeTo.add(topicID);
        }

      }

      if (Mapper.checkCanLoopList(_topicsIShouldSubscribeTo) == true){

        /// UNSUBSCRIBE
        await Future.wait(<Future>[

          ...List.generate(_topicsIShouldSubscribeTo.length, (index){

            return FCM.unsubscribeFromTopic(
              topicID: _topicsIShouldSubscribeTo[index],
            );

          }),

        ]);

        /// SUBSCRIBE AGAIN
        await Future.wait(<Future>[

          ...List.generate(_topicsIShouldSubscribeTo.length, (index){

            return FCM.subscribeToTopic(
              topicID: _topicsIShouldSubscribeTo[index],
            );

          }),

        ]);

      }

    }

  }
  // -----------------------------------------------------------------------------
}
