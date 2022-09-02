import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x5_user_settings_page_controllers.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// ---------------------------------------
/// TESTED : WORKS PERFECT
void initializeUserEditorLocalVariables({
  @required BuildContext context,
  @required UserModel oldUser,
  @required ValueNotifier<UserModel> tempUser,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required TextEditingController companyController,
}){

  final UserModel _initialModel = UserModel.initializeModelForEditing(
    context: context,
    oldUser: oldUser,
  );

  tempUser.value = _initialModel;

  nameController.text      = _initialModel.name;
  companyController.text   = _initialModel.company;
  titleController.text     = _initialModel.title;

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> prepareUserZoneAndPicForEditing({
  @required BuildContext context,
  @required ValueNotifier<UserModel> tempUser,
}) async {

  UserModel _userModel = tempUser.value.copyWith(
    pic: await FileModel.completeModel(tempUser.value.pic),
  );

  if (_userModel.zone == null || _userModel.zone.countryID == null){

    _userModel = _userModel.copyWith(
      zone: await ZoneFireOps.superGetZoneByIP(context),
    );

  }


}
// -----------------------------------------------------------------------------

/// LAST SESSION

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> loadUserEditorLastSession({
  @required BuildContext context,
  @required UserModel oldUser,
  @required ValueNotifier<UserModel> tempUser,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required TextEditingController companyController,
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

      final UserModel _initialModel = UserModel.initializeModelForEditing(
        context: context,
        oldUser: _lastSessionUser,
      );

      nameController.text      = _initialModel.name;
      companyController.text   = _initialModel.company;
      titleController.text     = _initialModel.title;

      final FileModel _pic = await FileModel.initializePicForEditing(
        pic: _lastSessionUser.pic,
        fileName: tempUser.value.id,
      );
      final ZoneModel _zone = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _lastSessionUser.zone,
      );

      tempUser.value = _initialModel.copyWith(
        pic: _pic,
        zone: _zone,
      );

    }

  }

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> saveUserEditorSession({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required ValueNotifier<UserModel> tempUser,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required TextEditingController companyController,
}) async {

  UserModel newUserModel = UserModel.bakeEditorVariablesToUpload(
    context: context,
    oldUser: oldUserModel,
    tempUser: tempUser.value,
    titleController: titleController,
    nameController: nameController,
    companyController: companyController,
  );

  /// USER PICTURE
  newUserModel = newUserModel.copyWith(
    pic: FileModel.bakeFileForLDB(newUserModel.pic),
  );

  await UserLDBOps.saveEditorSession(
      userModel: newUserModel
  );

  // await TopDialog.showSuccessDialog(context: context, firstLine: 'Session Saved');
}
// -----------------------------------------------------------------------------

/// EDITORS

// ---------------------------------------
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
// ---------------------------------------
/// TESTED : WORKS PERFECT
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<UserModel> userNotifier,
}){
  userNotifier.value = userNotifier.value.copyWith(
    gender: selectedGender,
  );
}
// ---------------------------------------
/// TESTED : WORKS PERFECT
void onUserZoneChanged({
  @required ZoneModel selectedZone,
  @required ValueNotifier<UserModel> userNotifier,
}) {

  final UserModel _updated = userNotifier.value.copyWith(
    zone: selectedZone,
  );

  userNotifier.value = _updated;

}
// ----------------------------------------
/// PLAN : CHANGE USER POSITION
/*
  // void _changePosition(GeoPoint geoPoint){
  //   setState(() => _currentPosition = geoPoint );
  // }
   */
// -----------------------------------------------------------------------------

/// CONFIRMATION OPS

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> confirmEdits({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required UserModel oldUserModel,
  @required ValueNotifier<UserModel> tempUser,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
  @required bool forceReAuthentication,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required TextEditingController companyController,
}) async {

  final UserModel newUserModel = UserModel.bakeEditorVariablesToUpload(
    context: context,
    oldUser: oldUserModel,
    tempUser: tempUser.value,
    titleController: titleController,
    nameController: nameController,
    companyController: companyController,
  );

  final bool _canContinue = _inputsAreValid(
    formKey: formKey,
  );

  /// A - IF ANY OF REQUIRED FIELDS IS NOT VALID
  if (_canContinue == false){
    await showMissingFieldsDialog(
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
// ----------------------------------------
bool _inputsAreValid({
  @required GlobalKey<FormState> formKey,
}) {
  bool _inputsAreValid;

  if (formKey.currentState?.validate() == true) {
    _inputsAreValid = true;
  }

  else {
    _inputsAreValid = false;
  }

  return _inputsAreValid;
}
// ---------------------------------------
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
