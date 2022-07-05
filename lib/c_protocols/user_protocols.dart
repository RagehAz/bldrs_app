import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
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

      /// UPDATE USER AND AUTH IN PRO
      UsersProvider.proUpdateUserAndAuthModels(
        context: context,
        userModel: _uploadedModel,
        notify: true,
      );

      /// UPDATE USER MODEL IN LDB
      await UserLDBOps.updateUserModel(_uploadedModel);

      /// UPDATE AUTH MODEL IN LDB
      final AuthModel _authModel = UsersProvider.proGetAuthModel(
        context: context,
        listen: false,
      );
      await AuthLDBOps.updateAuthModel(_authModel);

    }

    return _uploadedModel ?? newUserModel;
  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteNonAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    /// TASK SHOULD DELETE QUESTIONS, RECORDS, SEARCHES

    /// FIRE : DELETE USER OPS
    final bool _success = await UserFireOps.deleteNonAuthorUserOps(
        context: context,
        userModel: userModel
    );

    if (_success == true){

      /// LDB : DELETE USER MODEL
      await UserLDBOps.deleteUserOps(userModel.id);
      await AuthLDBOps.deleteAuthModel(userModel.id);

      /// LDB : DELETE SAVED FLYERS
      await FlyerLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    }

  }
// ----------------------------------
  static Future<void> deleteAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    await _deleteBzzICreatedProtocol(
      context: context,
      userModel: userModel,
    );

    await _exitBzzIDidNotCreateProtocol(
      context: context,
      userModel: userModel,
    );



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

        /// should delete all my flyers in the bz
        /// should delete me from the bz

        // await AuthorProtocol.removeMeFromBzProtocol(
        //     context: context,
        //     streamedBzModel: bzModel,
        // );

      }

    }

  }
// -----------------------------------------------------------------------------
}
