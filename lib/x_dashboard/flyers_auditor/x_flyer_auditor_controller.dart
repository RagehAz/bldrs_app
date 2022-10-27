import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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

  flyerModel.blogFlyer();

  const double _dialogHeight = 300;
  final double _clearHeight = BottomDialog.clearHeight(
    context: context,
    draggable: true,
    overridingDialogHeight: _dialogHeight,
    titleIsOn: true,
  );
  const double _buttonHeight = 40;
  final String _shortTitle = flyerModel.getShortHeadline();

  await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      titleVerse: Verse.plain('Audit Flyer : $_shortTitle'),
      child: Container(
        width: BottomDialog.clearWidth(context),
        height: _clearHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[

            /// VERIFY BZ
            BottomDialog.wideButton(
                context: context,
                verse: Verse.plain('Verify Bz'),
                onTap: () async {

                  final bool _canDelete = await Dialogs.confirmProceed(
                    context: context,
                    titleVerse: Verse.plain('Verify Bz and all its Flyers'),
                  );

                  if (_canDelete == true){

                    /// TASK : CREATE VERIFY BZ AND FLYERS PROTOCOLS

                    /// VERIFY ALL BZ FLYERS PROTOCOL

                    /// VERIFY BZ

                    /// SEND BZ VERIFICATION NOTE

                  }


                }
            ),

            /// DELETE FLYER
            BottomDialog.wideButton(
              context: context,
              verse: Verse.plain('Delete'),
              onTap: () async {

                final bool _canDelete = await Dialogs.confirmProceed(
                  context: context,
                  titleVerse: Verse.plain('Delete Flyer ?'),
                  invertButtons: true,
                );

                if (_canDelete == true){

                  final BzModel bzModel = await BzProtocols.fetch(
                    context: context,
                    bzID: flyerModel.bzID,
                  );

                  await FlyerProtocols.wipeTheFlyer(
                    context: context,
                    flyerModel: flyerModel,
                    bzModel: bzModel,
                    showWaitDialog: true,
                    isDeletingBz: false,
                  );

                  _removeFlyerFromPaginatorFlyers(
                      controller: controller,
                      flyerIDToRemove: flyerModel.id,
                  );

                  await Nav.goBack(context: context);

                }


              }
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// AUDIT
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Audit',
                  color: Colorz.red255,
                  icon: Iconz.xSmall,
                  onTap: () => onAuditFlyer(
                    context: context,
                    flyerModel: flyerModel,
                  ),
                ),

                /// VERIFY
                AuditorButton(
                  height: _buttonHeight,
                  verse:  'Verify',
                  color: Colorz.green255,
                  icon: Iconz.check,
                  onTap: () => onVerifyFlyer(
                    context: context,
                    flyerModel: flyerModel,
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

/// VERIFICATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onVerifyFlyer({
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
    await Fire.updateDocField(
      collName: FireColl.flyers,
      docName: flyerModel.id,
      field: 'auditState',
      input: FlyerModel.cipherAuditState(AuditState.verified),
    );

    /// REMOVE FROM LOCAL PAGINATOR FLYERS
    _removeFlyerFromPaginatorFlyers(
      controller: controller,
      flyerIDToRemove: flyerModel.id,
    );

    /// SEND VERIFICATION NOTE
    await _sendFlyerVerificationUpdateNote(
      context: context,
      bzID: flyerModel.bzID,
      flyerID: flyerModel.id,
    );

    /// SHOW SUCCESS DIALOG
    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: Verse.plain('Done'),
      secondLine: Verse.plain('flyer ${flyerModel.getShortHeadline()}... got verified'),
    );

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
Future<void> _sendFlyerVerificationUpdateNote({
  @required BuildContext context,
  @required String flyerID,
  @required String bzID,
}) async {

  await NoteEvent.sendFlyerIsVerifiedNoteToBz(
    context: context,
    flyerID: flyerID,
    bzID: bzID,
  );

}
// -----------------------------------------------------------------------------

/// VERIFICATION

// --------------------
///
Future<void> onAuditFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  blog('should audit flyer');

}
// -----------------------------------------------------------------------------

/// LOCAL PAGINATION LISTENERS

// --------------------
/// TESTED : WORKS PERFECT
void _removeFlyerFromPaginatorFlyers({
  @required PaginationController controller,
  @required String flyerIDToRemove,
}){

  final Map<String, dynamic> _flyerMap = Mapper.getMapFromMapsByID(
    maps: controller.paginatorMaps.value,
    id: flyerIDToRemove,
    // idFieldName: 'id',
  );

  controller.deleteMap.value = _flyerMap;

}
// -----------------------------------------------------------------------------
