import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
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
  @required ValueNotifier<bool> loading,
}) async {

  loading.value = true;

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    context: context,
    collName: FireColl.flyers,
    orderBy: const Fire.QueryOrderBy(fieldName: 'id', descending: true),
    limit: 6,
    startAfter: canLoopList(flyers.value) == true ? flyers.value.last.docSnapshot : null,
    addDocSnapshotToEachMap: true,
    finders: <FireFinder>[
      FireFinder(
        field: 'auditState',
        comparison: FireComparison.nullValue,
        value: true,
      ),
      FireFinder(
        field: 'publishState',
        comparison: FireComparison.equalTo,
        value: FlyerModel.cipherPublishState(PublishState.published),
      ),
    ],
  );

  final List<FlyerModel> _fetchedModels = FlyerModel.decipherFlyers(
    maps: _maps,
    fromJSON: false,
  );

  if (canLoopList(_fetchedModels) == true){
    flyers.value = <FlyerModel>[...flyers.value, ..._fetchedModels];
  }
  else {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'DONE !',
      body: 'No more flyers need verification',
    );
  }

  loading.value = false;

}
// -----------------------------------------------------------------------------

/// SELECTED FLYER OPTIONS

// -------------------------------------
Future<void> onFlyerOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required ValueNotifier<List<FlyerModel>> flyers,
}) async {

  const double _dialogHeight = 120;
  final double _clearHeight = BottomDialog.clearHeight(
    context: context,
    draggable: true,
    overridingDialogHeight: _dialogHeight,
    titleIsOn: true,
  );
  final double _buttonHeight = _clearHeight - Ratioz.appBarMargin;
  final String _shortTitle = flyerModel.getShortTitle();

  await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _dialogHeight,
      title: 'Audit Flyer : $_shortTitle',
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
                flyers: flyers,
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
  @required ValueNotifier<List<FlyerModel>> flyers,
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

    _removeFlyerFromFlyers(
      flyers: flyers,
      flyerIDToRemove: flyerModel.id,
    );

    CenterDialog.closeCenterDialog(context);

    NavDialog.showNavDialog(
      context: context,
      firstLine: 'Done',
      secondLine: 'flyer ${flyerModel.getShortTitle()}... got verified',
      color: Colorz.green255,
      seconds: 1,
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
void _removeFlyerFromFlyers({
  @required ValueNotifier<List<FlyerModel>> flyers,
  @required String flyerIDToRemove,
}){

  final List<FlyerModel> _updatedList = FlyerModel.removeFlyerFromFlyersByID(
      flyers: flyers.value,
      flyerIDToRemove: flyerIDToRemove,
  );

  flyers.value = _updatedList;

}
// -------------------------------------
Future<void> onAuditFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {
  blog('should audit flyer');
}
// -----------------------------------------------------------------------------
