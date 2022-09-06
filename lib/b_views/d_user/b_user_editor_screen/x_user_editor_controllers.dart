import 'dart:async';

import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x5_user_settings_page_controllers.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/a_user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeUserEditorLocalVariables({
  @required BuildContext context,
  @required UserModel oldUser,
  @required ValueNotifier<UserModel> tempUser,
}){

  final UserModel _initialModel = oldUser.copyWith(
    pic: FileModel.initializePicForEditing(
      pic: oldUser.pic,
      fileName: oldUser.id,
    ),
  );

  tempUser.value = _initialModel;

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> prepareUserForEditing({
  @required BuildContext context,
  @required ValueNotifier<UserModel> tempUser,
  @required UserModel oldUser,
  @required bool mounted,
}) async {

  final UserModel _userModel = await UserModel.prepareUserForEditing(
    context: context,
    oldUser: oldUser,
  );

  setNotifier(
    notifier: tempUser,
    mounted: mounted,
    value: _userModel,
  );

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadUserEditorLastSession({
  @required BuildContext context,
  @required UserModel oldUser,
  @required bool reAuthBeforeConfirm,
  @required bool canGoBack,
  @required Function onFinish,
}) async {

  final UserModel _lastSessionUser = await UserLDBOps.loadEditorSession(
    userID: oldUser.id,
  );

  if (_lastSessionUser != null){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: 'phid_load_last_session_data_q',
      bodyVerse: 'phid_want_to_load_last_session_q',
      boolDialog: true,
    );

    if (_continue == true){

      final UserModel _user = await UserModel.prepareUserForEditing(
        context: context,
        oldUser: _lastSessionUser,
      );

      await Nav.replaceScreen(
        context: context,
        screen: EditProfileScreen(
          reAuthBeforeConfirm: reAuthBeforeConfirm,
          userModel: _user,
          canGoBack: canGoBack,
          onFinish: onFinish,
          checkLastSession: false,
          validateOnStartup: true,
        ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> saveUserEditorSession({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required ValueNotifier<UserModel> tempUser,
  @required ValueNotifier<UserModel> lastTempUser,
  @required bool mounted,
}) async {

  UserModel newUserModel = UserModel.bakeEditorVariablesToUpload(
    context: context,
    oldUser: oldUserModel,
    tempUser: tempUser.value,
  );

  /// USER PICTURE
  newUserModel = newUserModel.copyWith(
    pic: FileModel.bakeFileForLDB(newUserModel.pic),
  );

  final bool _userHasChanged = UserModel.checkUsersAreIdentical(
    user1: newUserModel,
    user2: lastTempUser.value,
  ) == false;

  if (_userHasChanged == true){

    await UserLDBOps.saveEditorSession(
        userModel: newUserModel
    );

    // setNotifier(
    //     notifier: lastTempUser,
    //     mounted: mounted,
    //     value: newUserModel,
    // );

  }

}
// -----------------------------------------------------------------------------

/// EDITORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> takeUserPicture({
  @required BuildContext context,
  @required ValueNotifier<bool> canPickImage,
  @required ValueNotifier<UserModel> userNotifier,
  @required ImagePickerType imagePickerType,
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
      blog('takeUserPicture : did not take user picture');
      // picture.value = null;
      canPickImage.value = true;
    }

    /// IF PICKED AN IMAGE
    else {
      blog('takeUserPicture : we got the pic in : ${_imageFileModel?.file}');
      userNotifier.value = userNotifier.value.copyWith(
        pic: _imageFileModel,
      );

      canPickImage.value = true;
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<UserModel> tempUser,
}){
  tempUser.value = tempUser.value.copyWith(
    gender: selectedGender,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
void onUserNameChanged({
  @required ValueNotifier<UserModel> tempUser,
  @required String text,
}){

  tempUser.value = tempUser.value.copyWith(
    name: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserJobTitleChanged({
  @required ValueNotifier<UserModel> tempUser,
  @required String text,
}){

  tempUser.value = tempUser.value.copyWith(
    title: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserCompanyNameChanged({
  @required ValueNotifier<UserModel> tempUser,
  @required String text,
}){
  tempUser.value = tempUser.value.copyWith(
    company: text,
  );
}

// --------------------
/// TESTED : WORKS PERFECT
void onUserZoneChanged({
  @required ZoneModel selectedZone,
  @required ValueNotifier<UserModel> tempUser,
}) {

  final UserModel _updated = tempUser.value.copyWith(
    zone: selectedZone,
  );

  tempUser.value = _updated;

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserContactChanged({
  @required ValueNotifier<UserModel> tempUser,
  @required ContactType contactType,
  @required String value,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: tempUser.value.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  tempUser.value = tempUser.value.copyWith(
    contacts: _contacts,
  );

}
// --------------------
/// PLAN : CHANGE USER POSITION
/*
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
   */
// -----------------------------------------------------------------------------

/// CONFIRMATION OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> confirmEdits({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required UserModel oldUserModel,
  @required ValueNotifier<UserModel> tempUser,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
  @required bool forceReAuthentication,
}) async {

  final UserModel newUserModel = UserModel.bakeEditorVariablesToUpload(
    context: context,
    oldUser: oldUserModel,
    tempUser: tempUser.value,
  );

  final bool _canContinue = Formers.validateForm(formKey);

  /// A - IF ANY OF REQUIRED FIELDS IS NOT VALID
  if (_canContinue == false){
    await Formers.showUserMissingFieldsDialog(
        context: context,
        userModel: newUserModel
    );

  }

  /// A - IF ALL REQUIRED FIELDS ARE VALID
  else {

    bool _continueOps = true;

    final bool _shouldReAuthenticate =
        forceReAuthentication == true
            &&
            ContactModel.checkEmailChanged(
              oldContacts: oldUserModel.contacts,
              newContacts: newUserModel.contacts,
            ) == true;

    if (_shouldReAuthenticate == true){
      _continueOps = await reAuthenticateUser(
        context: context,
        dialogTitle: 'User Check',
        dialogBody: 'Please add your password to be able to continue',
        confirmButtonText: 'Continue',
      );
    }
    else {
      _continueOps = await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: '',
        bodyVerse: '##Are you sure you want to continue ?',
        boolDialog: true,
      );
    }

    if (_continueOps == true){

      final UserModel _uploadedUserModel = await _updateUserModel(
        context: context,
        newUserModel: newUserModel,
        loading: loading,
        oldUserModel: oldUserModel,
      );

      if (_uploadedUserModel != null){

        final AuthModel _originalAuthModel = await AuthLDBOps.readAuthModel();
        final AuthModel _authModel = _originalAuthModel.copyWith(
          userModel: _uploadedUserModel,
        );

        await setUserAndAuthModelsAndCompleteUserZoneLocally(
          context: context,
          authModel: _authModel,
          notify: true,
        );

      }

      blog('confirmEdits : finished updating the user Model');

      await UserLDBOps.wipeEditorSession(_uploadedUserModel.id);

      onFinish();

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<UserModel> _updateUserModel({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required UserModel newUserModel,
  @required ValueNotifier<bool> loading,
}) async {

  loading.value = true;
  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: '##Updating Profile',
  ));

  /// start create user ops
  final UserModel _uploadedUserModel = await UserFireOps.updateUser(
    context: context,
    oldUserModel: oldUserModel,
    newUserModel: newUserModel,
  );

  loading.value = false;
  WaitDialog.closeWaitDialog(context);

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  '##Great !',
    bodyVerse:  '##Successfully updated your user account',
  );

  return _uploadedUserModel;
}
// -----------------------------------------------------------------------------
