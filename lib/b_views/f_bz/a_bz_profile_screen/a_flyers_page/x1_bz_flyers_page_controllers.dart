import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/images/bldrs_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/poster/structure/x_note_poster_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths_generators.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFlyerBzOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  blog('~~~~~~~>');
  flyer.blogFlyer(invoker: 'onFlyerBzOptionsTap');
  blog('~~~~~~~>');

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
    flyer: flyer,
    myID: Authing.getUserID(),
    bzModel: BzzProvider.proGetActiveBzModel(context: context, listen: false),
  );

  final double _posterWidth = BottomDialog.clearWidth(context);
  final double _posterHeight = NotePosterBox.getBoxHeight(_posterWidth);
  final double _clearHeight = _posterHeight + (BottomDialog.wideButtonHeight * 2) + (5 * 2) + 10;

  await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      height: _clearHeight + BottomDialog.draggerZoneHeight(draggable: true),
      child: Column(
        children: <Widget>[

          /// POSTER
          BldrsImage(
            pic: StoragePath.flyers_flyerID_poster(flyer.id),
            height: _posterHeight,
            width: _posterWidth,
            corners: BldrsAppBar.corners,
          ),

          /// SEPARATOR
          const SizedBox(
            width: 5,
            height: 5,
          ),

          /// EDIT FLYER BUTTON
          BottomDialog.wideButton(
            context: context,
            verse: const Verse(id: 'phid_edit_flyer', translate: true),
            verseCentered: true,
            onTap: () => _onEditFlyerButtonTap(
              context: context,
              flyer: flyer,
            ),
          ),

          const SizedBox(
            width: 5,
            height: 5,
          ),

          /// DELETE FLYER BUTTON
          BottomDialog.wideButton(
            context: context,
            verseCentered: true,
            isDeactivated: !_canDeleteFlyer,
            onDeactivatedTap: () => _onCanNotDeleteFlyerDialog(
              context: context,
            ),
            /// --->
            verse: const Verse(id: 'phid_delete_flyer', translate: true),
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

          const SizedBox(
            width: 5,
            height: 10,
          ),

        ],
      ),

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

  final DraftFlyer _draft = await DraftFlyer.createDraft(
    context: context,
    oldFlyer: flyer,
  );

  final bool _result = await Nav.goToNewScreen(
    context: context,
    screen: NewFlyerEditorScreen(
      draftFlyer: _draft,
      onConfirm: (DraftFlyer draft) async {
        draft.blogDraft(invoker: 'New Flyer Editor Test');

        await onConfirmPublishFlyerButtonTap(
          context: context,
          oldFlyer: flyer,
          draft: draft,
        );

      },
    ),
  );

  if (_result == true){

    await TopDialog.showTopDialog(
      context: context,
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
Future<void> _onCanNotDeleteFlyerDialog({
  @required BuildContext context,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
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
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  final bool _result = await _preFlyerDeleteCheckups(
    context: context,
    flyer: flyer,
  );

  if (_result == true){

    await Nav.goBack(
      context: context,
      invoker: '_onDeleteFlyerButtonTap',
    );

    pushWaitDialog(
      context: context,
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
      context: context,
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
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  bool _canContinue = false;

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
  );

  final bool _canDeleteFlyer = AuthorModel.checkAuthorCanDeleteFlyer(
      myID: Authing.getUserID(),
      flyer: flyer,
      bzModel: _bzModel
  );

  /// CAN NOT DELETE IF NOT CREATOR
  if (_canDeleteFlyer == false){

    await CenterDialog.showCenterDialog(
      context: context,
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
      context: context,
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
