import 'dart:async';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class RenovateBzProtocols {
  // -----------------------------------------------------------------------------

  const RenovateBzProtocols();

  // -----------------------------------------------------------------------------
  static Future<BzModel> renovateBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
    @required bool showWaitDialog,
    @required bool navigateToBzInfoPageOnEnd,
  }) async {
    blog('RenovateBzProtocol.renovateBz : START');

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: '##Updating Business account',
      ));
    }

    /// FIRE
    final BzModel _uploadedBzModel = await BzFireOps.updateBz(
      context: context,
      newBzModel: newBzModel,
      oldBzModel: oldBzModel,
      authorPicFile: null,
    );

    /// ON SUCCESS
    if (_uploadedBzModel != null){

      await updateBzLocally(
          context: context,
          newBzModel: _uploadedBzModel,
          oldBzModel: oldBzModel
      );

      /// CLOSE WAIT DIALOG
      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

      /// ON END NAVIGATION
      if (navigateToBzInfoPageOnEnd == true){

        Nav.goBackToHomeScreen(
          context: context,
          invoker: 'renovateBz',
        );

        unawaited(
            Nav.goToNewScreen(
              context: context,
              transitionType: PageTransitionType.fade,
              screen: const MyBzScreen(
                initialTab: BzTab.about,
              ),
            )
        );

        /// SHOW SUCCESS DIALOG
        unawaited(TopDialog.showTopDialog(
          context: context,
          firstLine: '##Great !',
          secondLine: '##Successfully updated your Business Account',
          color: Colorz.green255,
          textColor: Colorz.white255,
        ));

      }

    }

    /// ON FAILURE
    else {

      /// CLOSE WAIT DIALOG
      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

      await _failureDialog(context);

    }

    blog('RenovateBzProtocol.renovateBz : END');
    return _uploadedBzModel;
  }
  // --------------------
  static Future<void> updateBzLocally({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) async {
    blog('RenovateBzProtocol.updateBzLocally : START');

    /// LOCAL UPDATE PROTOCOL
    /// is to update my-active-bz-model in PRO and LDB in case of model changes

    final bool _areTheSame = BzModel.checkBzzAreIdentical(
      bz1: newBzModel,
      bz2: oldBzModel,
    );
    blog('RenovateBzProtocol.updateBzLocally : bzz are identical : $_areTheSame');

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

      blog('RenovateBzProtocol.updateBzLocally : my active bz updated in PRO & LDB');

    }

    blog('RenovateBzProtocol.updateBzLocally : END');
  }
  // --------------------
  static Future<BzModel> completeBzZoneModel({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {
    // blog('RenovateBzProtocol.completeBzZoneModel : START');

    BzModel _output = bzModel;

    if (bzModel != null){

      /// COMPLETED ZONE MODEL
      final ZoneModel _completeZoneModel = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: bzModel.zone,
      );

      /// COMPLETED BZ MODEL
      _output = bzModel.copyWith(
        zone: _completeZoneModel,
      );

    }

    // blog('RenovateBzProtocol.completeBzZoneModel : END');
    return _output;
  }
  // --------------------
  static Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: '##Ops !',
      bodyVerse: '##Something went wrong, Please try again',
    );

  }
  // -----------------------------------------------------------------------------
}
