import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerFireOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// -------------------------------
Future<void> onFlyerBzOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
  @required BzModel bzModel,
}) async {

  blog('SHOULD DELETE THIS FLYER');
  blog('if flyer is only 48 hours old');

  final String _age = Timers.getSuperTimeDifferenceString(
    from: PublishTime.getPublishTimeFromTimes(
      times: flyer.times,
      state: PublishState.published,
    )?.time,
    to: DateTime.now(),
  );

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      numberOfWidgets: 2,
      title: 'published $_age',
      builder: (_, PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
            context: context,
            verse: 'Edit flyer',
            verseCentered: true,
            onTap: () => _onEditFlyerButtonTap(flyer),
          ),

          BottomDialog.wideButton(
            context: context,
            verse: 'Delete flyer',
            verseCentered: true,
            onTap: () => _onDeleteFlyerButtonTap(
              context: context,
              flyer: flyer,
              bzModel: bzModel,
            ),
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// -------------------------------
Future<void> _onEditFlyerButtonTap(FlyerModel flyer) async {
  blog('should edit flyer');
}
// -----------------------------------------------------------------------------

/// FLYER DELETION

// -------------------------------
Future<void> _onDeleteFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
  @required BzModel bzModel,
}) async {

  blog('_onDeleteFlyer : starting deleting flyer ${flyer.id}');

  final bool _result = await _showConfirmDeleteFlyerDialog(
    context: context,
    flyer: flyer,
  );

  /// TASK : NEED TO CHECK USER PERMISSIONS TO BE ABLE TO CONTINUE DELETION PROCESSES
  /// => IS OWNER OF STORAGE PICS ?

  if (_result == true){

    await deleteFlyerOps(
        context: context,
        bzModel: bzModel,
        flyer: flyer,
        showWaitDialog: true
    );

    Nav.goBack(context);

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Flyer has been deleted successfully',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -------------------------------
Future<bool> _showConfirmDeleteFlyerDialog({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  final double _screenHeight = Scale.superScreenHeight(context);
  final double _dialogHeight = _screenHeight * 0.7;
  final double _flyerBoxHeight = _dialogHeight * 0.5;

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete Flyer',
    body: 'This will delete this flyer and all its content and can not be retrieved any more',
    boolDialog: true,
    confirmButtonText: 'Yes Delete Flyer',
    height: _dialogHeight,
    child: SizedBox(
      height: _flyerBoxHeight,
      child: AbsorbPointer(
        child: FlyerStarter(
          flyerModel: flyer,
          minWidthFactor: FlyerBox.sizeFactorByHeight(context, _flyerBoxHeight),
        ),
      ),
    ),
  );

  return _result;
}
// -------------------------------
Future<void> deleteFlyerOps({
  @required BuildContext context,
  @required BzModel bzModel,
  @required FlyerModel flyer,
  @required bool showWaitDialog,
}) async {

  if (showWaitDialog == true){
    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Deleting flyer',
      canManuallyGoBack: false,
    ));
  }

  /// DELETE FLYER OPS ON FIREBASE
  await FlyerFireOps.deleteFlyerOps(
    context: context,
    flyerModel: flyer,
    bzModel: bzModel,
    deleteFlyerIDFromBzzFlyersIDs: true,
  );

  /// REMOVE ID FROM BZ FLYERS IDS ON FIREBASE
  final List<String> _updatedFlyersIDs = BzModel.removeFlyerIDFromBzFlyersIDs(
    bzModel: bzModel,
    flyerIDToRemove: flyer.id,
  );

  final BzModel _updatedBzModel = bzModel.copyWith(
    flyersIDs: _updatedFlyersIDs,
  );

  /// DELETE FLYER ON LDB
  await LDBOps.deleteMap(
      objectID: flyer.id,
      docName: LDBDoc.flyers
  );

  /// UPDATE BZ ON LDB
  await LDBOps.insertMap(
    docName: LDBDoc.bzz,
    input: _updatedBzModel.toMap(toJSON: true),
  );

  /// UPDATE BZ ON PROVIDER
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.setActiveBz(
    bzModel: _updatedBzModel,
    notify: false,
  );

  /// UPDATE ACTIVE BZ FLYERS
  final List<FlyerModel> _updatedFlyers = FlyerModel.removeFlyerFromFlyersByID(
    flyers: _bzzProvider.myActiveBzFlyers,
    flyerIDToRemove: flyer.id,
  );
  _bzzProvider.setActiveBzFlyers(
    flyers: _updatedFlyers,
    notify: true,
  );

  /// REMOVE FLYER FROM FLYERS PROVIDER
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.removeFlyerFromFlyersProvider(
    flyerID: flyer.id,
    notify: true,
  );

  if (showWaitDialog == true){
    WaitDialog.closeWaitDialog(context);
  }

}
// -----------------------------------------------------------------------------