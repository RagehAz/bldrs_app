import 'dart:async';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/e_notes/note_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/firestore.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/j_flyers_auditor/components/auditor_button.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/note_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

// -----------------------------------------------------------------------------

/// READING

// --------------------
Future<void> readMoreUnVerifiedFlyers({
  @required BuildContext context,
  @required ValueNotifier<List<FlyerModel>> flyers,
  @required ValueNotifier<bool> loading,
}) async {

  loading.value = true;

  final List<dynamic> _maps = await Fire.readCollectionDocs(
    context: context,
    collName: FireColl.flyers,
    orderBy: const QueryOrderBy(fieldName: 'id', descending: true),
    limit: 6,
    startAfter: Mapper.checkCanLoopList(flyers.value) == true ? flyers.value.last.docSnapshot : null,
    addDocSnapshotToEachMap: true,
    finders: <FireFinder>[

      const FireFinder(
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

  if (Mapper.checkCanLoopList(_fetchedModels) == true){
    flyers.value = <FlyerModel>[...flyers.value, ..._fetchedModels];
  }
  else {
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('DONE !'),
      bodyVerse: Verse.plain('No more flyers need verification'),
    );
  }

  loading.value = false;

}
// -----------------------------------------------------------------------------

/// SELECTED FLYER OPTIONS

// --------------------
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
        child: Row(
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
                flyers: flyers,
              ),
            ),

          ],
        ),
      )
  );

}
// --------------------
Future<void> onVerifyFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required ValueNotifier<List<FlyerModel>> flyers,
}) async {

  /// CLOSE NAV DIALOG
  await Nav.goBack(
    context: context,
    invoker: 'onVerifyFlyer',
  );

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

    await _sendFlyerVerificationUpdateNote(
      context: context,
      bzID: flyerModel.bzID,
      flyerID: flyerModel.id,
    );

    // await CenterDialog.closeCenterDialog(context);

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: Verse.plain('Done'),
      secondVerse: Verse.plain('flyer ${flyerModel.getShortHeadline()}... got verified'),
      color: Colorz.green255,
      milliseconds: 500,
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
// --------------------
Future<void> onAuditFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {
  blog('should audit flyer');
}
// --------------------
Future<void> _sendFlyerVerificationUpdateNote({
  @required BuildContext context,
  @required String flyerID,
  @required String bzID,
}) async {

  final NoteModel _note = NoteModel(
    id: 'x',
    senderID: NoteModel.bldrsSenderID,
    senderImageURL: NoteModel.bldrsLogoStaticURL,
    senderType: NoteSenderOrRecieverType.bldrs,
    receiverID: bzID,
    receiverType: NoteSenderOrRecieverType.bz,
    title: 'Flyer has been verified',
    body: 'This Flyer is now public to be seen and searched by all users',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: <String>[flyerID],
    attachmentType: NoteAttachmentType.flyer,
    seen: false,
    seenTime: null,
    sendFCM: true,
    type: NoteType.flyerUpdate,
    response: null,
    responseTime: null,
    buttons: null,
    token: null,
    topic: NoteModel.generateTopic(
      topicType: TopicType.flyerVerification,
      id: bzID,
    ),
  );

  await NoteFireOps.createNote(
      context: context,
      noteModel: _note
  );

}
// -----------------------------------------------------------------------------
