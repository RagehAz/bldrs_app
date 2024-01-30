import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/b_bz_editor_screen/bz_editor_screen.dart';
import 'package:bldrs/b_screens/x_situational_screens/fcm_topics_screen.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

/// => TAMAM
// -----------------------------------------------------------------------------

/// BZ EDITING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onEditBzButtonTap({
  required BzModel? bzModel,
}) async {

  await BldrsNav.goToNewScreen(
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
Future<void> onGoToBzFCMSettings() async {

  await BldrsNav.goToNewScreen(
    screen: const FCMTopicsScreen(
      partyType: PartyType.bz,
    ),
  );

}
// -----------------------------------------------------------------------------

/// BZ DELETION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteBzButtonTap({
  required BuildContext context,
  required BzModel? bzModel,
}) async {

  final bool _canContinue = await _preDeleteBzAccountChecks(
    bzModel: bzModel,
  );

  if (_canContinue == true){

    await BzProtocols.wipeBz(
      context: context,
      bzModel: bzModel,
      showWaitDialog: true,
      // includeMyselfInBzDeletionNote: true,
      // deleteBzLocally: true,
    );

    // /// DELETE BZ LOCALLY
    // await BzProtocols.deleteLocally(
    //   bzID: bzModel?.id,
    //   invoker: 'onDeleteBzButtonTap',
    // );

    await Dialogs.centerNotice(
      verse: const Verse(
        id: 'phid_bz_account_deleted_successfully',
        translate: true,
      ),
    );

    await ScreenRouter.goTo(routeName: ScreenName.logo, arg: null);

  }

}
// --------------------
/// bz deletion dialogs
// -----
/// TESTED : WORKS PERFECT
Future<bool> _preDeleteBzAccountChecks({
  required BzModel? bzModel,
}) async {

  bool _canContinue = false;

  final bool _authorIsMaster = AuthorModel.checkUserIsCreatorAuthor(
    userID: Authing.getUserID(),
    bzModel: bzModel,
  );

  /// WHEN USER IS NOT MASTER AUTHOR
  if (_authorIsMaster == false){

    await _showOnlyCreatorCanDeleteBzDialog(
      bzModel: bzModel,
    );

  }

  /// WHEN USER IS MASTER AUTHOR
  else {

    final bool _confirmedDeleteBz = await _showConfirmDeleteBzDialog(
      bzModel: bzModel,
    );

    /// IF USER CHOSE TO CONTINUE DELETION
    if (_confirmedDeleteBz == true){

      /// IF BZ HAS NO FLYERS
      if (PublicationModel.checkPublicationIsEmpty(publication: bzModel?.publication) == true) {
        _canContinue = true;
      }

      /// IF BZ HAS FLYERS
      else {

        _canContinue = await _showConfirmDeleteAllBzFlyersDialog(
          bzModel: bzModel,
        );

      }

    }


  }

  return _canContinue;
}
// -----
/// TESTED : WORKS PERFECT
Future<bool> _showConfirmDeleteBzDialog({
  required BzModel? bzModel,
}) async {

  final bool _result = await Dialogs.bzBannerDialog(
    bzModel: bzModel,
    invertButtons: true,
    titleVerse: Verse(
      id: 'phid_delete_bz_account_?',
      translate: true,
      variables: bzModel?.name,
    ),
    bodyVerse: const Verse(
      id: 'phid_bz_deletion_warning',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      id: 'phid_yes_delete',
      translate: true,
    ),
  );

  return _result;
}
// -----
/// TESTED : WORKS PERFECT
Future<void> _showOnlyCreatorCanDeleteBzDialog({
  required BzModel? bzModel,
}) async {

  final String? _creatorAuthorsString = AuthorModel.getCreatorAuthorFromAuthors(bzModel?.authors)?.name;

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: const Verse(
      id: 'phid_cant_delete_account',
      translate: true,
    ),
    bodyVerse: Verse(
      id: '$_creatorAuthorsString\n${getWord('phid_is_only_who_can_delete_this_bz')}',
      translate: false,
    ),
  );

}
// -----
Future<bool> _showConfirmDeleteAllBzFlyersDialog({
  required BzModel? bzModel,
}) async {

  final bool _result = await Dialogs.flyersDialog(
    titleVerse: const Verse(
      id: 'phid_all_bz_flyers_will_be_wiped',
      translate: true,
    ),
    bodyVerse: const Verse(
      id: 'phid_flyers_deletion_warning',
      translate: true,
    ),
    confirmButtonVerse: Verse(
      id: 'phid_delete_all_flyers',
      translate: true,
      variables: bzModel?.name,
    ),
    flyersIDs: bzModel?.publication.getAllFlyersIDs(),
  );

  return _result;
}
// -----------------------------------------------------------------------------
