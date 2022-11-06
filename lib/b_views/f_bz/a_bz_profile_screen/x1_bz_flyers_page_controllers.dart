import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/a_flyer_maker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFlyerBzOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  flyer.blogFlyer(methodName: 'onFlyerBzOptionsTap');

  // final String _age = Timers.calculateSuperTimeDifferenceString(
  //   from: PublishTime.getPublishTimeFromTimes(
  //     times: flyer.times,
  //     state: PublishState.published,
  //   )?.time,
  //   to: DateTime.now(),
  // );

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
      builder: (_){

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
            verseCentered: true,
            isDeactivated: !_canDeleteFlyer,
            onDeactivatedTap: () => _onCanNotDeleteFlyerDialog(
              context: context,
            ),
            /// --->
            verse: const Verse(text: 'phid_delete_flyer', translate: true),
            onTap: () => _onDeleteFlyerButtonTap(
              context: context,
              flyer: flyer,
            ),
            /// --->
            // for dev
            // verse: Verse.plain('refetch'),
            // onTap: () async {
            //   await FlyerProtocols.refetch(context: context, flyerID: flyer.id);
            // },
            /// --->
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  /// CLOSE BOTTOM DIALOG
  await Nav.goBack(
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> _onDeleteFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  // blog('_onDeleteFlyer : permanently starting deleting flyer ${flyer.id}');

  final bool _result = await _preFlyerDeleteCheckups(
    context: context,
    flyer: flyer,
  );

  if (_result == true){

    await Nav.goBack(
      context: context,
      invoker: '_onDeleteFlyerButtonTap',
    );

    await FlyerProtocols.wipeFlyer(
      context: context,
      flyerModel: flyer,
      showWaitDialog: true,
      isDeletingBz: false,
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
/// TESTED : WORKS PERFECT
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
        text: 'phid_yes_delete',
        translate: true,
      ),
      invertButtons: true,
      flyer: flyer,
    );

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------
