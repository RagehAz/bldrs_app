import 'dart:async';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/b_author_role_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/a_author_search_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToAddAuthorsScreen(BuildContext context) async {

  await Nav.goToNewScreen(
    context: context,
    screen: const AuthorSearchScreen(),
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAuthorOptionsTap({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  final bool _itIsMine = AuthFireOps.superUserID() == authorModel.userID;

  final AuthorModel _myAuthorModel = AuthorModel.getAuthorFromAuthorsByID(
      authors: bzModel.authors,
      authorID: AuthFireOps.superUserID(),
  );

  final bool _canChangeRoles = AuthorModel.checkAuthorAbility(
      theDoer: _myAuthorModel,
      theDoneWith: authorModel,
      ability: _itIsMine ? AuthorAbility.canChangeSelfRole : AuthorAbility.canChangeOthersRoles,
  );

  final bool _canEditAuthor = AuthorModel.checkAuthorAbility(
    theDoer: _myAuthorModel,
    theDoneWith: authorModel,
    ability: AuthorAbility.canEditOtherAuthor,
  );

  final bool _canRemoveAuthor = AuthorModel.checkAuthorAbility(
    theDoer: _myAuthorModel,
    theDoneWith: authorModel,
    ability: _itIsMine ? AuthorAbility.canRemoveSelf : AuthorAbility.canRemoveOtherAuthor,
  );

  final String _authorName = authorModel?.name ?? '...';

  final List<Widget> _buttons = <Widget>[

    /// CHANGE ROLE
    BottomDialog.wideButton(
      context: context,
      verse: const Verse(
        text: 'phid_change_team_role',
        translate: true,
      ),
      icon: Iconz.bz,
      isDeactivated: !_canChangeRoles,
      onDeactivatedTap: () => _onShowCanNotChangeAuthorRoleDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () async {

        /// TO CLOSE BOTTOM DIALOG
        Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Change team role for',
        );

        await _onChangeAuthorRole(
          context: context,
          bzModel: bzModel,
          authorModel: authorModel,
        );

      },
    ),

    /// EDIT AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: const Verse(
        text: 'phid_edit_author_details',
        translate: true,
      ),
      icon: Iconz.gears,
      isDeactivated: !_canEditAuthor,
      onDeactivatedTap: () => _onShowCanNotEditAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () async {

        /// TO CLOSE BOTTOM DIALOG
        Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Edit $_authorName Author details',
        );

        await _onEditAuthor(
          context: context,
          bzModel: bzModel,
          authorModel: authorModel,
        );

      },
    ),

    /// REMOVE AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: const Verse(
        text: 'phid_remove_author_from_the_team',
        translate: true,
      ),
      icon: Iconz.xSmall,
      isDeactivated: _canRemoveAuthor == false,
      onDeactivatedTap: () => _onShowCanNotRemoveAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: (){

        /// CLOSE BOTTOM DIALOG
        Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Remove $_authorName from the team',
        );

        onDeleteAuthorFromBz(
          context: context,
          bzModel: bzModel,
          authorModel: authorModel,
          showConfirmationDialog: true,
          showWaitingDialog: true,
          sendToUserAuthorExitNote: true,
        );

      },
    ),

  ];

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: _buttons.length,
      builder: (_, PhraseProvider phraseProvider){

        return _buttons;

      }
  );

}
// -----------------------------------------------------------------------------

/// PRE DELETE AUTHOR

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteAuthorFromBz({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
  @required bool showConfirmationDialog,
  @required bool showWaitingDialog,
  @required bool sendToUserAuthorExitNote,
}) async {

  bool _result;

  if (showConfirmationDialog == true){
    _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse(
        text: '##Remove ${authorModel.name} ?',
        translate: true,
        variables: authorModel.name,
      ),
      bodyVerse: Verse(
        text: '##${authorModel.name} and all his published flyers will be deleted as well',
        translate: true,
        variables: authorModel.name,
      ),
      boolDialog: true,
    );
  }
  else {
    _result = true;
  }

  if (_result == true){

    final bool _authorHasFlyers = AuthorModel.checkAuthorHasFlyers(
      author: authorModel,
    );

    /// REMOVE AUTHOR HAS FLYERS
    if (_authorHasFlyers == true){

      await _removeAuthorWhoHasFlyers(
        context: context,
        authorModel: authorModel,
        bzModel: bzModel,
        showWaitDialog: showWaitingDialog,
        showConfirmationDialog: showConfirmationDialog,
        sendToUserAuthorExitNote: sendToUserAuthorExitNote,
      );

    }

    /// REMOVE AUTHOR HAS NO FLYERS
    else {

      await _removeAuthorWhoHasNoFlyers(
        context: context,
        authorModel: authorModel,
        bzModel: bzModel,
        showWaitDialog: showWaitingDialog,
        showConfirmationDialog: showConfirmationDialog,
        sendToUserAuthorExitNote: sendToUserAuthorExitNote,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotRemoveAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse(
      text: '##You can not remove ${authorModel.name}',
      translate: true,
      variables: authorModel.name,
    ),
    bodyVerse: const Verse(
      text: '##Only Account Admins can remove other team members,\n'
          'however you can remove only yourself from this business account',
      translate: true,
    ),
  );

}
// -----------------------------------------------------------------------------

/// DELETE AUTHOR WHO HAS FLYERS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _removeAuthorWhoHasFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
  @required bool showWaitDialog,
  @required bool showConfirmationDialog,
  @required bool sendToUserAuthorExitNote,
}) async {

  bool _result;

  if (showConfirmationDialog == true){
    _result = await _showDeleteAllAuthorFlyers(
      context: context,
      authorModel: authorModel,
    );
  }
  else {
    _result = true;
  }

  if (_result == true){

    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: Verse(
          text: '##Removing ${authorModel.name}',
          translate: true,
          variables: authorModel.name,
        ),
      ));
    }

    /// DELETE ALL AUTHOR FLYERS EVERY WHERE THEN UPDATE BZ EVERYWHERE
    final List<FlyerModel> _flyers = await FlyerProtocols.fetchFlyers(
      context: context,
      flyersIDs: authorModel.flyersIDs,
    );

    final BzModel _updatedBzModel = await FlyerProtocols.wipeFlyers(
      context: context,
      bzModel: bzModel,
      showWaitDialog: false,
      updateBzEveryWhere: false,
      flyers: _flyers,
      isDeletingBz: false,
    );

    /// REMOVE AUTHOR MODEL FROM BZ MODEL
    final BzModel _bzWithoutAuthor = BzModel.removeAuthor(
      bzModel: _updatedBzModel,
      authorID: authorModel.userID,
    );

    /// UPDATE BZ ON FIREBASE
    await BzFireOps.updateBz(
        context: context,
        newBzModel: _bzWithoutAuthor,
        oldBzModel: bzModel,
        authorPicFile: null
    );


    /// SEND AUTHOR DELETION NOTES
    await NoteProtocols.sendAuthorDeletionNotes(
      context: context,
      bzModel: bzModel,
      deletedAuthor: authorModel,
      sendToUserAuthorExitNote: sendToUserAuthorExitNote,
    );

    if (showWaitDialog == true){
      WaitDialog.closeWaitDialog(context);
    }

    /// SHOW CONFIRMATION DIALOG
    if (showConfirmationDialog == true){
      await _showAuthorRemovalConfirmationDialog(
        context: context,
        bzModel: bzModel,
        deletedAuthor: authorModel,
      );
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _showDeleteAllAuthorFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_delete_all_flyers',
      translate: true,
    ),
    bodyVerse: Verse(
      text: '##${authorModel.flyersIDs.length} flyers published by ${authorModel.name} will be permanently deleted',
      translate: true,
      variables: [authorModel.flyersIDs.length, authorModel.name],
    ),
    height: 400,
    boolDialog: true,
    confirmButtonVerse: Verse(
      text: '##Delete All Flyers And Remove ${authorModel.name}',
      translate: true,
      variables: authorModel.name,
    ),
    child: Container(
      width: CenterDialog.getWidth(context),
      height: 200,
      color: Colorz.white10,
      alignment: Alignment.center,
      child: FlyersGrid(
        scrollController: ScrollController(),
        paginationFlyersIDs: authorModel.flyersIDs,
        scrollDirection: Axis.horizontal,
        gridWidth: CenterDialog.getWidth(context) - 10,
        gridHeight: 200,
        numberOfColumnsOrRows: 1,
      ),
    ),
  );

  return _result;
}
// -----------------------------------------------------------------------------

/// DELETE AUTHOR WHO HAS NO FLYERS

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _removeAuthorWhoHasNoFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
  @required bool showConfirmationDialog,
  @required bool showWaitDialog,
  @required bool sendToUserAuthorExitNote,
}) async {

  /// REMOVE AUTHOR MODEL FROM BZ MODEL
  await AuthorProtocols.removeFlyerlessAuthorProtocol(
    context: context,
    bzModel: bzModel,
    author: authorModel,
  );

  /// SEND AUTHOR DELETION NOTES
  await NoteProtocols.sendAuthorDeletionNotes(
    context: context,
    bzModel: bzModel,
    deletedAuthor: authorModel,
    sendToUserAuthorExitNote: sendToUserAuthorExitNote,
  );

  /// SHOW CONFIRMATION DIALOG
  if (showConfirmationDialog == true){
    await _showAuthorRemovalConfirmationDialog(
      context: context,
      bzModel: bzModel,
      deletedAuthor: authorModel,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _showAuthorRemovalConfirmationDialog({
  @required BuildContext context,
  @required BzModel bzModel,
  @required AuthorModel deletedAuthor,
}) async {

  unawaited(TopDialog.showTopDialog(
    context: context,
    firstVerse: Verse(
      text: '##${deletedAuthor.name} has been removed from the team of ${bzModel.name}',
      translate: true,
      variables: [deletedAuthor.name, bzModel.name]
    ),
    color: Colorz.green255,
    textColor: Colorz.white255,
  ));

}
// -----------------------------------------------------------------------------

/// EDIT AUTHOR

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditAuthor({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: AuthorEditorScreen(
      author: authorModel,
      bzModel: bzModel,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotEditAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse(
      text: '##You can not Edit ${authorModel.name}',
      translate: true,
      variables: authorModel.name,
    ),
    bodyVerse: Verse(
      text: '##Only ${authorModel.name} can edit his Author detail',
      translate: true,
      variables: authorModel.name,
    ),
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR ROLES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onChangeAuthorRole({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(
    context: context,
    invoker: '_onChangeAuthorRole',
  );

  await Nav.goToNewScreen(
    context: context,
    screen: AuthorRoleEditorScreen(
      authorModel: authorModel,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotChangeAuthorRoleDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      pseudo: 'You can not Change team member roles',
      text: 'phid_you_cant_change_team_roles',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'Only Account Admins can change the roles of other team members',
      text: 'phid_only_admins_change_roles',
      translate: true,
    ),
  );

}
// -----------------------------------------------------------------------------
