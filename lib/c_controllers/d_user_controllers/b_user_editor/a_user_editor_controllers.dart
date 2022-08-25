import 'dart:async';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/b_logo_screen_controllers.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/c_home_controllers.dart';
import 'package:bldrs/c_controllers/d_user_controllers/a_user_profile/a5_user_settings_controllers.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/user_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// EDITORS

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> takeUserPicture({
  @required BuildContext context,
  @required ValueNotifier<bool> canPickImage,
  @required ValueNotifier<FileModel> fileModel,
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
      fileModel.value = _imageFileModel;
      canPickImage.value = true;
    }

  }

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<Gender> genderNotifier,
}){
  genderNotifier.value = selectedGender;
}
// ---------------------------------------
/// TESTED : WORKS PERFECT
void onZoneChanged({
  @required ZoneModel selectedZone,
  @required ValueNotifier<ZoneModel> zoneNotifier,
}) {

  zoneNotifier.value = selectedZone;
  selectedZone.blogZone(methodName: 'onZoneChanged');

}
// ----------------------------------------
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
  @required UserModel newUserModel,
  @required UserModel oldUserModel,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
  @required bool forceReAuthentication,
}) async {

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

    if (forceReAuthentication == true){
      _continueOps = await reAuthenticateUser(
        context: context,
        dialogTitle: 'User Check',
        dialogBody: 'Please add your password to be able to continue',
        confirmButtonText: 'Continue',
      );
    }

    if (_continueOps == true){

      // /// B1 - ASK FOR CONFIRMATION
      // _continueOps = await CenterDialog.showCenterDialog(
      //   context: context,
      //   title: '',
      //   body: 'Are you sure you want to continue ?',
      //   boolDialog: true,
      // );

      // /// B2 - IF USER CONFIRMS
      // if (_continueOps == true) {

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

        onFinish();

      // }

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
    loadingVerse: xPhrase(context, '##Updating Profile'),
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
    title: 'Great !',
    body: 'Successfully updated your user account',
  );

  return _uploadedUserModel;
}
// ---------------------------------
