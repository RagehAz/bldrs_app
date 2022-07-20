import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/b_logo_screen_controllers.dart';
import 'package:bldrs/c_controllers/a_starters_controllers/c_home_controllers.dart';
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// EDITORS

// ----------------------------------------
Future<void> takeUserPicture({
  @required BuildContext context,
  @required ValueNotifier<bool> canPickImage,
  @required ValueNotifier<dynamic> picture,
}) async {

  if (canPickImage.value == true) {

    canPickImage.value = false;

    final List<File> _imageFiles = await Imagers.pickMultipleImages(
      context: context,
      // picType: Imagers.PicType.userPic,
    );

    final File _imageFile = _imageFiles?.last;


    /// IF DID NOT PIC ANY IMAGE
    if (_imageFile == null) {
      blog('takeUserPicture : did not take user picture');
      picture.value = null;
      canPickImage.value = true;
    }

    /// IF PICKED AN IMAGE
    else {
      blog('takeUserPicture : we got the pic in : ${_imageFile?.path}');
      picture.value = _imageFile;
      canPickImage.value = true;
    }

  }

}
// ----------------------------------------
void deleteUserPicture({
  @required ValueNotifier<dynamic> picture,
}) {
  picture.value = null;
}
// ----------------------------------------
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<Gender> genderNotifier,
}){
  genderNotifier.value = selectedGender;
}
// ----------------------------------------
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

// ----------------------------------------
Future<void> confirmEdits({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required UserModel newUserModel,
  @required UserModel oldUserModel,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
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

    /// B1 - ASK FOR CONFIRMATION
    final bool _continueOps = await CenterDialog.showCenterDialog(
      context: context,
      title: '',
      body: 'Are you sure you want to continue ?',
      boolDialog: true,
    );

    /// B2 - IF USER CONFIRMS
    if (_continueOps == true) {

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
// ----------------------------------------
Future<UserModel> _updateUserModel({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required UserModel newUserModel,
  @required ValueNotifier<bool> loading,
}) async {

  loading.value = true;

  /// start create user ops
  final UserModel _uploadedUserModel = await UserFireOps.updateUser(
    context: context,
    oldUserModel: oldUserModel,
    newUserModel: newUserModel,
  );

  loading.value = false;

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Great !',
    body: 'Successfully updated your user account',
  );

  return _uploadedUserModel;
}
// ----------------------------------------
