import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/a_my_bz_screen_controllers.dart';
import 'package:bldrs/c_protocols/flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH FIRE OPS AND LDB OPS.
// -----------------------------------------------------------------------------
class BzProtocol {

  BzProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  static Future<void> createBzProtocol() async {}
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> updateMyBzEverywhereProtocol({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) async {

    blog('BzProtocol.updateMyBzEverywhereProtocol : START');

    /// FIRE
    final BzModel _uploadedBzModel = await BzFireOps.updateBz(
      context: context,
      newBzModel: newBzModel,
      oldBzModel: oldBzModel,
      authorPicFile: null,
    );

    /// PRO
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.updateBzInMyBzz(
        modifiedBz: _uploadedBzModel,
        notify: true,
    );

    /// LDB
    await BzLDBOps.insertBz(
      bzModel: _uploadedBzModel,
    );

    blog('BzProtocol.updateMyBzEverywhereProtocol : END');

    return _uploadedBzModel;
  }
  // -------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> myActiveBzLocalUpdateProtocol({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) async {

    blog('BzProtocol.myActiveBzLocalUpdateProtocol : START');

    /// LOCAL UPDATE PROTOCOL
    /// is to update my-active-bz-model in PRO and LDB in case of model changes

    final bool _areTheSame = BzModel.checkBzzAreIdentical(
      bz1: newBzModel,
      bz2: oldBzModel,
    );

    blog('BzProtocol.myActiveBzLocalUpdateProtocol : bzz are identical : $_areTheSame');

    /// UPDATE BZ MODEL EVERYWHERE
    if (_areTheSame == false){

      /// SET UPDATED BZ MODEL LOCALLY ( USER BZZ )
      final BzModel _finalBz = await completeBzZoneModel(
        context: context,
        bzModel: newBzModel,
      );

      /// OVERRIDE BZ ON LDB
      await BzLDBOps.updateBzOps(
        bzModel: _finalBz,
      );

      // if (context != null){

      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

      /// UPDATE MY BZZ
      _bzzProvider.updateBzInMyBzz(
        modifiedBz: _finalBz,
        notify: false,
      );

      /// UPDATE ACTIVE BZ
      _bzzProvider.setActiveBz(
        bzModel: _finalBz,
        notify: true,
      );

      blog('BzProtocol.myActiveBzLocalUpdateProtocol : my active bz updated in PRO & LDB');

      // }
    }

    blog('BzProtocol.myActiveBzLocalUpdateProtocol : END');

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------
  static Future<void> deleteBzProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
  }) async {

    blog('BzProtocol.deleteBzProtocol : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting ${bzModel.name}',
        canManuallyGoBack: false,
      ));
    }

    /// DELETE BZ FLYERS
    await _deleteAllBzFlyersOps(
      context: context,
      bzModel: bzModel,
      showWaitDialog: true,
      updateBz: false,
    );

    /// DELETE BZ NOTES
    await NoteProtocol.deleteAllBzReceivedNotes(
        context: context,
        bzID: bzModel.id,
    );

    /// DELETE BZ ON FIREBASE
    await BzFireOps.deleteBzOps(
      context: context,
      bzModel: bzModel,
    );

    /// SEND DELETION NOTES TO AUTHORS
    await NoteProtocol.sendBzDeletionNoteToAllAuthors(
      context: context,
      bzModel: bzModel,
    );

    /// NO NEED TO DELETE BZ IN LDB AND PRO OR REMOVE BZ FROM USER ID OR UPDATE USER NOW
    /// AS [authorBzExitAfterBzDeletionProtocol] METHOD LISTENS TO NOTE AND IS
    /// ACTIVATED AUTOMATICALLY
    /*
    /// DELETE BZ ON LDB
    await localBzDeletionProtocol(
      context: context,
      bzID: bzModel.id,
    );

    /// REMOVE BZ ID FROM MY BZZ IDS
    final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );
    final UserModel _updated = UserModel.removeBzIDFromMyBzzIDs(
        userModel: _userModel,
        bzIDToRemove: bzModel.id,
    );

    /// UPDATE USER MODEL EVERYWHERE
    await UserProtocol.updateMyUserEverywhereProtocol(
        context: context,
        newUserModel: _updated,
    );
     */

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    blog('BzProtocol.deleteBzProtocol : END');

  }
// ----------------------------------
  static Future<void> localBzDeletionProtocol({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('BzProtocol.localBzDeletionProtocol : START');

    // NOTE DELETES ALL BZ MODEL INSTANCES IN LDB AND BZ PRO

    /// DELETE BZ ON LDB
    await BzLDBOps.deleteBzOps(
      bzID: bzID,
    );

    blog('BzProtocol.localBzDeletionProtocol : ops should reach here ba2aaaaa');

    /// DELETE BZ ON PROVIDER
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.removeProBzEveryWhere(
      bzID: bzID,
      notify: true,
    );

    blog('BzProtocol.localBzDeletionProtocol : END');

  }
// ----------------------------------
  static Future<void> myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('BzProtocol.myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData : START');

    /// so I had this bzID in my bzIDs and I still have its old model
    /// scattered around in pro, ldb & fire

    /// DELETE LDB BZ MODEL

    /// DELETE LDB BZ FLYERS

    /// DELETE PRO BZ MODEL

    /// DELETE PRO BZ FLYERS

    /// DELETE MY AUTHOR PIC ON FIRE STORAGE

    /// DELETE BZID FROM MY BZZ IDS THEN UPDATE MY USER MODEL EVERY WHERE PROTOCOL
    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );
    final UserModel _updatedUserModel = UserModel.removeBzIDFromMyBzzIDs(
      userModel: _myUserModel,
      bzIDToRemove: bzID,
    );
    await UserProtocol.updateMyUserEverywhereProtocol(
      context: context,
      newUserModel: _updatedUserModel,
    );

    blog('BzProtocol.myBzGotDeletedAndIShouldDeleteAllMyBzRelatedData : END');

  }
// ----------------------------------
  static Future<void> deleteMyAuthorPicProtocol({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('BzProtocol.deleteMyAuthorPicProtocol : START');

    /// GET MY USER MODEL -------------------
    final UserModel _myUserModel = await UsersProvider.proFetchUserModel(
      context: context,
      userID: superUserID(),
    );

    /// GET THE BZ MODEL -------------------
    final BzModel _bzModel = await BzLDBOps.readBz(bzID);

    if (_bzModel != null){

      /// GET MY AUTHOR MODEL -------------------
      final AuthorModel _myAuthor = AuthorModel.getAuthorFromAuthorsByID(
        authors: _bzModel.authors,
        authorID: _myUserModel.id,
      );

      /// CHECK IF USER MODEL PIC IS AUTHOR MODEL PIC -------------------
      final bool _authorPicIsHisUserPic = await AuthorModel.checkUserImageIsAuthorImage(
        context: context,
        authorModel: _myAuthor,
        userModel: _myUserModel,
      );

      /// PROCEED IF NOT IDENTICAL -------------------
      if (_authorPicIsHisUserPic == false){
        await BzFireOps.deleteAuthorPic(
          context: context,
          bzID: bzID,
          authorID: _myUserModel.id,
        );
      }

    }

    blog('BzProtocol.deleteMyAuthorPicProtocol : END');

  }
// -----------------------------------------------------------------------------
  /// bz deletion ops
// ------------------
  static Future<void> _deleteAllBzFlyersOps({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool updateBz,
    @required bool showWaitDialog,
  }) async {

    blog('BzProtocol._deleteAllBzFlyersOps : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting ${bzModel.flyersIDs.length} Flyers',
        canManuallyGoBack: false,
      ));
    }

    /// DELETE BZ FLYERS
    final List<FlyerModel> _flyers = await FlyersProvider.proFetchFlyers(
        context: context,
        flyersIDs: bzModel.flyersIDs
    );

    await FlyerProtocol.deleteMultipleBzFlyersProtocol(
        context: context,
        bzModel: bzModel,
        flyers: _flyers,
        showWaitDialog: false,
        updateBzEveryWhere: updateBz
    );

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    blog('BzProtocol._deleteAllBzFlyersOps : END');

  }
// ------------------

}
