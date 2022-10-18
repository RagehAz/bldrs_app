import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/author/author_model.dart';
import 'package:bldrs/a_models/b_bz/author/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/b_author_role_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/a_author_search_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/z_note_events.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
        await Nav.goBack(
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
        await Nav.goBack(
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
      onTap: () async {

        /// CLOSE BOTTOM DIALOG
        await Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Remove $_authorName from the team',
        );

        await onDeleteAuthorFromBz(
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
      builder: (_){
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
    await NoteEvent.sendAuthorDeletionNotes(
      context: context,
      bzModel: bzModel,
      deletedAuthor: authorModel,
      sendToUserAuthorExitNote: sendToUserAuthorExitNote,
    );

    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog(context);
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
        heroPath: 'showDeleteAllAuthorFlyersGrid',
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
  await AuthorshipProtocols.removeFlyerlessAuthor(
    context: context,
    bzModel: bzModel,
    author: authorModel,
  );

  /// SEND AUTHOR DELETION NOTES
  await NoteEvent.sendAuthorDeletionNotes(
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
  await Nav.goBack(
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

/// SENDING AUTHORSHIP INVITATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSendAuthorshipInvitation({
  @required BuildContext context,
  @required UserModel selectedUser,
  @required BzModel bzModel,
}) async {

  final bool _canInviteUser = PendingAuthor.checkCanInviteUser(
    bzModel: bzModel,
    userID: selectedUser.id,
  );

  /// USER CAN BE INVITED
  if (_canInviteUser == true){

    final bool _result = await Dialogs.userDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_send_invitation_?',
        translate: true,
      ),
      bodyVerse: Verse(
          text: '##confirm sending invitation to ${selectedUser.name} to become an author of ${bzModel.name} account',
          translate: true,
          variables: [selectedUser.name, bzModel.name]
      ),
      userModel: selectedUser,
    );

    if (_result == true){

      await AuthorshipProtocols.sendRequest(
        context: context,
        bzModel: bzModel,
        userModelToSendTo: selectedUser,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          text: 'phid_invitation_sent',
          translate: true,
        ),
        secondVerse: Verse(
          text: '##Account authorship invitation has been sent to ${selectedUser.name} successfully',
          translate: true,
          variables: selectedUser.name,
        ),
        color: Colorz.green255,
        textColor: Colorz.white255,
      ));

    }

  }

  /// USER IS ALREADY AN AUTHOR OR PENDING AUTHOR
  else {

    final bool _isAuthor = AuthorModel.checkAuthorsContainUserID(
      authors: bzModel.authors,
      userID: selectedUser.id,
    );

    final String _body = _isAuthor == true ? 'phid_user_is_author_already' : 'phid_user_is_pending_author';

    await Dialogs.userDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_can_not_invite_user',
        translate: true,
      ),
      bodyVerse: Verse(
        text: _body,
        translate: true,
      ),
      userModel: selectedUser,
    );

  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSentAuthorshipInvitation({
  @required BuildContext context,
  @required BzModel bzModel,
  @required String userID,
}) async {

  blog('onCancelSentAuthorshipInvitation : START');

  if (bzModel != null && userID != null){

    final UserModel _receiverModel = await UserProtocols.fetchUser(
      context: context,
      userID: userID,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_cancel_invitation_?',
        translate: true,
      ),
      bodyVerse: Verse(
        text: '##${_receiverModel.name} will be notified with cancelling this invitation',
        translate: true,
        variables: _receiverModel.name,
      ),
      boolDialog: true,
      confirmButtonVerse: const Verse(
        text: 'phid_yes',
        translate: true,
      ),
    );

    if (_result == true){

      await AuthorshipProtocols.cancelRequest(
        context: context,
        bzModel: bzModel,
        pendingUserID: userID,
      );

      await TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          pseudo: 'Invitation request has been cancelled',
          text: 'phid_invitation_is_cancelled',
          translate: true,
        ),
        color: Colorz.green255,
        textColor: Colorz.white255,
      );

    }

  }

  blog('onCancelSentAuthorshipInvitation : END');

}
// -----------------------------------------------------------------------------
