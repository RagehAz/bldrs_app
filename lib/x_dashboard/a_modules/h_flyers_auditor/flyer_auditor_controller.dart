import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/h_flyers_auditor/auditor_button.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// READING

// -------------------------------------
Future<void> readMoreUnVerifiedFlyers({
  @required BuildContext context,
  @required ValueNotifier<List<FlyerModel>> flyers,
}) async {

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    context: context,
    collName: FireColl.flyers,
    orderBy: const Fire.QueryOrderBy(fieldName: 'id', descending: true),
    limit: 5,
    startAfter: canLoopList(flyers.value) == true ? flyers.value.last.docSnapshot : null,
    addDocSnapshotToEachMap: true,
    finders: <FireFinder>[
      FireFinder(
        field: 'publishState',
        comparison: FireComparison.equalTo,
        value: FlyerModel.cipherPublishState(PublishState.published),
      ),
      FireFinder(
        field: 'auditState',
        comparison: FireComparison.equalTo,
        value: null,
      ),
    ],
  );

  final List<FlyerModel> _fetchedModels = FlyerModel.decipherFlyers(
    maps: _maps,
    fromJSON: false,
  );

  flyers.value = <FlyerModel>[...flyers.value, ..._fetchedModels];

}
// -----------------------------------------------------------------------------

/// SELECTED FLYER OPTIONS

// -------------------------------------
Future<void> onFlyerOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  const double _dialogHeight = 120;
  final double _clearHeight = BottomDialog.clearHeight(
    context: context,
    draggable: true,
    overridingDialogHeight: _dialogHeight,
    titleIsOn: true,
  );
  final double _buttonHeight = _clearHeight - Ratioz.appBarMargin;

  await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      title: 'Audit Options',
      child: Container(
        width: BottomDialog.clearWidth(context),
        height: _clearHeight,
        color: Colorz.white10,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// AUDIT
            AuditorButton(
              height: _buttonHeight,
              verse: 'Audit',
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
              verse: 'Verify',
              color: Colorz.green255,
              icon: Iconz.check,
              onTap: () => onVerifyFlyer(
                  context: context,
                  flyerModel: flyerModel,
              ),
            ),

          ],
        ),
      )
  );

}
// -------------------------------------
Future<void> onVerifyFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  blog('currentFlyer : ${flyerModel?.slides?.length} slides');

  /// VERIFY OPS
  if (flyerModel.auditState != AuditState.verified) {

    await Fire.updateDocField(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
      field: 'auditState',
      input: FlyerModel.cipherAuditState(AuditState.verified),
    );

    // await _onRemoveFlyerFromStack(_currentFlyer);

    unawaited(
        TopDialog.showTopDialog(
          context: context,
          firstLine: 'Done',
          secondLine: 'flyer ${flyerModel.getShortTitle()}... got verified',
          color: Colorz.green255,
          textColor: Colorz.white255,
        )
    );

  }

  /// ALREADY VERIFIED
  else {

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Already Verified',
      body: 'This flyer is already verified, check the next one. please',
    );
  }

}
// -------------------------------------
Future<void> onAuditFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {
  blog('should audit flyer');
}
// -----------------------------------------------------------------------------
