import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/aaa3_bz_authors_page_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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

    return _uploadedModel ?? newUserModel;
  }
// ----------------------------------
  static Future<void> updateUserModelLocally({
    @required UserModel newUserModel,
    @required BuildContext context,
  }) async {

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

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteUserProtocol({
  @required BuildContext context,
    @required bool showWaitDialog,
}) async {

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

  }
// ----------------------------------
  static Future<void> _deleteNonAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('_deleteNonAuthorUserProtocol : start');

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

    blog('_deleteNonAuthorUserProtocol : end');

  }
// ----------------------------------
  static Future<void> _deleteAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

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

  }
// ----------------------------------
  static Future<void> _deleteAllMyAuthorImages({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    final List<String> _bzzIDs = userModel.myBzzIDs;

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (final String bzID in _bzzIDs){
        await BzProtocol.deleteMyAuthorPicProtocol(
          context: context,
          bzID: bzID,
        );
      }

    }

  }
// ----------------------------------
  static Future<void> _deleteBzzICreatedProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

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

  }
// ----------------------------------
  static Future<void> _exitBzzIDidNotCreateProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

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

  }
// ----------------------------------
  static Future<void> _deleteMyUserLocallyProtocol({
    @required BuildContext context,
    @required UserModel userModel,
}) async {

    blog('_deleteMyUserLocallyProtocol : start');

    /// LDB : DELETE USER MODEL
    await UserLDBOps.deleteUserOps(userModel.id);
    await AuthLDBOps.deleteAuthModel(userModel.id);

    /// LDB : DELETE SAVED FLYERS
    await FlyerLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    blog('_deleteMyUserLocallyProtocol : end');

  }
// -----------------------------------------------------------------------------
}
