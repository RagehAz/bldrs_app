import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/drawing/dot_separator.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/b_author_role_editor_screen.dart';
import 'package:bldrs/b_views/f_bz/d_author_search_screen/a_author_search_screen.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/authorship_protocols/d_authorship_responding.dart';
import 'package:bldrs/c_protocols/authorship_protocols/f_new_authorship_exit.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
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

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToAddAuthorsScreen() async {

  await BldrsNav.goToNewScreen(
    screen: const AuthorSearchScreen(),
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAuthorOptionsTap({
  required BuildContext context,
  required AuthorModel? authorModel,
  required BzModel? oldBz,
}) async {

  final bool _itIsMine = Authing.getUserID() == authorModel?.userID;

  final AuthorModel? _myAuthorModel = AuthorModel.getAuthorFromAuthorsByID(
      authors: oldBz?.authors,
      authorID: Authing.getUserID(),
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

  blog('it is me : $_itIsMine : _canRemoveAuthor : $_canRemoveAuthor');

  final String _authorName = authorModel?.name ?? '...';

  final List<Widget> _buttons = <Widget>[

    /// CHANGE ROLE
    BottomDialog.wideButton(
      verse: const Verse(
        id: 'phid_change_team_role',
        translate: true,
      ),
      icon: Iconz.bz,
      isDisabled: !_canChangeRoles,
      onDisabledTap: () => _onShowCanNotChangeAuthorRoleDialog(
        authorModel: authorModel,
      ),
      onTap: () async {

        /// TO CLOSE BOTTOM DIALOG
        await Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Change team role for',
        );

        await _onChangeAuthorRole(
          bzModel: oldBz,
          authorModel: authorModel,
        );

      },
    ),

    /// EDIT AUTHOR
    BottomDialog.wideButton(
      verse: const Verse(
        id: 'phid_edit_author_details',
        translate: true,
      ),
      icon: Iconz.gears,
      isDisabled: !_canEditAuthor,
      onDisabledTap: () => _onShowCanNotEditAuthorDialog(
        authorModel: authorModel,
      ),
      onTap: () async {

        /// TO CLOSE BOTTOM DIALOG
        await Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Edit $_authorName Author details',
        );

        final BzModel? _newBz = await AuthorshipRespondingProtocols.goToAuthorEditor(
          author: authorModel,
          bzID: oldBz?.id,
        );

        if (_newBz != null){

          HomeProvider.proSetActiveBzModel(
              bzModel: _newBz,
              context: context,
              notify: true,
          );

          // await BldrsNav.goToMyBzScreen(
          //   bzID: _newBz.id,
          //   replaceCurrentScreen: true,
          //   initialTab: BzTab.team,
          // );

        }

      },
    ),

    /// REMOVE AUTHOR
    BottomDialog.wideButton(
      verse: const Verse(
        id: 'phid_remove_author_from_the_team',
        translate: true,
      ),
      icon: Iconz.xSmall,
      isDisabled: _canRemoveAuthor == false,
      onDisabledTap: () => _onShowCanNotRemoveAuthorDialog(
        authorModel: authorModel,
      ),
      onTap: () async {

        /// CLOSE BOTTOM DIALOG
        await Nav.goBack(
          context: context,
          invoker: 'onAuthorOptionsTap.Remove $_authorName from the team',
        );

        await onDeleteAuthorFromBz(
          oldBz: oldBz,
          authorModel: authorModel,
          showConfirmationDialog: true,
          showWaitingDialog: true,
          sendToUserAuthorExitNote: true,
        );

      },
    ),

    const DotSeparator(),

  ];

  await BottomDialog.showButtonsBottomDialog(
      numberOfWidgets: _buttons.length,
      builder: (_, __){
        return _buttons;
      }
  );

}
// -----------------------------------------------------------------------------

/// PRE DELETE AUTHOR

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteAuthorFromBz({
  required AuthorModel? authorModel,
  required BzModel? oldBz,
  required bool showConfirmationDialog,
  required bool showWaitingDialog,
  required bool sendToUserAuthorExitNote,
}) async {

  if (authorModel?.userID == Authing.getUserID()){
    await NewAuthorshipExit.onRemoveMySelf(
      authorModel: authorModel,
      bzModel: oldBz,
      showConfirmDialog: true,
    );
  }

  else {
    await NewAuthorshipExit.onRemoveOtherAuthor(
        authorModel: authorModel,
        bzModel: oldBz,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotRemoveAuthorDialog({
  required AuthorModel? authorModel,
}) async {

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: Verse(
      id: '${getWord('phid_you_cant_remove')} ${authorModel?.name}',
      translate: false,
    ),
    // bodyVerse: const Verse(
    //   text: 'phid_only_admins_can_remove_other_authors',
    //   translate: true,
    // ),
  );

}
// -----------------------------------------------------------------------------

/// EDIT AUTHOR

// --------------------
/// DEPRECATED
/*
/// TESTED : WORKS PERFECT
Future<void> onGoToAuthorEditorScreen({
  required AuthorModel? authorModel,
  required BzModel? bzModel,
  required bool navAfterDone,
}) async {

  final BzModel? _newBz = await Nav.goToNewScreen(
    context: getMainContext(),
    screen: AuthorEditorScreen(
      author: authorModel,
      bzModel: bzModel,
    ),
  );

  if (_newBz != null && navAfterDone == true){
    await BldrsNav.goToMyBzScreen(
      bzID: _newBz.id,
      replaceCurrentScreen: true,
      initialTab: BzTab.team,
    );
  }

}
 */
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotEditAuthorDialog({
  required AuthorModel? authorModel,
}) async {

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: Verse(
      id: '${getWord('phid_you_cant_edit')}\n${authorModel?.name}',
      translate: false,
    ),
    bodyVerse: Verse(
      id: '${authorModel?.name} ${getWord('phid_is_only_who_can_edit_his_account')}',
      translate: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR ROLES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onChangeAuthorRole({
  required AuthorModel? authorModel,
  required BzModel? bzModel,
}) async {

  await BldrsNav.goToNewScreen(
    screen: AuthorRoleEditorScreen(
      authorModel: authorModel,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onShowCanNotChangeAuthorRoleDialog({
  required AuthorModel? authorModel,
}) async {

  await BldrsCenterDialog.showCenterDialog(
    titleVerse: const Verse(
      id: 'phid_you_cant_change_team_roles',
      translate: true,
    ),
    // bodyVerse: const Verse(
    //   pseudo: 'Only Account Admins can change the roles of other team members',
    //   text: 'phid_only_admins_change_roles',
    //   translate: true,
    // ),
  );

}
// -----------------------------------------------------------------------------

/// SENDING AUTHORSHIP INVITATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSendAuthorshipInvitation({
  required UserModel selectedUser,
  required BzModel? bzModel,
}) async {

  final bool _canInviteUser = PendingAuthor.checkCanInviteUser(
    bzModel: bzModel,
    userID: selectedUser.id,
  );

  /// USER CAN BE INVITED
  if (_canInviteUser == true){

    final String _body =  '${selectedUser.name}\n'
                          '${getWord('phid_will_be_invited_to_join')}\n'
                          '${bzModel?.name}';

    final bool _result = await Dialogs.userDialog(
      titleVerse: const Verse(
        id: 'phid_send_invitation_?',
        translate: true,
      ),
      bodyVerse: Verse(
        id: _body,
        translate: false,
      ),
      userModel: selectedUser,
    );


    if (_result == true){

      WaitDialog.showUnawaitedWaitDialog();

      await AuthorshipProtocols.sendRequest(
        oldBz: bzModel,
        userModelToSendTo: selectedUser,
      );

      await WaitDialog.closeWaitDialog();

      unawaited(TopDialog.showTopDialog(
        firstVerse: const Verse(
          id: 'phid_invitation_sent',
          translate: true,
        ),
        secondVerse: Verse(
          id: 'phid_authorship_invitation_is_sent',
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
      authors: bzModel?.authors,
      userID: selectedUser.id,
    );

    final String _body = _isAuthor == true ? 'phid_user_is_author_already' : 'phid_user_is_pending_author';

    await Dialogs.userDialog(
      titleVerse: const Verse(
        id: 'phid_can_not_invite_user',
        translate: true,
      ),
      bodyVerse: Verse(
        id: _body,
        translate: true,
      ),
      userModel: selectedUser,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelSentAuthorshipInvitation({
  required BzModel? bzModel,
  required String? userID,
}) async {

  blog('onCancelSentAuthorshipInvitation : START');

  if (bzModel != null && userID != null){

    final UserModel? _receiverModel = await UserProtocols.fetch(
      userID: userID,
    );

    final String _body =  '${_receiverModel?.name}\n'
                          '${getWord('phid_will_be_notified')}';

    final bool _result = await BldrsCenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_cancel_invitation_?',
        translate: true,
      ),
      bodyVerse: Verse(
        id: _body,
        translate: true,
      ),
      boolDialog: true,
      confirmButtonVerse: const Verse(
        id: 'phid_yes',
        translate: true,
      ),
      invertButtons: true,
    );

    if (_result == true){

      await AuthorshipProtocols.cancelRequest(
        bzModel: bzModel,
        pendingUserID: userID,
      );

      await TopDialog.showTopDialog(
        firstVerse: const Verse(
          id: 'phid_invitation_is_cancelled',
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
