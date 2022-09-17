import 'dart:async';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// AUTHOR EDITOR INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeAuthorEditorLocalVariables({
  @required AuthorModel oldAuthor,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required BzModel bzModel,
}){

  final AuthorModel _initialAuthor = oldAuthor.copyWith(
      pic: FileModel.initializePicForEditing(
        pic: oldAuthor.pic,
        fileName: AuthorModel.generateAuthorPicID(
          authorID: oldAuthor.userID,
          bzID: bzModel.id,
        ),
      )
  );

  tempAuthor.value = _initialAuthor;

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> prepareAuthorPicForEditing({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required bool mounted,
}) async {

  final AuthorModel _tempAuthor = await AuthorModel.prepareAuthorForEditing(
    oldAuthor: oldAuthor,
    bzModel: bzModel,
  );

  setNotifier(
    notifier: tempAuthor,
    mounted: mounted,
    value: _tempAuthor,
  );

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
Future<void> loadAuthorEditorSession({
  @required BuildContext context,
  @required bool mounted,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
}) async {

  final AuthorModel _lastSessionAuthor = await BzLDBOps.loadAuthorEditorSession(
    authorID: oldAuthor.userID,
  );

  if (_lastSessionAuthor != null){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_load_last_session_data_q',
        translate: true,
      ),
      // bodyVerse: const Verse(
      //   text: 'phid_want_to_load_last_session_q',
      //   translate: true,
      // ),
      boolDialog: true,
    );

    if (_continue == true){
      // -------------------------
      final AuthorModel _initialAuthor = await AuthorModel.prepareAuthorForEditing(
        oldAuthor: _lastSessionAuthor,
        bzModel: bzModel,
      );
      // -------------------------
      await Nav.replaceScreen(
        context: context,
        screen: AuthorEditorScreen(
          bzModel: bzModel,
          author: _initialAuthor,
          checkLastSession: false,
          validateOnStartup: true,
        ),
      );
      // -------------------------
    }

  }

}
// --------------------
Future<void> saveAuthorEditorSession({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required ValueNotifier<AuthorModel> lastTempAuthor,
  @required bool mounted,
}) async {

  AuthorModel newAuthor = AuthorModel.bakeEditorVariablesToUpload(
    bzModel: bzModel,
    oldAuthor: oldAuthor,
    tempAuthor: tempAuthor.value,
  );

  newAuthor = newAuthor.copyWith(
    pic: FileModel.bakeFileForLDB(newAuthor.pic),
  );

  final bool authorHasChanged = AuthorModel.checkAuthorsAreIdentical(
    author1: newAuthor,
    author2: lastTempAuthor.value,
  ) == false;

  if (authorHasChanged == true){

    await BzLDBOps.saveAuthorEditorSession(
      authorModel: newAuthor,
    );

    // setNotifier(
    //   notifier: lastTempAuthor,
    //   mounted: mounted,
    //   value: newAuthor,
    // );

  }

}
// -----------------------------------------------------------------------------

/// AUTHOR PROFILE EDITOR

// --------------------
/// TESTED : WORKS PERFECT
Future<void> takeAuthorImage({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> author,
  @required ImagePickerType imagePickerType,
  @required ValueNotifier<bool> canPickImage,
}) async {

  if (canPickImage.value == true) {

    canPickImage.value = false;

    FileModel _imageFileModel;

    if(imagePickerType == ImagePickerType.galleryImage){
      _imageFileModel = await Imagers.pickAndCropSingleImage(
        context: context,
        cropAfterPick: true,
        isFlyerRatio: false,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }
    else if (imagePickerType == ImagePickerType.cameraImage){
      _imageFileModel = await Imagers.shootAndCropCameraImage(
        context: context,
        cropAfterPick: true,
        isFlyerRatio: false,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_imageFileModel == null) {
      canPickImage.value = true;
    }

    /// IF PICKED AN IMAGE
    else {
      author.value = author.value.copyWith(
        pic: _imageFileModel,
      );

      canPickImage.value = true;
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onDeleteAuthorImage({
  @required ValueNotifier<AuthorModel> author,
}){

  author.value = AuthorModel(
    pic: null,
    title: author.value.title,
    role: author.value.role,
    contacts: author.value.contacts,
    userID: author.value.userID,
    name: author.value.name,
    flyersIDs: author.value.flyersIDs,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorNameChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required String text,
}){

  tempAuthor.value = tempAuthor.value.copyWith(
    name: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorTitleChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required String text,
}){
  tempAuthor.value = tempAuthor.value.copyWith(
    title: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorContactChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required ContactType contactType,
  @required String value,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: tempAuthor.value.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  tempAuthor.value = tempAuthor.value.copyWith(
    contacts: _contacts,
  );

}
// -----------------------------------------------------------------------------

/// CONFIRMATION OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmAuthorUpdates({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_confirm_edits',
      translate: true,
    ),
    bodyVerse: Verse(
      text: '##This will only edit your details as author in ${bzModel.name} '
          'business account, and will not impact your personal profile',
      translate: true,
      variables: bzModel.name,
    ),
    boolDialog: true,
    confirmButtonVerse: const Verse(
      text: 'phid_confirm',
      translate: true,
    ),
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: const Verse(
        text: 'phid_updating_author_profile',
        translate: true,
      ),
    ));

    final AuthorModel _author = AuthorModel.bakeEditorVariablesToUpload(
      bzModel: bzModel,
      oldAuthor: oldAuthor,
      tempAuthor: tempAuthor.value,
    );

    await AuthorProtocols.updateAuthorProtocol(
      context: context,
      oldBzModel: bzModel,
      newAuthorModel: _author,
    );

    await BzLDBOps.deleteAuthorEditorSession(oldAuthor.userID);

    await WaitDialog.closeWaitDialog(context);

    await Nav.goBack(
      context: context,
      invoker: 'onConfirmAuthorUpdates',
    );
  }

}
// -----------------------------------------------------------------------------

/// AUTHOR ROLE EDITOR

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAuthorRoleOps({
  @required BuildContext context,
  @required ValueNotifier<AuthorRole> tempRole,
  @required AuthorModel oldAuthor,
}) async {

  if (tempRole.value != oldAuthor.role){

    final String _role = AuthorModel.getAuthorRolePhid(
      context: context,
      role: tempRole.value,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_confirm_author_role',
        translate: true,
      ),
      bodyVerse: Verse(
        text: '##This will set ${oldAuthor.name} as $_role',
        translate: true,
        variables: [oldAuthor.name, _role]
      ),
      boolDialog: true,
    );

    if (_result == false){
      tempRole.value = oldAuthor.role;
    }

    else {

      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: const Verse(
          text: 'phid_updating_author_profile',
          translate: true,
        ),
      ));

      final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: false,
      );

      final AuthorModel _author = oldAuthor.copyWith(
        role: tempRole.value,
      );

      await Future.wait(<Future>[

        AuthorProtocols.updateAuthorProtocol(
          context: context,
          oldBzModel: _bzModel,
          newAuthorModel: _author,
        ),

        NoteProtocols.sendAuthorRoleChangeNote(
          context: context,
          bzID: _bzModel.id,
          author: _author,
        )

      ]);

      await WaitDialog.closeWaitDialog(context);

      await Nav.goBack(
        context: context,
        invoker: 'onChangeAuthorRoleOps',
      );

    }


  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> setAuthorRole({
  @required BuildContext context,
  @required AuthorRole selectedRole,
  @required ValueNotifier<AuthorRole> tempRole,
  @required AuthorModel oldAuthor,
}) async {

  final bool _canChangeRole = await _checkCanChangeRole(
    context: context,
    role: selectedRole,
    oldAuthor: oldAuthor,
  );

  if (_canChangeRole == true){

    tempRole.value = selectedRole;

    await onChangeAuthorRoleOps(
      context: context,
      tempRole: tempRole,
      oldAuthor: oldAuthor,

    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _checkCanChangeRole({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required AuthorRole role,
}) async {
  bool _canChange = false;

  /// IF AUTHOR IS ALREADY THE CREATOR
  if (oldAuthor.role == AuthorRole.creator){

    /// WHEN CHOOSING SOMETHING OTHER THAN CREATOR
    if (role != AuthorRole.creator){

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          pseudo: 'Can Not Demote Account creator',
          text: 'phid_cant_demote_creator',
          translate: true,
        ),
        bodyVerse: Verse(
          text: '##the Author Role of ${oldAuthor.name} can not be changed.',
          translate: true,
          variables: oldAuthor.name,
        ),
      );

    }

  }

  /// IF AUTHOR IS NOT THE CREATOR
  else {

    /// WHEN CHOOSING CREATOR
    if (role == AuthorRole.creator){

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          pseudo: 'Only one account creator is allowed',
          text: 'phid_only_one_creator_allowed',
          translate: true,
        ),
      );

    }

    /// WHEN CHOOSING OTHER THAN CREATOR
    else {
      _canChange = true;
    }

  }

  return _canChange;
}
// -----------------------------------------------------------------------------
