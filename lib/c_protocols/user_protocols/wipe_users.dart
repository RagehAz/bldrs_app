import 'dart:async';
import 'package:bldrs/a_models/b_bz/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x3_bz_authors_page_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/user_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/auth_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class WipeUserProtocols {
  // -----------------------------------------------------------------------------

  const WipeUserProtocols();

  // -----------------------------------------------------------------------------
  static Future<void> wipeMyUserModel({
    @required BuildContext context,
    @required bool showWaitDialog,
  }) async {

    blog('WipeUserProtocols.wipeMyUserModel : START');

    /// START WAITING : DIALOG IS CLOSED INSIDE BELOW DELETION OPS
    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: const Verse(
          text: 'phid_deleting_your_account',
          translate: true,
        ),
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
      await WaitDialog.closeWaitDialog(context);
    }

    blog('WipeUserProtocols.wipeMyUserModel : END');

  }
  // --------------------
  static Future<void> _deleteNonAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteNonAuthorUserProtocol : START');

    /// TASK SHOULD DELETE QUESTIONS, RECORDS, SEARCHES

    /// FIRE : DELETE USER OPS
    final bool _success = await UserFireOps.deleteNonAuthorUserOps(
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
  // --------------------
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
  // --------------------
  static Future<void> _deleteAllMyAuthorImages({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteAllMyAuthorImages : START');

    final List<String> _bzzIDs = userModel.myBzzIDs;

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (final String bzID in _bzzIDs){
        await AuthorProtocols.deleteMyAuthorPicProtocol(
          context: context,
          bzID: bzID,
        );
      }

    }

    blog('UserProtocol._deleteAllMyAuthorImages : END');

  }
  // --------------------
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

        await BzProtocols.wipeBz(
            context: context,
            bzModel: bzModel,
            showWaitDialog: true,
            includeMyselfInBzDeletionNote: false
        );

        await BzProtocols.deleteLocally(
          context: context,
          bzID: bzModel.id,
          invoker: '_deleteBzzICreatedProtocol',
        );

      }

    }

    blog('UserProtocol._deleteBzzICreatedProtocol : END');

  }
  // --------------------
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
          sendToUserAuthorExitNote: false,
        );

      }

    }

    blog('UserProtocol._exitBzzIDidNotCreateProtocol : END');

  }
  // --------------------
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
