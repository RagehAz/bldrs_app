import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/h_app_settings/fcm_topics_screen.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZ EDITING

// --------------------
Future<void> onEditBzButtonTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: BzEditorScreen(
      bzModel: bzModel,
      // checkLastSession: true,
      // validateOnStartup: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// GO TO BZ NOTIFICATIONS SETTINGS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToBzFCMSettings({
  @required BuildContext context,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: const FCMTopicsScreen(
      partyType: PartyType.bz,
    ),
  );

}
// -----------------------------------------------------------------------------

/// BZ DELETION

// --------------------
Future<void> onDeleteBzButtonTap({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool showSuccessDialog,
}) async {

  final bool _canContinue = await _preDeleteBzAccountChecks(
    context: context,
    bzModel: bzModel,
  );

  if (_canContinue == true){

    await BzProtocols.wipeBz(
      context: context,
      bzModel: bzModel,
      showWaitDialog: true,
      includeMyselfInBzDeletionNote: true,
    );

    /// NO NEED FOR ROUTING BACK AND SHOWING DIALOGS HERE
    /// AS BZ DELETION PROTOCOL DOES THE JOB

    /// re-route back
    // if (routeBackHome == true){
    await Nav.goBackToHomeScreen(
        context: context,
        invoker: 'onDeleteBzButtonTap'
    );
    // }

    /// DELETE BZ LOCALLY
    final BuildContext _context = BldrsAppStarter.navigatorKey.currentContext;
    await BzProtocols.deleteLocally(
      context: _context,
      bzID: bzModel.id,
      invoker: 'onDeleteBzButtonTap',
    );


    if (showSuccessDialog == true){
      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          pseudo: 'Business Account has been deleted successfully',
          text: 'phid_bz_account_deleted_successfully',
          translate: true,
        ),
        color: Colorz.green255,
        textColor: Colorz.white255,
      );
    }

  }

}
// --------------------
/// bz deletion dialogs
// -----
Future<bool> _preDeleteBzAccountChecks({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  bool _canContinue = false;

  final bool _authorIsMaster = AuthorModel.checkUserIsCreatorAuthor(
    userID: AuthFireOps.superUserID(),
    bzModel: bzModel,
  );

  /// WHEN USER IS NOT MASTER AUTHOR
  if (_authorIsMaster == false){

    await _showOnlyCreatorCanDeleteBzDialog(
      context: context,
      bzModel: bzModel,
    );

  }

  /// WHEN USER IS MASTER AUTHOR
  else {

    final bool _confirmedDeleteBz = await _showConfirmDeleteBzDialog(
      context: context,
      bzModel: bzModel,
    );

    /// IF USER CHOSE TO CONTINUE DELETION
    if (_confirmedDeleteBz == true){

      /// IF BZ HAS NO FLYERS
      if (bzModel.flyersIDs.isEmpty == true) {
        _canContinue = true;
      }

      /// IF BZ HAS FLYERS
      else {

        final bool _confirmDeleteAllBzFlyers = await _showConfirmDeleteAllBzFlyersDialog(
          context: context,
          bzModel: bzModel,
        );

        /// IF USER CONFIRMED TO DELETE ALL BZ FLYERS
        if (_confirmDeleteAllBzFlyers == true){
          _canContinue = true;
        }

      }

    }


  }

  return _canContinue;
}
// -----
Future<bool> _showConfirmDeleteBzDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _result = await Dialogs.bzBannerDialog(
    context: context,
    bzModel: bzModel,
    titleVerse: Verse(
      text: 'Delete ${bzModel.name} Business Account ?',
      translate: true,
      variables: bzModel.name,
    ),
    bodyVerse: const Verse(
      pseudo: 'All Account flyers, records and data will be deleted and can not be retrieved',
      text: 'phid_bz_deletion_warning',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      text: 'phid_yes_delete',
      translate: true,
    ),
  );

  return _result;
}
// -----
Future<void> _showOnlyCreatorCanDeleteBzDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final String _creatorAuthorsString = AuthorModel.getCreatorAuthorFromBz(bzModel)?.name;

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      pseudo: 'Can Not Delete This Account',
      text: 'phid_cant_delete_account',
      translate: true,
    ),
    bodyVerse: Verse(
      text: '##Only $_creatorAuthorsString can delete this Account',
      translate: true,
      variables: _creatorAuthorsString,
    ),
  );

}
// -----
Future<bool> _showConfirmDeleteAllBzFlyersDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _result = await Dialogs.flyersDialog(
    context: context,
    titleVerse: Verse(
      text: '##${bzModel.flyersIDs.length} flyers will be permanently deleted',
      translate: true,
      variables: bzModel.flyersIDs.length,
    ),
    bodyVerse: const Verse(
      pseudo: 'Once flyers are deleted, they can not be retrieved',
      text: 'phid_flyers_deletion_warning',
      translate: true,
    ),
    confirmButtonVerse: Verse(
      text: '##Delete All Flyers And Remove ${bzModel.name}',
      translate: true,
      variables: bzModel.name,
    ),
    flyersIDs: bzModel.flyersIDs,
  );

  return _result;
}
// -----------------------------------------------------------------------------
