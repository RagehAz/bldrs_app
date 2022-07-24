

import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComposeBzProtocols {
// -----------------------------------------------------------------------------

  ComposeBzProtocols();

// -----------------------------------------------------------------------------
  static Future<void> compose({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required UserModel userModel,
  }) async {
    blog('ComposeBzProtocol.compose : START');

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Creating a new Business Account',
    ));

    /// FIREBASE CREATE BZ OPS
    final BzModel _uploadedBzModel = await BzFireOps.createBz(
      context: context,
      draftBz: newBzModel,
      userModel: userModel,
    );

    blog('ComposeBzProtocol.compose : bosss bosss');

    /// ON SUCCESS
    if (_uploadedBzModel != null){

      blog('ComposeBzProtocol.compose : _uploadedBzModel != null : ahooooooooooo');
      // await BzProtocol.addMyNewCreatedBzLocally( );

      /// LDB CREATE BZ OPS
      await BzLDBOps.insertBz(
        bzModel: _uploadedBzModel,
      );
      /// LDB UPDATE USER MODEL
      await UserLDBOps.addBzIDToMyBzzIDs( /// TASK : should update user local protocol
        userModel: userModel,
        bzIDToAdd: _uploadedBzModel.id,
      );

      blog('ComposeBzProtocol.compose : 1');

      /// SET BZ MODEL LOCALLY
      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
      blog('ComposeBzProtocol.compose : 2');
      final BzModel _bzModelWithCompleteZoneModel = await BzProtocols.completeBzZoneModel(
          context: context,
          bzModel: _uploadedBzModel
      );
      blog('ComposeBzProtocol.compose : 3');
      _bzzProvider.addBzToMyBzz(
        bzModel: _bzModelWithCompleteZoneModel,
        notify: true,
      );
      blog('ComposeBzProtocol.compose : 4');
      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      _usersProvider.addBzIDToMyBzzIDs(
        bzIDToAdd: _bzModelWithCompleteZoneModel.id,
        notify: true,
      );
      blog('ComposeBzProtocol.compose : 5');
      /// CLOSE WAIT DIALOG
      WaitDialog.closeWaitDialog(context);

      blog('ComposeBzProtocol.compose : 6');

      /// SHOW SUCCESS DIALOG
      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Great !',
        secondLine: 'Successfully created your Business Account\n system will reboot now',
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

      blog('ComposeBzProtocol.compose : 6');

      /// NAVIGATE
      await Nav.goRebootToInitNewBzScreen(
        context: context,
        bzID: _bzModelWithCompleteZoneModel.id,
      );

      blog('ComposeBzProtocol.compose : 7');

    }

    /// ON FAILURE
    else {

      /// CLOSE WAIT DIALOG
      WaitDialog.closeWaitDialog(context);

      await _failureDialog(context);

    }

    blog('ComposeBzProtocol.compose : END');
  }
// -----------------------------------------------------------------------------
  static Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Ops !',
      body: 'Something went wrong, Please try again',
    );

  }

}
