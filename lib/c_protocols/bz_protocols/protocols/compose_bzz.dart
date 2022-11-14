import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/mutables/draft_bz.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TAMAM
class ComposeBzProtocols {
  // -----------------------------------------------------------------------------

  const ComposeBzProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> compose({
    @required BuildContext context,
    @required DraftBz newDraft,
    @required UserModel userModel,
  }) async {
    blog('ComposeBzProtocol.compose : START');

    assert(newDraft.logoPicModel != null, 'logoPicModel is null');

    /// WAIT DIALOG
    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: const Verse(
        text: 'phid_creating_new_bz_account',
        translate: true,
      ),
    ));

    /// CREATE BZ ID
    final String _bzID = await BzFireOps.createEmptyBzDocToGetBzID();

    /// OVERRIDE BZ ID
    final DraftBz _draftWithID = DraftBz.overrideBzID(
      draft: newDraft,
      bzID: _bzID,
    );

    /// BAKE DRAFT TO INITIAL BZ
    BzModel _bzModel = DraftBz.toBzModel(_draftWithID);


    /// UPDATE MY USER MODEL
    await _addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics(
      context: context,
      bzID: _bzModel.id,
    );

    /// OVERRIDE CREATION TIME
    _bzModel = _bzModel.copyWith(
      createdAt: DateTime.now(),
    );

    /// UPLOAD
    await Future.wait(<Future>[

      /// UPDATE BZ DOC
      BzFireOps.update(_bzModel),

      /// UPLOAD BZ LOGO
      PicProtocols.composePic(_draftWithID.logoPicModel),

      /// UPLOAD AUTHOR PIC
      _duplicateUserPicAsAuthorPic(
        userModel: userModel,
        bzID: _bzID,
      ),

      /// ADD NEW BZ LOCALLY
      _addMyNewCreatedBzLocally(
        context: context,
        bzModel: _bzModel,
      ),

    ]);

    /// CLOSE WAIT DIALOG
    await WaitDialog.closeWaitDialog(context);

    /// SHOW SUCCESS DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_great_!',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'Successfully created your Business Account\n system will reboot now',
        text: 'phid_created_bz_successfully',
        translate: true,
      ),
      // color: Colorz.green255,
    );

    /// NAVIGATE
    await Nav.goRebootToInitNewBzScreen(
      context: context,
      bzID: _bzModel.id,
    );

    blog('ComposeBzProtocol.compose : END');
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMyNewCreatedBzLocally({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    final BzModel _bzModelWithCompleteZoneModel = await BzProtocols.completeBzZoneModel(
        context: context,
        bzModel: bzModel
    );

    /// LDB INSERT
    await BzLDBOps.insertBz(_bzModelWithCompleteZoneModel);

    /// PRO INSERT IN MY BZZ
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _bzModelWithCompleteZoneModel,
      notify: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics({
    @required BuildContext context,
    @required String bzID,
  }) async {

    UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    _myUserModel = UserModel.addBzIDToUserBzz(
      userModel: _myUserModel,
      bzIDToAdd: bzID,
    );

    _myUserModel = UserModel.addAllBzTopicsToMyTopics(
        userModel: _myUserModel,
        bzID: bzID
    );

    await Future.wait(<Future>[

      NoteProtocols.subscribeToAllBzTopics(
        context: context,
        bzID: bzID,
        renovateUser: false,
      ),

      UserProtocols.renovate(
        context: context,
        newPic: null,
        newUserModel: _myUserModel,
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _duplicateUserPicAsAuthorPic({
    @required UserModel userModel,
    @required String bzID,
  }) async {

    if (userModel != null && bzID != null){

      final PicModel _picModel = await PicProtocols.fetchPic(userModel.picPath);

      final PicModel _authorModel = _picModel.copyWith(
        path: Storage.generateAuthorPicPath(
          bzID: bzID,
          authorID: userModel.id,
        ),
      );

      _authorModel.blogPic(invoker: '_duplicateUserPicAsAuthorPic');

      await PicProtocols.composePic(_authorModel);

    }

  }
  // --------------------
  /// DEPRECATED : IT WILL NEVER FAIL ISA
  /*
  ///
  static Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_ops_!',
        translate: true,
      ),
      bodyVerse: const Verse(
        text: 'phid_somethingIsWrong',
        translate: true,
      ),
    );

  }
   */
  // -----------------------------------------------------------------------------
}
