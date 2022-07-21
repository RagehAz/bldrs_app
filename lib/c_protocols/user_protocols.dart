import 'dart:async';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/aaa3_bz_authors_page_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/c_protocols/record_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH ( FIRE - LDB - PRO ) OPS.

class UserProtocol {

  UserProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  static Future<void> createUserProtocol() async {

  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> updateMyUserEverywhereProtocol({
    @required BuildContext context,
    @required UserModel newUserModel,
  }) async {

    blog('UserProtocol.updateMyUserEverywhereProtocol : START');

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

      await updateUserModelLocally(
        context: context,
        newUserModel: _uploadedModel,
      );

    }

    blog('UserProtocol.updateMyUserEverywhereProtocol : END');

    return _uploadedModel ?? newUserModel;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateUserModelLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) async {

    blog('UserProtocol.updateUserModelLocally : START');

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

    blog('UserProtocol.updateUserModelLocally : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> followingProtocol({
    @required BuildContext context,
    @required bool followIsOn,
    @required String bzID,
  }) async {

    blog('UserProtocol.followingProtocol : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    if (followIsOn == true){

      await RecordProtocols.followBz(context: context, bzID: bzID);

      final UserModel _updatedModel = UserModel.addBzIDToUserFollows(
        userModel: _userModel,
        bzIDToFollow: bzID,
      );

      await updateMyUserEverywhereProtocol(
          context: context,
          newUserModel: _updatedModel,
      );

    }

    else {

      await RecordProtocols.unfollowBz(context: context, bzID: bzID);

      final UserModel _updatedModel = UserModel.removeBzIDFromMyFollows(
        userModel: _userModel,
        bzIDToUnFollow: bzID,
      );

      await updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    blog('UserProtocol.followingProtocol : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> savingFlyerProtocol({
    @required BuildContext context,
    @required bool flyerIsSaved,
    @required String flyerID,
    @required String bzID,
    @required int slideIndex,
  }) async {

    blog('UserProtocol.savingFlyerProtocol : START');

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    if (flyerIsSaved == true){

      await RecordProtocols.saveFlyer(
          context: context,
          flyerID: flyerID,
          bzID: bzID,
          slideIndex: slideIndex
      );

      final UserModel _updatedModel = UserModel.addFlyerIDToSavedFlyersIDs(
        userModel: _userModel,
        flyerIDToAdd: flyerID,
      );

      await updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    else {

      await RecordProtocols.unSaveFlyer(
        context: context,
        flyerID: flyerID,
        bzID: bzID,
        slideIndex: slideIndex,
      );

      final UserModel _updatedModel = UserModel.removeFlyerIDFromSavedFlyersIDs(
        userModel: _userModel,
        flyerIDToRemove: flyerID,
      );

      await updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _updatedModel,
      );

    }

    blog('UserProtocol.savingFlyerProtocol : END');

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteUserProtocol({
  @required BuildContext context,
    @required bool showWaitDialog,
}) async {

    blog('UserProtocol.deleteUserProtocol : START');

    /// START WAITING : DIALOG IS CLOSED INSIDE BELOW DELETION OPS
    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting your Account',
      ));
    }

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);

    /// WHEN USER IS AUTHOR
    if (_userIsAuthor == true){

      await _deleteAuthorUserProtocol(
        context: context,
        userModel: _userModel,
      );

    }

    /// WHEN USER IS NOT AUTHOR
    else {

      await _deleteNonAuthorUserProtocol(
        context: context,
        userModel: _userModel,
      );

    }

    /// CLOSE WAITING
    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    blog('UserProtocol.deleteUserProtocol : END');

  }
// ----------------------------------
  static Future<void> _deleteNonAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteNonAuthorUserProtocol : START');

    /// TASK SHOULD DELETE QUESTIONS, RECORDS, SEARCHES

    /// FIRE : DELETE USER OPS
    final bool _success = await UserFireOps.deleteNonAuthorUserOps(
        context: context,
        userModel: userModel
    );

    if (_success == true){

      await _deleteMyUserLocallyProtocol(
          context: context,
          userModel: userModel
      );

    }

    blog('UserProtocol._deleteNonAuthorUserProtocol : END');

  }
// ----------------------------------
  static Future<void> _deleteAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteAuthorUserProtocol : START');

    await _deleteAllMyAuthorImages(
      context: context,
      userModel: userModel,
    );

    await _deleteBzzICreatedProtocol(
      context: context,
      userModel: userModel,
    );

    await _exitBzzIDidNotCreateProtocol(
      context: context,
      userModel: userModel,
    );

    await _deleteNonAuthorUserProtocol(
      context: context,
      userModel: userModel,
    );

    blog('UserProtocol._deleteAuthorUserProtocol : END');

  }
// ----------------------------------
  static Future<void> _deleteAllMyAuthorImages({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteAllMyAuthorImages : START');

    final List<String> _bzzIDs = userModel.myBzzIDs;

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (final String bzID in _bzzIDs){
        await BzProtocol.deleteMyAuthorPicProtocol(
          context: context,
          bzID: bzID,
        );
      }

    }

    blog('UserProtocol._deleteAllMyAuthorImages : END');

  }
// ----------------------------------
  static Future<void> _deleteBzzICreatedProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteBzzICreatedProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: context,
      listen: false,
    );

    final List<BzModel> _myBzzICreated = BzModel.getBzzByCreatorID(
      bzzModels: _myBzzModels,
      creatorID: userModel.id,
    );

    if (Mapper.checkCanLoopList(_myBzzICreated) == true){

      for (final BzModel bzModel in _myBzzICreated){

        await BzProtocol.deleteBzProtocol(
          context: context,
          bzModel: bzModel,
          showWaitDialog: true,
        );

        await BzProtocol.localBzDeletionProtocol(
            context: context,
            bzID: bzModel.id,
        );

      }

    }

    blog('UserProtocol._deleteBzzICreatedProtocol : END');

  }
// ----------------------------------
  static Future<void> _exitBzzIDidNotCreateProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._exitBzzIDidNotCreateProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: context,
      listen: false,
    );

    final List<BzModel> _myBzzIDidNotCreate = BzModel.getBzzIDidNotCreate(
      bzzModels: _myBzzModels,
      userID: userModel.id,
    );

    if (Mapper.checkCanLoopList(_myBzzIDidNotCreate) == true){

      for (final BzModel bzModel in _myBzzIDidNotCreate){

        final AuthorModel _authorModel = AuthorModel.getAuthorFromBzByAuthorID(
            bz: bzModel,
            authorID: userModel.id,
        );

        await onDeleteAuthorFromBz(
          context: context,
          bzModel: bzModel,
          authorModel: _authorModel,
          showWaitingDialog: false,
          showConfirmationDialog: false,
        );

      }

    }

    blog('UserProtocol._exitBzzIDidNotCreateProtocol : END');

  }
// ----------------------------------
  static Future<void> _deleteMyUserLocallyProtocol({
    @required BuildContext context,
    @required UserModel userModel,
}) async {

    blog('UserProtocol._deleteMyUserLocallyProtocol : START');

    /// LDB : DELETE USER MODEL
    await UserLDBOps.deleteUserOps(userModel.id);
    await AuthLDBOps.deleteAuthModel(userModel.id);

    /// LDB : DELETE SAVED FLYERS
    await FlyerLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    blog('UserProtocol._deleteMyUserLocallyProtocol : END');

  }
// -----------------------------------------------------------------------------
}
