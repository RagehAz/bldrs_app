import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/a_flyer_maker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// --------------------
Future<void> onFlyerBzOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  blog('SHOULD DELETE THIS FLYER');
  blog('if flyer is only 48 hours old');

  final String _age = Timers.calculateSuperTimeDifferenceString(
    from: PublishTime.getPublishTimeFromTimes(
      times: flyer.times,
      state: PublishState.published,
    )?.time,
    to: DateTime.now(),
  );

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
    flyer: flyer,
    myID: AuthFireOps.superUserID(),
    bzModel: BzzProvider.proGetActiveBzModel(context: context, listen: false),
  );

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      numberOfWidgets: 2,
      titleVerse: Verse(
        text: '##published $_age',
        translate: true,
        variables: _age,
      ),
      builder: (_, PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
            context: context,
            verse: const Verse(text: 'phid_edit_flyer', translate: true),
            verseCentered: true,
            onTap: () => _onEditFlyerButtonTap(
              context: context,
              flyer: flyer,
            ),
          ),

          BottomDialog.wideButton(
            context: context,
            verse: const Verse(text: 'phid_delete_flyer', translate: true),
            verseCentered: true,
            isDeactivated: !_canDeleteFlyer,
            onDeactivatedTap: () => _onCanNotDeleteFlyerDialog(
              context: context,
            ),
            onTap: () => _onDeleteFlyerButtonTap(
              context: context,
              flyer: flyer,
            ),
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// --------------------
Future<void> _onEditFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(
    context: context,
    invoker: '_onEditFlyerButtonTap',
  );

  await Nav.goToNewScreen(
      context: context,
      screen: FlyerMakerScreen(
        flyerToEdit: flyer,
        validateOnStartup: true,
      ),
  );

}
// -----------------------------------------------------------------------------

/// FLYER DELETION

// --------------------
Future<void> _onCanNotDeleteFlyerDialog({
  @required BuildContext context,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      pseudo: 'Can not Delete Flyer',
      text: 'phid_can_not_delete_flyer',
      translate: true,
    ),
  );

}
// --------------------
Future<void> _onDeleteFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  blog('_onDeleteFlyer : starting deleting flyer ${flyer.id}');

  final bool _result = await _preFlyerDeleteCheckups(
    context: context,
    flyer: flyer,
  );

  if (_result == true){

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    final BzModel _updatedBzModel = await FlyerProtocols.wipeTheFlyer(
      context: context,
      flyerModel: flyer,
      bzModel: _bzModel,
      showWaitDialog: true,
      isDeletingBz: false,
    );

    /// NOTE : might not really need this as bz stream would do the job
    await BzProtocols.updateBzLocally(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: _bzModel
    );

    Nav.goBack(
      context: context,
      invoker: '_onDeleteFlyerButtonTap',
    );

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_flyer_has_been_deleted_successfully',
        translate: true,
      ),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// --------------------
Future<bool> _preFlyerDeleteCheckups({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  bool _canContinue = false;

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
  );

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
      myID: AuthFireOps.superUserID(),
      flyer: flyer,
      bzModel: _bzModel
  );

  /// CAN NOT DELETE IF NOT CREATOR
  if (_canDeleteFlyer == false){

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_can_not_delete_flyer',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'Only Business Account creator can Delete flyers',
        text: 'phid_only_bz_creator_can_delete_flyer',
        translate: true,
      ),
    );

  }

  /// CONFIRM DELETION IS CREATOR
  else {

    _canContinue = await Dialogs.flyerDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_delete_flyer',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'This will delete this flyer and all its content and can not be retrieved any more',
        text: 'phid_flyer_deletion_warning',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        text: 'phid_yes_delete_flyer',
        translate: true,
      ),
      flyer: flyer,
    );

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------
