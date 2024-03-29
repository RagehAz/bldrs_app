import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/x_flyer_editor_screen.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFlyerBzOptionsTap({
  required FlyerModel flyer,
}) async {

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
    flyer: flyer,
    myID: Authing.getUserID(),
    bzModel: await BzProtocols.fetchBz(bzID: flyer.bzID),
  );

  await Dialogs.flyerOptionsDialog(
      flyer: flyer,
      buttons: <Widget>[

        /// EDIT FLYER BUTTON
        BottomDialog.wideButton(
          verse: const Verse(id: 'phid_edit_flyer', translate: true),
          verseCentered: true,
          onTap: () => onEditFlyerButtonTap(
            flyer: flyer,
          ),
        ),

        /// DELETE FLYER BUTTON
        BottomDialog.wideButton(
          verseCentered: true,
          isDisabled: !_canDeleteFlyer,
          onDisabledTap: () => _onCanNotDeleteFlyerDialog(),
          /// --->
          verse: const Verse(id: 'phid_delete_flyer', translate: true),
          onTap: () => _onDeleteFlyerButtonTap(
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

      ],
  );

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onEditFlyerButtonTap({
  required FlyerModel flyer,
}) async {

  /// CLOSE BOTTOM DIALOG
  await Nav.goBack(
    context: getMainContext(),
    invoker: '_onEditFlyerButtonTap',
  );

  WaitDialog.showUnawaitedWaitDialog();

  final DraftFlyer? _draft = await DraftFlyer.createDraft(
    oldFlyer: flyer,
  );

  await WaitDialog.closeWaitDialog();

  final bool? _result = await BldrsNav.goToNewScreen(
    screen: NewFlyerEditorScreen(
      draftFlyer: _draft,
      onConfirm: (DraftFlyer? draft) async {

        draft?.blogDraft(invoker: 'New Flyer Editor Test');

        await onConfirmPublishFlyerButtonTap(
          oldFlyer: flyer,
          draft: draft,
        );

      },
    ),
  );

  if (Mapper.boolIsTrue(_result) == true){

    await TopDialog.showTopDialog(
      firstVerse: const Verse(
        id: 'phid_flyer_has_been_published',
        translate: true,
      ),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------

/// FLYER DELETION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onCanNotDeleteFlyerDialog() async {

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: const Verse(
      pseudo: 'Can not Delete Flyer',
      id: 'phid_can_not_delete_flyer',
      translate: true,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteFlyerButtonTap({
  required FlyerModel flyer,
}) async {

  final bool _result = await _preFlyerDeleteCheckups(
    flyer: flyer,
  );

  if (_result == true){

    await Nav.goBack(
      context: getMainContext(),
      invoker: '_onDeleteFlyerButtonTap',
    );

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_deleting_flyer',
        translate: true,
      ),
    );

    await FlyerProtocols.onWipeSingleFlyer(
      flyerModel: flyer,
    );

    await WaitDialog.closeWaitDialog();

    await TopDialog.showTopDialog(
      firstVerse: const Verse(
        id: 'phid_flyer_has_been_deleted_successfully',
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
  required FlyerModel flyer,
}) async {

  bool _canContinue = false;

  final BzModel? _bzModel = await BzProtocols.fetchBz(
    bzID: flyer.bzID,
  );

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
      myID: Authing.getUserID(),
      flyer: flyer,
      bzModel: _bzModel
  );

  /// CAN NOT DELETE IF NOT CREATOR
  if (_canDeleteFlyer == false){

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_can_not_delete_flyer',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'Only Business Account creator can Delete flyers',
        id: 'phid_only_bz_creator_can_delete_flyer',
        translate: true,
      ),
    );

  }

  /// CONFIRM DELETION IS CREATOR
  else {

    _canContinue = await Dialogs.flyerDialog(
      titleVerse: const Verse(
        id: 'phid_delete_flyer',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'This will delete this flyer and all its content and can not be retrieved any more',
        id: 'phid_flyer_deletion_warning',
        translate: true,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_yes_delete',
        translate: true,
      ),
      invertButtons: true,
      flyer: flyer,
    );

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------
