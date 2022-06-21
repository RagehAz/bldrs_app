import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/d_author_search/a_search_for_author_screen.dart';
import 'package:bldrs/b_views/x_screens/g_bz/c_author_editor/a_author_editor_screen.dart';
import 'package:bldrs/b_views/x_screens/g_bz/c_author_editor/b_author_role_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// NAVIGATION

// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToAddAuthorsScreen(BuildContext context) async {

  await Nav.goToNewScreen(
    context: context,
    screen: const SearchForAuthorScreen(),
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR OPTIONS

// -------------------------------
Future<void> onAuthorOptionsTap({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  final bool _itIsMine = superUserID() == authorModel.userID;
  final bool _iAmMaster = AuthorModel.checkUserIsMasterAuthor(userID: superUserID(), bzModel: bzModel);

  final bool _canChangeRoles = _iAmMaster;
  final bool _canEditAuthor = _itIsMine;
  final bool _canRemoveAuthor = _iAmMaster || _itIsMine;

  final List<Widget> _buttons = <Widget>[

    /// CHANGE ROLE
    BottomDialog.wideButton(
      context: context,
      verse: 'Change team role for ${authorModel.name}',
      icon: Iconz.bz,
      isDeactivated: !_canChangeRoles,
      onDeactivatedTap: () => _onShowCanNotChangeAuthorRoleDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onChangeAuthorRole(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      ),
    ),

    /// EDIT AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: 'Edit ${authorModel.name} Author details',
      icon: Iconz.gears,
      isDeactivated: !_canEditAuthor,
      onDeactivatedTap: () => _onShowCanNotEditAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onEditAuthor(
        context: context,
        bzModel: bzModel,
        authorModel: authorModel,
      ),
    ),

    /// REMOVE AUTHOR
    BottomDialog.wideButton(
      context: context,
      verse: 'Remove ${authorModel.name} from the team',
      icon: Iconz.xSmall,
      isDeactivated: !_canRemoveAuthor,
      onDeactivatedTap: () => _onShowCanNotRemoveAuthorDialog(
        context: context,
        authorModel: authorModel,
      ),
      onTap: () => _onDeleteAuthorFromActiveBzTeam(
        context: context,
        // bzModel: bzModel,
        authorModel: authorModel,
      ),
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

/// DELETE AUTHOR

// -------------------------------
Future<void> _onDeleteAuthorFromActiveBzTeam({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(context);

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Remove ${authorModel.name} ?',
    body: '${authorModel.name} and all his published flyers will be deleted as well',
    boolDialog: true,
  );

  if (_result == true){

    final bool _authorHasFlyers = AuthorModel.checkAuthorHasFlyers(
      author: authorModel,
    );

    /// REMOVE AUTHOR HAS FLYERS
    if (_authorHasFlyers == true){

      await _removeAuthorWhoHasFlyers(
        context: context,
        authorModel: authorModel,
      );

    }

    /// REMOVE AUTHOR HAS NO FLYERS
    else {

      await _removeAuthorWhoHasNoFlyers(
        context: context,
        authorModel: authorModel,
      );

    }

  }

}
// -------------------------------
Future<void> _onShowCanNotRemoveAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not remove ${authorModel.name}',
    body: 'Only Account Admins can remove other team members,\n'
        'however you can remove only yourself from this business account',
  );

}
// -------------------------------
///
Future<void> _removeAuthorWhoHasFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final bool _result = await _showDeleteAllAuthorFlyers(
    context: context,
    authorModel: authorModel,
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Removing ${authorModel.name}',
    ));

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
    );

    /// DELETE ALL AUTHOR FLYERS EVERY WHERE THEN UPDATE BZ EVERYWHERE
    final List<FlyerModel> _flyers = await FlyersProvider.proFetchFlyers(
      context: context,
      flyersIDs: authorModel.flyersIDs,
    );

    final BzModel _updatedBzModel = await BzProtocol.deleteMultipleBzFlyersProtocol(
      context: context,
      bzModel: _bzModel,
      showWaitDialog: false,
      updateBzEveryWhere: false,
      flyers: _flyers,
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
        oldBzModel: _bzModel,
        authorPicFile: null
    );

    /// SEND AUTHOR DELETION NOTES
    await _sendAuthorDeletionNotes(
      context: context,
      bzModel: _bzModel,
      deletedAuthor: authorModel,
    );

    WaitDialog.closeWaitDialog(context);

    /// SHOW CONFIRMATION DIALOG
    await _showAuthorRemovalConfirmationDialog(
      context: context,
      bzModel: _bzModel,
      deletedAuthor: authorModel,
    );

  }

}
// -------------------------------
Future<bool> _showDeleteAllAuthorFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete All Flyers',
    body: '${authorModel.flyersIDs.length} flyers published by ${authorModel.name} will be permanently deleted',
    height: 400,
    boolDialog: true,
    confirmButtonText: 'Delete All Flyers And Remove ${authorModel.name}',
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
// -------------------------------
Future<void> _removeAuthorWhoHasNoFlyers({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
    context: context,
    listen: false,
  );

  /// REMOVE AUTHOR MODEL FROM BZ MODEL
  final BzModel _updatedBzModel = BzModel.removeAuthor(
    bzModel: _bzModel,
    authorID: authorModel.userID,
  );

  /// UPDATE BZ ON FIREBASE
  await BzFireOps.updateBz(
      context: context,
      newBzModel: _updatedBzModel,
      oldBzModel: _bzModel,
      authorPicFile: null
  );

  /// SEND AUTHOR DELETION NOTES
  await _sendAuthorDeletionNotes(
    context: context,
    bzModel: _bzModel,
    deletedAuthor: authorModel,
  );

  /// SHOW CONFIRMATION DIALOG
  await _showAuthorRemovalConfirmationDialog(
    context: context,
    bzModel: _bzModel,
    deletedAuthor: authorModel,
  );


}
// -------------------------------
Future<void> _sendAuthorDeletionNotes({
  @required BuildContext context,
  @required BzModel bzModel,
  @required AuthorModel deletedAuthor,
}) async {

  /// NOTE TO BZ
  final NoteModel _noteToBz = NoteModel(
    id: 'x',
    senderID: deletedAuthor.userID,
    senderImageURL: deletedAuthor.pic,
    noteSenderType: NoteSenderType.user,
    receiverID: bzModel.id,
    receiverType: NoteReceiverType.bz,
    title: '${deletedAuthor.name} has left the team',
    body: '${deletedAuthor.name} is no longer part of ${bzModel.name} team',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: true,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  await NoteFireOps.createNote(
    context: context,
    noteModel: _noteToBz,
  );

  /// NOTE TO DELETED AUTHOR
  final NoteModel _noteToUser = NoteModel(
    id: 'x',
    senderID: bzModel.id,
    senderImageURL: bzModel.logo,
    noteSenderType: NoteSenderType.bz,
    receiverID: deletedAuthor.userID,
    receiverType: NoteReceiverType.user,
    title: 'You have exited from ${bzModel.name} account',
    body: 'You are no longer part of ${bzModel.name} team',
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: true,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  await NoteFireOps.createNote(
    context: context,
    noteModel: _noteToUser,
  );

}
// -------------------------------
Future<void> _showAuthorRemovalConfirmationDialog({
  @required BuildContext context,
  @required BzModel bzModel,
  @required AuthorModel deletedAuthor,
}) async {

  unawaited(TopDialog.showTopDialog(
    context: context,
    firstLine: '${deletedAuthor.name} has been removed from the team of ${bzModel.name}',
    color: Colorz.green255,
    textColor: Colorz.white255,
  ));

}
// -----------------------------------------------------------------------------

/// EDIT AUTHOR

// -------------------------------
Future<void> _onEditAuthor({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: const AuthorEditorScreen(),
  );

}
// -------------------------------
Future<void> _onShowCanNotEditAuthorDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not Edit ${authorModel.name}',
    body: 'Only ${authorModel.name} can edit his Author detail',
  );

}
// -----------------------------------------------------------------------------

/// AUTHOR ROLES

// -------------------------------
Future<void> _onChangeAuthorRole({
  @required BuildContext context,
  @required AuthorModel authorModel,
  @required BzModel bzModel,
}) async {

  /// CLOSE BOTTOM DIALOG
  Nav.goBack(context);

  await Nav.goToNewScreen(
    context: context,
    screen: AuthorRoleEditorScreen(
      authorModel: authorModel,
    ),
  );

}
// -------------------------------
Future<void> _onShowCanNotChangeAuthorRoleDialog({
  @required BuildContext context,
  @required AuthorModel authorModel,
}) async {

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'You can not Change team member roles',
    body: 'Only Account Admins can change the roles of other team members',
  );

}
// -----------------------------------------------------------------------------
