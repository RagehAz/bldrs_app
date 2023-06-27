import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/debuggers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

class RenovateUserProtocols {
  // -----------------------------------------------------------------------------

  const RenovateUserProtocols();

  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> renovateUser({
    required BuildContext context,
    required UserModel oldUser,
    required UserModel newUser,
    required PicModel newPic,
    required String invoker,
  }) async {
    UserModel _output;

    await reportThis('renovateUser : invoker : $invoker');

    if (newUser != null && oldUser?.id != null){

      _output = oldUser;

      final UserModel _oldUser = await UserProtocols.refetch(
          context: context,
          userID: oldUser.id,
      );

        await Future.wait(<Future>[

          /// FIRE UPDATE USER
          UserFireOps.updateUser(
            newUser: newUser,
            oldUser: _oldUser,
          ).then((UserModel uploadedModel){
            if (uploadedModel != null){
              _output = uploadedModel;
            }
          }),

          /// STORAGE RENOVATE PIC
          if (newPic != null)
          PicProtocols.renovatePic(newPic),

        ]);

        // blog('user is null ? ${oldUser == null} : ${_oldUser == null}');

        await Future.wait(<Future>[

          /// UPDATE CENSUS
          CensusListener.onRenovateUser(
              newUser: _output,
              oldUser: _oldUser,
          ),

          /// UPDATE LOCALLY
          updateLocally(
            context: context,
            newUser: _output,
          ),

        ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    required UserModel newUser,
    required BuildContext context,
  }) async {

    // blog('RenovateUserProtocols.updateLocally : START');

    final UserModel _oldUser = await UserProtocols.fetch(
      context: context,
      userID: newUser.id,
    );

    final bool _modelsAreIdentical = UserModel.usersAreIdentical(
        user1: newUser,
        user2: _oldUser
    );

    if (_modelsAreIdentical == false){

      /// UPDATE PRO USER AND AUTH MODELS
      if (UserModel.checkItIsMe(newUser.id) == true){

        /// UPDATE LDB USER MODEL
        await UserLDBOps.updateUserModel(newUser);

        UsersProvider.proSetMyUserModel(
          userModel: newUser,
          notify: true,
        );

      }

    }

    // blog('UserProtocol.updateLocally : END');

  }
  // -----------------------------------------------------------------------------

  /// USER ZONE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> completeUserZoneModels({
    required UserModel userModel,
  }) async {
    UserModel _output;

    if (userModel != null){

      final ZoneModel _completeZoneModel = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: userModel.zone,
      );

      _output = userModel?.copyWith(
        zone: _completeZoneModel,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// SAVING AND FOLLOWING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> followingProtocol({
    required BuildContext context,
    required bool followIsOn,
    required BzModel bzToFollow,
  }) async {

    blog('RenovateUserProtocols.followingProtocol : START');

    final UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (followIsOn == true){

      final UserModel _newUser = UserModel.addBzIDToUserFollows(
        oldUser: _oldUser,
        bzToFollow: bzToFollow,
      );

      await Future.wait(<Future>[

        RecorderProtocols.onFollowBz(
          bzID: bzToFollow.id,
        ),

        renovateUser(
          context: context,
          newPic: null,
          newUser: _newUser,
          oldUser: _oldUser,
          invoker: 'followingProtocol',
        ),

        CensusListener.onFollowBz(
            bzModel: bzToFollow,
            isFollowing: true
        ),

      ]);


    }

    else {

      final UserModel _newUser = UserModel.removeBzIDFromUserFollows(
        oldUser: _oldUser,
        bzIDToUnFollow: bzToFollow.id,
      );

      await Future.wait(<Future>[

        RecorderProtocols.onUnfollowBz(
          bzID: bzToFollow.id,
        ),

        renovateUser(
          context: context,
          newPic: null,
          newUser: _newUser,
          oldUser: _oldUser,
          invoker: 'followingProtocol',
        ),

        CensusListener.onFollowBz(
            bzModel: bzToFollow,
            isFollowing: false
        ),

      ]);

    }

    blog('RenovateUserProtocols.followingProtocol : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> savingFlyerProtocol({
    required BuildContext context,
    required bool flyerIsSaved,
    required FlyerModel flyerModel,
    required int slideIndex,
  }) async {
    // blog('RenovateUserProtocols.savingFlyerProtocol : START');

    if (flyerModel != null){

      final UserModel _oldUser = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      );

      if (Authing.userIsSignedUp(_oldUser?.signInMethod) == false){

        await Dialogs.youNeedToBeSignedUpDialog(
          afterHomeRouteName: Routing.flyerPreview,
          afterHomeRouteArgument: flyerModel.id,
        );

      }

      else {

        if (flyerIsSaved == true) {
          final UserModel _newUser = UserModel.addFlyerToSavedFlyers(
            oldUser: _oldUser,
            flyerModel: flyerModel,
          );

          await Future.wait(<Future>[
            /// FLYER RECORDS
            RecorderProtocols.onSaveFlyer(
                flyerID: flyerModel.id, bzID: flyerModel.bzID, slideIndex: slideIndex),

            /// RENOVATE USER
            UserProtocols.renovate(
              context: context,
              newPic: null,
              newUser: _newUser,
              oldUser: _oldUser,
              invoker: 'savingFlyerProtocol',
            ),

            /// CENSUS SAVE FLYER
            CensusListener.onSaveFlyer(
              flyerModel: flyerModel,
              isSaving: true,
            ),
          ]);
        }

        else {
          final UserModel _newUser = UserModel.removeFlyerFromSavedFlyers(
            oldUser: _oldUser,
            flyerIDToRemove: flyerModel.id,
          );

          await Future.wait(<Future>[
            RecorderProtocols.onUnSaveFlyer(
              flyerID: flyerModel.id,
              bzID: flyerModel.bzID,
              slideIndex: slideIndex,
            ),

            renovateUser(
              context: context,
              newUser: _newUser,
              newPic: null,
              oldUser: _oldUser,
              invoker: 'savingFlyerProtocol',
            ),

            /// CENSUS SAVE FLYER
            CensusListener.onSaveFlyer(
              flyerModel: flyerModel,
              isSaving: false,
            ),
          ]);
        }

      }
    }

    // blog('RenovateUserProtocols.savingFlyerProtocol : END');
  }
  // -----------------------------------------------------------------------------

  /// TOPICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateMyUserTopics({
    required BuildContext context,
    required String topicID,
  }) async {

    final UserModel _oldUser = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );
    final List<String> _userSubscribedTopics = _oldUser.fcmTopics;

    final UserModel? _newUser = _oldUser?.copyWith(
      fcmTopics: Stringer.addOrRemoveStringToStrings(
        strings: _userSubscribedTopics,
        string: topicID,
      ),
    );

    await renovateUser(
      context: context,
      newUser: _newUser,
      newPic: null,
      oldUser: _oldUser,
      invoker: 'updateMyUserTopics',
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE DEVICE MODEL

  // --------------------
  /// TASK : TEST ME
  static Future<void> refreshUserDeviceModel({
    required BuildContext context,
  }) async {

    // blog('refreshUserDeviceModel START');
      /// USER DEVICE MODEL
      final UserModel _oldUser = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      );

    if (Authing.userIsSignedUp(_oldUser?.signInMethod) == true){

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

      /// TASK : ACTUALLY SHOULD REBOOT SYSTEM IF DEVICE CHANGED
      final bool _userIsUsingSameDevice = DeviceModel.checkDevicesAreIdentical(
        device1: _thisDevice,
        device2: _oldUser?.device,
      );

      final bool _shouldRefreshDevice = _oldUser?.device == null || _userIsUsingSameDevice == false;

      // blog(
      //     'refreshUserDeviceModel | '
      //     '_userIsUsingSameDevice : $_userIsUsingSameDevice | '
      //     '_oldUser.device : ${_oldUser?.device?.name} | '
      //     '_shouldRefreshDevice : $_shouldRefreshDevice'
      // );

      if (_shouldRefreshDevice == true){

        /// SHOULD REFETCH, and I will explain why
        /// user using device A renovated his user model and updated firebase
        /// closed device A and opens device B
        /// which did not listen to firebase but has an old model in LDB
        /// while checking this device has been changed
        /// we should get the most updated version of his model
        /// so we refetch model
        /// cheers
        UserModel _newUser = await UserProtocols.refetch(
            context: context,
            userID: _oldUser?.id,
        );

        _newUser = _newUser?.copyWith(
          device: _thisDevice,
        );

        /// TAKES TOO LONG AND NOTHING DEPENDS ON IT
        unawaited(_resubscribeToAllMyTopics(
          context: context,
        ));

        await renovateUser(
          context: context,
          newPic: null,
          newUser: _newUser,
          oldUser: _oldUser,
          invoker: 'refreshUserDeviceModel',
        );

      }

    }

    // blog('refreshUserDeviceModel END');

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> _resubscribeToAllMyTopics({
    required BuildContext context,
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
