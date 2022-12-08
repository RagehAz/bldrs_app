import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/a_user/draft/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/d_settings_page/x4_user_settings_page_controllers.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
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
/// TESTED : WORKS PERFECT
Future<void> loadUserEditorLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftUser> draft,
  // @required String userID,
  // @required bool reAuthBeforeConfirm,
  // @required bool canGoBack,
  // @required Function onFinish,
}) async {

  final DraftUser _lastSessionDraft = await UserLDBOps.loadEditorSession(
    userID: draft.value?.id,
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

      draft.value = _lastSessionDraft.copyWith(
        nameController: draft.value.nameController,
        titleController: draft.value.titleController,
        companyController: draft.value.companyController,
        emailController: draft.value.emailController,
        phoneController: draft.value.phoneController,
        nameNode: draft.value.nameNode,
        titleNode: draft.value.titleNode,
        companyNode: draft.value.companyNode,
        emailNode: draft.value.emailNode,
        phoneNode: draft.value.phoneNode,
        formKey: draft.value.formKey,
        canPickImage: true,
      );

      draft.value.nameController.text = _lastSessionDraft.name;
      draft.value.titleController.text = _lastSessionDraft.title;
      draft.value.companyController.text = _lastSessionDraft.company;

      draft.value.emailController.text = ContactModel.getContactFromContacts(
        contacts: _lastSessionDraft.contacts,
        type: ContactType.email,
      )?.value;

      draft.value.phoneController.text = ContactModel.getContactFromContacts(
        contacts: _lastSessionDraft.contacts,
        type: ContactType.phone,
      )?.value;

    }

  }

}
// -----------------------------------------------------------------------------

/// EDITORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> takeUserPicture({
  @required BuildContext context,
  @required ValueNotifier<DraftUser> draft,
  @required PicMakerType picMakerType,
  @required bool mounted,
}) async {

  if (draft.value.canPickImage == true) {

    DraftUser.triggerCanPickImage(
      draftUser: draft,
      mounted: mounted,
      setTo: false,
    );

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
        picModel: PicModel(
          bytes: _bytes,
          path: Storage.generateUserPicPath(draft.value.id),
          meta: PicMetaModel(
            dimensions: await Dimensions.superDimensions(_bytes),
            ownersIDs: [draft.value.id],
          ),
        ),
        hasNewPic: true,
        canPickImage: true
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeGender({
  @required Gender selectedGender,
  @required ValueNotifier<DraftUser> draft,
}){
  draft.value = draft.value.copyWith(
    gender: selectedGender,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
void onUserNameChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){

  draft.value = draft.value.copyWith(
    name: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserJobTitleChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){

  draft.value = draft.value.copyWith(
    title: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserCompanyNameChanged({
  @required ValueNotifier<DraftUser> draft,
  @required String text,
}){
  draft.value = draft.value.copyWith(
    company: text,
  );
}

// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> confirmEdits({
  @required BuildContext context,
  @required ValueNotifier<DraftUser> draft,
  @required UserModel oldUser,
  @required Function onFinish,
  @required ValueNotifier<bool> loading,
  @required bool forceReAuthentication,
  @required bool mounted,
}) async {

  final DraftUser _draft = _bakeDraftTextControllers(draft.value);

  final bool _canContinue = await _preConfirmCheckups(
    context: context,
    draft: _draft,
    forceReAuthentication: forceReAuthentication,
  );

  if (_canContinue == true){

    setNotifier(
        notifier: loading,
        mounted: mounted,
        value: true
    );

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: const Verse(
        text: 'phid_updating_profile',
        translate: true,
      ),
    ));

    final UserModel _userUploaded = await UserProtocols.renovate(
      context: context,
      newPic: _draft.hasNewPic == true ? _draft.picModel : null,
      oldUser: oldUser,
      newUser: DraftUser.toUserModel(
        context: context,
        draft: _draft,
      ),
    );

    setNotifier(
      notifier: loading,
      mounted: mounted,
      value: false,
    );

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

    await UserLDBOps.wipeEditorSession(_userUploaded.id);

    onFinish();

  }

}
// --------------------
/// TESTED : WORKS PERFECT
DraftUser _bakeDraftTextControllers(DraftUser draft){
  List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draft.contacts,
    contactToReplace: ContactModel(
      value: draft.emailController.text,
      type: ContactType.email,
    ),
  );

  _contacts = ContactModel.insertOrReplaceContact(
    contacts: _contacts,
    contactToReplace: ContactModel(
      value: draft.phoneController.text,
      type: ContactType.phone,
    ),
  );

  final DraftUser _draft = draft.copyWith(
    name: draft.nameController.text,
    title: draft.titleController.text,
    company: draft.companyController.text,
    contacts: _contacts,
  );

  return _draft;

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preConfirmCheckups({
  @required BuildContext context,
  @required DraftUser draft,
  @required bool forceReAuthentication,
}) async {

  bool _canContinue = Formers.validateForm(draft.formKey);

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

    final UserModel _oldUser = await UserProtocols.fetch(
      context: context,
      userID: draft.id,
    );

    final bool _shouldReAuthenticate =  forceReAuthentication == true
                                        &&
                                        ContactModel.checkEmailChanged(
                                           oldContacts: _oldUser.contacts,
                                           newContacts: draft.contacts,
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

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------
