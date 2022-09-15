import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComposeBzProtocols {
  // -----------------------------------------------------------------------------

  const ComposeBzProtocols();

  // -----------------------------------------------------------------------------
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
      context: context,
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
        _addBzIdToMyUserModelAndRenovate(
          context: context,
          bzID: _uploadedBzModel.id,
        ),

      ]);

      /// CLOSE WAIT DIALOG
      WaitDialog.closeWaitDialog(context);

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
      WaitDialog.closeWaitDialog(context);

      await _failureDialog(context);

    }

    blog('ComposeBzProtocol.compose : END');
  }
  // --------------------
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
  static Future<void> _addBzIdToMyUserModelAndRenovate({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final UserModel _updated = UserModel.addBzIDToUserBzz(
      userModel: _myUserModel,
      bzIDToAdd: bzID,
    );

    await UserProtocols.renovateMyUserModel(
      context: context,
      newUserModel: _updated,
    );

  }
  // --------------------
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
