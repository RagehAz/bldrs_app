import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/media_protocols/protocols/media_protocols.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/debuggers.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class RenovateUserProtocols {
  // -----------------------------------------------------------------------------

  const RenovateUserProtocols();

  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> renovateUser({
    required UserModel? oldUser,
    required UserModel? newUser,
    required String? invoker,
    bool updateEmailInAuth = true,
    MediaModel? newPic,
  }) async {
    UserModel? _output;

    await reportThis('renovateUser : invoker : $invoker');

    if (newUser != null && oldUser?.id != null){

      _output = oldUser;

      // final UserModel? _oldUser = await UserProtocols.refetch(
      //     userID: oldUser?.id,
      // );

        await Future.wait(<Future>[

          /// FIRE UPDATE USER
          UserFireOps.updateUser(
            newUser: newUser,
            oldUser: oldUser,
            updateEmailInAuth: updateEmailInAuth,
          ).then((UserModel? uploadedModel){
            if (uploadedModel != null){
              _output = uploadedModel;
            }
          }),

          /// STORAGE RENOVATE PIC
          if (newPic != null)
          MediaProtocols.renovateMedia(
            newMedia: newPic,
            oldMedia: null,
          ),

        ]);

        // blog('user is null ? ${oldUser == null} : ${_oldUser == null}');

        await Future.wait(<Future>[

          /// UPDATE CENSUS
          CensusListener.onRenovateUser(
              newUser: _output,
              oldUser: oldUser,
          ),

          /// UPDATE LOCALLY
          updateLocally(
            newUser: _output,
          ),

        ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateLocally({
    required UserModel? newUser,
  }) async {

    // blog('RenovateUserProtocols.updateLocally : START');

    final UserModel? _oldUser = await UserProtocols.fetch(
      userID: newUser?.id,
    );

    final bool _modelsAreIdentical = UserModel.usersAreIdentical(
        user1: newUser,
        user2: _oldUser
    );

    if (_modelsAreIdentical == false){

      /// UPDATE PRO USER AND AUTH MODELS
      if (UserModel.checkItIsMe(newUser?.id) == true){

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
  static Future<UserModel?> completeUserZoneModels({
    required UserModel? userModel,
  }) async {
    UserModel? _output;

    if (userModel != null){

      final ZoneModel? _completeZoneModel = await ZoneProtocols.completeZoneModel(
        invoker: 'completeUserZoneModels',
        incompleteZoneModel: userModel.zone,
      );

      _output = userModel.copyWith(
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
    required bool followIsOn,
    required BzModel? bzToFollow,
  }) async {

    blog('RenovateUserProtocols.followingProtocol : START');

    if (bzToFollow != null){

      final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      );

      if (followIsOn == true){

        final UserModel? _newUser = UserModel.addBzIDToUserFollows(
          oldUser: _oldUser,
          bzToFollow: bzToFollow,
        );

        await Future.wait(<Future>[

          RecorderProtocols.onFollowBz(
            bzID: bzToFollow.id,
          ),

          renovateUser(
            newUser: _newUser,
            oldUser: _oldUser,
            invoker: 'followingProtocol',
          ),

          CensusListener.onFollowBz(
              bzModel: bzToFollow,
              isFollowing: true
          ),

          NoteEvent.onUserFollowedBz(
            bzModel: bzToFollow,
            userModel: _newUser,
          ),

        ]);


      }

      else {

        final UserModel? _newUser = UserModel.removeBzIDFromUserFollows(
          oldUser: _oldUser,
          bzIDToUnFollow: bzToFollow.id,
        );

        await Future.wait(<Future>[

          RecorderProtocols.onUnfollowBz(
            bzID: bzToFollow.id,
          ),

          renovateUser(
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

    }


    blog('RenovateUserProtocols.followingProtocol : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> savingFlyerProtocol({
    required bool flyerIsSaved,
    required FlyerModel? flyerModel,
    required int slideIndex,
  }) async {
    // blog('RenovateUserProtocols.savingFlyerProtocol : START');

    if (flyerModel != null){

      final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      );

      if (Authing.userIsSignedUp(_oldUser?.signInMethod) == false){

        await Dialogs.youNeedToBeSignedUpDialog(
          afterHomeRouteName: ScreenName.flyerPreview,
          afterHomeRouteArgument: flyerModel.id,
        );

      }

      else {

        if (flyerIsSaved == true) {

          final UserModel? _newUser = UserModel.addFlyerToSavedFlyers(
            oldUser: _oldUser,
            flyerModel: flyerModel,
          );

          await Future.wait(<Future>[

            /// FLYER RECORDS
            RecorderProtocols.onSaveFlyer(
                flyerID: flyerModel.id,
                bzID: flyerModel.bzID,
                slideIndex: slideIndex
            ),

            /// RENOVATE USER
            UserProtocols.renovate(
              newUser: _newUser,
              oldUser: _oldUser,
              invoker: 'savingFlyerProtocol',
            ),

            /// CENSUS SAVE FLYER
            CensusListener.onSaveFlyer(
              flyerModel: flyerModel,
              isSaving: true,
            ),

            /// SEND NOTE
            NoteEvent.onUserSavedFlyer(
              userModel: _newUser,
              flyerModel: flyerModel,
            ),

          ]);
        }

        else {
          final UserModel? _newUser = UserModel.removeFlyerFromSavedFlyers(
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
              newUser: _newUser,
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
    required String? topicID,
  }) async {

    final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );
    final List<String>? _userSubscribedTopics = _oldUser?.fcmTopics;

    final UserModel? _newUser = _oldUser?.copyWith(
      fcmTopics: Stringer.addOrRemoveStringToStrings(
        strings: _userSubscribedTopics,
        string: topicID,
      ),
    );

    await renovateUser(
      newUser: _newUser,
      oldUser: _oldUser,
      invoker: 'updateMyUserTopics',
    );

  }
  // -----------------------------------------------------------------------------
}
