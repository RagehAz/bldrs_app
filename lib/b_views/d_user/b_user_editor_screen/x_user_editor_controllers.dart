import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/a_starters/a_logo_screen/x_logo_screen_controllers.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/x4_user_settings_page_controllers.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/a_user_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// DEPRECATED
/*
///
void initializeUserEditorLocalVariables({
  @required BuildContext context,
  @required UserModel oldUser,
  @required ValueNotifier<UserModel> tempUser,
}){
  
  tempUser.value = oldUser;

}
 */
// --------------------
/// DEPRECATED
/*
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
 */
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
///
Future<void> loadUserEditorLastSession({
  @required BuildContext context,
  @required String userID,
  @required bool reAuthBeforeConfirm,
  @required bool canGoBack,
  @required Function onFinish,
}) async {

  final DraftUser _lastSessionDraft = await UserLDBOps.loadEditorSession(
    userID: userID,
  );

  if (_lastSessionDraft != null){

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

      await Nav.replaceScreen(
        context: context,
        screen: EditProfileScreen(
          reAuthBeforeConfirm: reAuthBeforeConfirm,
          canGoBack: canGoBack,
          onFinish: onFinish,
          checkLastSession: false,
          validateOnStartup: true,
          userModel: DraftUser.toUserModel(
            draft: _lastSessionDraft,
          ),
        ),
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// EDITORS

// --------------------
///
Future<void> takeUserPicture({
  @required BuildContext context,
  @required ValueNotifier<DraftUser> draft,
  @required PicMakerType picMakerType,
  @required bool mounted,
}) async {

  if (draft.value.canPickImage == true) {

    DraftUser.triggerCanPickImage(draftUser: draft, mounted: mounted, setTo: false,);

    Uint8List _bytes;

    if(picMakerType == PicMakerType.galleryImage){
      _bytes = await PicMaker.pickAndCropSinglePic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }
    else if (picMakerType == PicMakerType.cameraImage){
      _bytes = await PicMaker.shootAndCropCameraPic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_bytes == null) {
      blog('takeUserPicture : did not take user picture');
      // picture.value = null;
      DraftUser.triggerCanPickImage(draftUser: draft, mounted: mounted, setTo: true,);
    }

    /// IF PICKED AN IMAGE
    else {
      blog('takeUserPicture : we got the pic in : ${_bytes?.length} bytes');

      draft.value = draft.value.copyWith(
        picModel: draft.value.picModel.copyWith(
          bytes: _bytes,
        ),
        hasNewPic: true,
      );

      DraftUser.triggerCanPickImage(draftUser: draft, mounted: mounted, setTo: true,);
    }

  }

}
// --------------------
///
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<DraftUser> draft,
}){
  draft.value = draft.value.copyWith(
    gender: selectedGender,
  );
}
// --------------------
///
void onUserNameChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){

  draft.value = draft.value.copyWith(
    name: text,
  );

}
// --------------------
///
void onUserJobTitleChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){

  draft.value = draft.value.copyWith(
    title: text,
  );

}
// --------------------
///
void onUserCompanyNameChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){
  draft.value = draft.value.copyWith(
    company: text,
  );
}

// --------------------
///
void onUserZoneChanged({
  @required ZoneModel selectedZone,
  @required ValueNotifier<DraftUser> draft,
}) {

  final DraftUser _updated = draft.value.copyWith(
    zone: selectedZone,
  );

  draft.value = _updated;

}
// --------------------
///
void onUserContactChanged({
  @required ValueNotifier<DraftUser> draft,
  @required ContactType contactType,
  @required String value,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draft.value.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  draft.value = draft.value.copyWith(
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
///
Future<void> confirmEdits({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required ValueNotifier<DraftUser> draft,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
  @required bool forceReAuthentication,
}) async {



  bool _canContinue = Formers.validateForm(draft.value.formKey);

  final UserModel newUserModel = DraftUser.toUserModel(
    draft: draft.value,
  );

  // /// A - IF ANY OF REQUIRED FIELDS IS NOT VALID
  // if (_canContinue == false){
  //   await Formers.showUserMissingFieldsDialog(
  //       context: context,
  //       userModel: newUserModel
  //   );
  //
  // }
  //
  // /// A - IF ALL REQUIRED FIELDS ARE VALID
  if (_canContinue == true){

    // bool _continueOps = true;

    final bool _shouldReAuthenticate =
            forceReAuthentication == true
            &&
            ContactModel.checkEmailChanged(
              oldContacts: oldUserModel.contacts,
              newContacts: newUserModel.contacts,
            ) == true;

    if (_shouldReAuthenticate == true){
      _canContinue = await reAuthenticateUser(
        context: context,
        dialogTitleVerse: const Verse(
          text: 'phid_enter_your_password',
          translate: true,
        ),
        dialogBodyVerse: const Verse(
          pseudo: 'Please add your password to be able to continue',
          text: 'phid_enter_your_password_description',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          text: 'phid_continue',
          translate: true,
        ),
      );
    }

    else {
      _canContinue = await CenterDialog.showCenterDialog(
        context: context,
        bodyVerse: const Verse(
          text: 'phid_you_want_to_continue',
          translate: true,
          pseudo: 'Are you sure you want to continue ?'
        ),
        boolDialog: true,
      );
    }

    if (_canContinue == true){

      final UserModel _uploadedUserModel = await _updateUserModel(
        context: context,
        draft: draft,
        loading: loading,
        oldUserModel: oldUserModel,
      );

      if (_uploadedUserModel != null){

        final AuthModel _originalAuthModel = await AuthLDBOps.readAuthModel();
        final AuthModel _authModel = _originalAuthModel.copyWith(
          userModel: _uploadedUserModel,
          firstTimer: false,
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
/// SHOULD BE RENOVATE PROTOCOL
Future<UserModel> _updateUserModel({
  @required BuildContext context,
  @required UserModel oldUserModel,
  @required ValueNotifier<DraftUser> draft,
  @required ValueNotifier<bool> loading,
}) async {

  UserModel _output;

  loading.value = true;
  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: const Verse(
      text: 'phid_updating_profile',
      translate: true,
    ),
  ));

  await Future.wait(<Future>[

    /// UPDATE USER
    UserFireOps.updateUser(
      oldUserModel: oldUserModel,
      newUserModel: DraftUser.toUserModel(
        draft: draft.value,
      ),
    ).then((value){
      _output = value;
    }),

    /// UPDATE PIC
    if (draft.value.hasNewPic == true)
    PicProtocols.composePic(draft.value.picModel),

  ]);


  loading.value = false;
  await WaitDialog.closeWaitDialog(context);

  await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_great_!',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'Successfully updated your user account',
      text: 'phid_updated_your_profile_successfully',
      translate: true,
    ),
  );

  return _output;
}
// -----------------------------------------------------------------------------
