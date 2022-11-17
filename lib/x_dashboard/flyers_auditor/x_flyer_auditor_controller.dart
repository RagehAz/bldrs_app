import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/flyer_verification_protocols.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/x_dashboard/flyers_auditor/auditor_button.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SELECTED FLYER OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFlyerOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required PaginationController controller,
}) async {
  // ---------
  flyerModel.blogFlyer();
  // ---------
  const double _buttonHeight = 60;
  // ---------
  final double _dialogHeight = BottomDialog.calculateDialogHeight(
      draggable: true,
      titleIsOn: true,
      childHeight: _buttonHeight * 3,
  );
  // ---------
  final double _clearHeight = BottomDialog.clearHeight(
    context: context,
    draggable: true,
    overridingDialogHeight: _dialogHeight,
    titleIsOn: true,
  );
  // ---------
  final String _shortTitle = flyerModel.getShortHeadline();
  // ---------
  final BzModel _bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: flyerModel.bzID,
  );
  // ---------
  await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      titleVerse: Verse.plain('$_shortTitle by ${_bzModel?.name}'),
      child: Container(
        width: BottomDialog.clearWidth(context),
        height: _clearHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[

            /// AUDIT - VERIFY FLYER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                /// AUDIT FLYER
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Audit Flyer',
                  color: Colorz.darkBlue,
                  icon: Iconz.dvGouran,
                  onTap: () => auditFlyer(
                    context: context,
                    flyerModel: flyerModel,
                  ),
                ),

                /// VERIFY FLYER
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Verify Flyer',
                  color: Colorz.green255,
                  verseColor: Colorz.black255,
                  icon: Iconz.verifyFlyer,
                  onTap: () => _verifyFlyer(
                    context: context,
                    flyerModel: flyerModel,
                    controller: controller,
                  ),
                ),

              ],
            ),

            /// DELETE FLYER - VERIFY BZ
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                /// DELETE FLYER
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Delete Flyer',
                  color: Colorz.red255,
                  icon: Iconz.xSmall,
                  onTap: () => _deleteFlyer(
                    context: context,
                    flyerModel: flyerModel,
                    controller: controller,
                  ),
                ),

                /// VERIFY BZ
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Verify bz',
                  color: Colorz.yellow255,
                  verseColor: Colorz.black255,
                  icon: _bzModel?.logoPath,
                  iconSizeFactor: 1,
                  verseScaleFactor: 0.6,
                  onTap: () => _verifyBz(
                    context: context,
                    bzID: flyerModel.bzID,
                    controller: controller,
                  ),
                ),

              ],
            ),

          ],
        ),
      )
  );

}
// -----------------------------------------------------------------------------

/// VERIFY

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _verifyFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required PaginationController controller,
}) async {

  /// CLOSE NAV DIALOG
  await Nav.goBack(
    context: context,
    invoker: 'onVerifyFlyer',
  );

  blog('currentFlyer : ${flyerModel?.slides?.length} slides');

  /// VERIFY OPS
  if (flyerModel.auditState != AuditState.verified) {

    /// UPDATE FIELD
    await FlyerVerificationProtocols.verifyFlyer(
      context: context,
      flyerModel: flyerModel,
    );

    /// REMOVE FROM LOCAL PAGINATOR FLYERS
    controller.deleteMapByID(id: flyerModel.id);

  }

  /// ALREADY VERIFIED
  else {

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Already Verified'),
      bodyVerse: Verse.plain('This flyer is already verified, check the next one. please'),
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _verifyBz({
  @required BuildContext context,
  @required String bzID,
  @required PaginationController controller,
}) async {

  final bool _canDelete = await Dialogs.confirmProceed(
    context: context,
    titleVerse: Verse.plain('Verify Bz and 1000 of its Flyers'),
  );

  if (_canDelete == true){

    /// UPDATE FIELD
    final List<FlyerModel> _verifiedFlyers = await FlyerVerificationProtocols.verifyBz(
      context: context,
      bzID: bzID,
    );

    controller.removeMapsByIDs(
      ids: FlyerModel.getFlyersIDsFromFlyers(_verifiedFlyers),
    );

  }

}
// -----------------------------------------------------------------------------

/// AUDIT

// --------------------
///
Future<void> auditFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  blog('should audit flyer');

}
// -----------------------------------------------------------------------------

/// DELETE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _deleteFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required PaginationController controller,
}) async {

  final bool _canDelete = await Dialogs.confirmProceed(
    context: context,
    titleVerse: Verse.plain('Delete Flyer ?'),
    invertButtons: true,
  );

  if (_canDelete == true){

    /// CLOSE BOTTOM DIALOG
    await Nav.goBack(context: context);

    /// WIPE FLYER
    await FlyerProtocols.wipeFlyer(
      context: context,
      flyerModel: flyerModel,
      showWaitDialog: true,
      isDeletingBz: false,
    );

    /// UPDATE PAGINATOR
    controller.deleteMapByID(id: flyerModel.id);

  }

}
// -----------------------------------------------------------------------------
