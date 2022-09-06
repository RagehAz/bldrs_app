import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/bz_record_real_ops.dart';
import 'package:bldrs/e_db/real/ops/flyer_record_real_ops.dart';
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

    blog('UserProtocol.updateMyUserEverywhereProtocol : END');

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

      /// UPDATE USER AND AUTH IN PRO
      UsersProvider.proUpdateUserAndAuthModels(
        context: context,
        userModel: newUserModel,
        notify: true,
      );

      /// UPDATE USER MODEL IN LDB
      await UserLDBOps.updateUserModel(newUserModel);

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
        context: context,
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
        context: context,
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
          context: context,
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
        context: context,
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
}
