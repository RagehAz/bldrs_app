import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComposeBzProtocols {
  // -----------------------------------------------------------------------------

  const ComposeBzProtocols();

  // -----------------------------------------------------------------------------
  ///
  static Future<void> compose({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required UserModel userModel,
  }) async {
    blog('ComposeBzProtocol.compose : START');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: const Verse(
        text: 'phid_creating_new_bz_account',
        translate: true,
      ),
    ));

    /// FIREBASE CREATE BZ OPS
    final BzModel _uploadedBzModel = await BzFireOps.createBz(
      draftBz: newBzModel,
      userModel: userModel,
    );

    /// ON SUCCESS
    if (_uploadedBzModel != null){

      await Future.wait(<Future>[

        /// ADD NEW BZ LOCALLY
        _addMyNewCreatedBzLocally(
          context: context,
          bzModel: _uploadedBzModel,
        ),

        /// UPDATE MY USER MODEL
        _addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics(
          context: context,
          bzID: _uploadedBzModel.id,
        ),


      ]);

      /// CLOSE WAIT DIALOG
      await WaitDialog.closeWaitDialog(context);

      /// SHOW SUCCESS DIALOG
      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_great',
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
        bzID: _uploadedBzModel.id,
      );

    }

    /// ON FAILURE
    else {

      /// CLOSE WAIT DIALOG
      await WaitDialog.closeWaitDialog(context);

      await _failureDialog(context);

    }

    blog('ComposeBzProtocol.compose : END');
  }
  // --------------------
  ///
  static Future<void> _addMyNewCreatedBzLocally({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    final BzModel _bzModelWithCompleteZoneModel = await BzProtocols.completeBzZoneModel(
        context: context,
        bzModel: bzModel
    );

    /// LDB INSERT
    await BzLDBOps.insertBz(
      bzModel: _bzModelWithCompleteZoneModel,
    );

    /// PRO INSERT IN MY BZZ
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _bzModelWithCompleteZoneModel,
      notify: true,
    );

  }
  // --------------------
  ///
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

      UserProtocols.renovateMyUserModel(
        context: context,
        newUserModel: _myUserModel,
      ),

    ]);

  }
  // --------------------
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
  // -----------------------------------------------------------------------------
}
