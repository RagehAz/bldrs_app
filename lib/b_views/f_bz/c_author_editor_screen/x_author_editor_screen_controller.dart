import 'dart:async';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
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

// ---------------------------------------
/// TESTED : WORKS PERFECT
void initializeAuthorEditorLocalVariables({
  @required AuthorModel oldAuthor,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required BzModel bzModel,
}){

  final AuthorModel _initialAuthor = oldAuthor.copyWith(
    pic: FileModel(url: oldAuthor.pic, fileName: AuthorModel.generateAuthorPicID(
      authorID: oldAuthor.userID,
      bzID: bzModel.id,
    )),
    contacts: ContactModel.initializeContactsForEditing(
      contacts: oldAuthor.contacts,
      countryID: bzModel.zone.countryID,
    ),
  );

  nameController.text = _initialAuthor.name;
  titleController.text = _initialAuthor.title;

  tempAuthor.value = _initialAuthor;

  ///   old and works
  // final AuthorModel _initialAuthor = AuthorModel.initializeModelForEditing(
  //   oldAuthor: oldAuthor,
  //   bzModel: bzModel,
  // );
  //
  // tempAuthor.value = _initialAuthor;
  //
  // nameController.text = tempAuthor.value.name;
  // titleController.text = tempAuthor.value.title;

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> prepareAuthorPicForEditing({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required bool mounted,
}) async {

  final AuthorModel _tempAuthor = await AuthorModel.initializeModelForEditing(
    oldAuthor: oldAuthor,
    bzModel: bzModel,
  );
  setNotifier(
      notifier: tempAuthor,
      mounted: mounted,
      value: _tempAuthor,
  );

  ///   old and works
  // final AuthorModel _tempAuthor = tempAuthor.value.copyWith(
  //   pic: await FileModel.completeModel(tempAuthor.value.pic),
  // );
  //
  // tempAuthor.value = _tempAuthor;

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// ---------------------------------------
Future<void> loadAuthorEditorSession({
  @required BuildContext context,
  @required bool mounted,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
}) async {

  final AuthorModel _lastSessionAuthor = await BzLDBOps.loadAuthorEditorSession(
    authorID: oldAuthor.userID,
  );

  if (_lastSessionAuthor != null){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: 'phid_load_last_session_data_q',
      bodyVerse: 'phid_want_to_load_last_session_q',
      boolDialog: true,
    );

    if (_continue == true){
      // -------------------------
      final AuthorModel _initialAuthor = await AuthorModel.initializeModelForEditing(
        oldAuthor: _lastSessionAuthor,
        bzModel: bzModel,
      );
      // -------------------------
      nameController.text = _initialAuthor.name;
      titleController.text = _initialAuthor.title;
      // -------------------------
      setNotifier(
          notifier: tempAuthor,
          mounted: mounted,
          value: _initialAuthor,
      );
      // -------------------------
    }

  }

}
// ---------------------------------------
Future<void> saveAuthorEditorSession({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required ValueNotifier<AuthorModel> lastTempAuthor,
  @required bool mounted,
}) async {

  AuthorModel newAuthor = AuthorModel.bakeEditorVariablesToUpload(
    bzModel: bzModel,
    oldAuthor: oldAuthor,
    tempAuthor: tempAuthor.value,
    titleController: titleController,
    nameController: nameController,
  );

  newAuthor = newAuthor.copyWith(
    pic: FileModel.bakeFileForLDB(newAuthor.pic),
  );

  blog('saveAuthorEditorSession : LISTENENNING AND CHECKING');

  if (AuthorModel.checkAuthorsAreIdentical(author1: newAuthor, author2: lastTempAuthor.value) == false){

    blog('saveAuthorEditorSession : SHOULD SAVE NOW');

    await BzLDBOps.saveAuthorEditorSession(
        authorModel: newAuthor,
    );

    setNotifier(
        notifier: lastTempAuthor,
        mounted: mounted,
        value: newAuthor,
    );

  }


}
// -----------------------------------------------------------------------------

/// AUTHOR PROFILE EDITOR

// ---------------------------------------
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
// ---------------------------------------
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
// -----------------------------------------------------------------------------

/// CONFIRMATION OPS

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmAuthorUpdates({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  'phid_confirm_edits',
    bodyVerse:  '##This will only edit your details as author in ${bzModel.name} '
        'business account, and will not impact your personal profile',
    boolDialog: true,
    confirmButtonVerse:  'phid_confirm',
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: '##Uploading new Author details',
    ));

    final AuthorModel _author = AuthorModel.bakeEditorVariablesToUpload(
      bzModel: bzModel,
      oldAuthor: oldAuthor,
      tempAuthor: tempAuthor.value,
      nameController: nameController,
      titleController: titleController,
    );

    await AuthorProtocols.updateAuthorProtocol(
      context: context,
      oldBzModel: bzModel,
      newAuthorModel: _author,
    );

    await BzLDBOps.deleteAuthorEditorSession(oldAuthor.userID);

    WaitDialog.closeWaitDialog(context);

    Nav.goBack(
      context: context,
      invoker: 'onConfirmAuthorUpdates',
    );
  }


}
// -----------------------------------------------------------------------------

/// AUTHOR ROLE EDITOR

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeAuthorRoleOps({
  @required BuildContext context,
  @required ValueNotifier<AuthorRole> tempRole,
  @required AuthorModel oldAuthor,
}) async {

  if (tempRole.value != oldAuthor.role){

    final String _role = AuthorModel.translateRole(
      context: context,
      role: tempRole.value,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  '##Change Author Role',
      bodyVerse:  '##This will set ${oldAuthor.name} as $_role',
      boolDialog: true,
    );

    if (_result == false){
      tempRole.value = oldAuthor.role;
    }

    else {

      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: '##Uploading new Author details',
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

      WaitDialog.closeWaitDialog(context);

      Nav.goBack(
        context: context,
        invoker: 'onChangeAuthorRoleOps',
      );

    }


  }


}
// ---------------------------------------
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
// ---------------------------------------
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
        titleVerse: '##Can Not Demote Account creator',
        bodyVerse: '##the Author Role of ${oldAuthor.name} can not be changed.',
      );

    }

  }

  /// IF AUTHOR IS NOT THE CREATOR
  else {

    /// WHEN CHOOSING CREATOR
    if (role == AuthorRole.creator){

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: '##Only one account creator is allowed',
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
