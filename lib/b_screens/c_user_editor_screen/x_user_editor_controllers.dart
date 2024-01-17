import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/a_user/draft/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/e_my_settings_page/user_settings_page_controllers.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadUserEditorLastSession({
  required ValueNotifier<DraftUser?>? draft,
  required bool mounted,
  // required String userID,
  // required bool reAuthBeforeConfirm,
  // required bool canGoBack,
  // required Function onFinish,
}) async {

  final DraftUser? _lastSessionDraft = await UserLDBOps.loadEditorSession(
    userID: draft?.value?.id,
  );

  if (_lastSessionDraft != null){

    final bool _continue = await BldrsCenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_load_last_session_data_q',
        translate: true,
      ),
      // bodyVerse: const Verse(
      //   text: 'phid_want_to_load_last_session_q',
      //   translate: true,
      // ),
      boolDialog: true,
    );

    if (_continue == true){

      setNotifier(
          notifier: draft,
          mounted: mounted,
          value: _lastSessionDraft.copyWith(
            nameController: draft?.value?.nameController,
            titleController: draft?.value?.titleController,
            companyController: draft?.value?.companyController,
            emailController: draft?.value?.emailController,
            phoneController: draft?.value?.phoneController,
            nameNode: draft?.value?.nameNode,
            titleNode: draft?.value?.titleNode,
            companyNode: draft?.value?.companyNode,
            emailNode: draft?.value?.emailNode,
            phoneNode: draft?.value?.phoneNode,
            formKey: draft?.value?.formKey,
            canPickImage: true,
          ),
      );

      draft?.value?.nameController?.text = _lastSessionDraft.name!;
      draft?.value?.titleController?.text = _lastSessionDraft.title!;
      draft?.value?.companyController?.text = _lastSessionDraft.company!;

      draft?.value?.emailController?.text = ContactModel.getContactFromContacts(
        contacts: _lastSessionDraft.contacts,
        type: ContactType.email,
      )?.value ?? '';

      draft?.value?.phoneController?.text = ContactModel.getContactFromContacts(
        contacts: _lastSessionDraft.contacts,
        type: ContactType.phone,
      )?.value ?? '';

    }

  }

}
// -----------------------------------------------------------------------------

/// EDITORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> takeUserPicture({
  required ValueNotifier<DraftUser?> draft,
  required PicMakerType picMakerType,
  required bool mounted,
}) async {

  if (draft.value?.id != null && Mapper.boolIsTrue(draft.value?.canPickImage) == true) {

    DraftUser.triggerCanPickImage(
      draftUser: draft,
      mounted: mounted,
      setTo: false,
    );

    final PicModel? _picModel = await BldrsPicMaker.makePic(
        picMakerType: picMakerType,
        cropAfterPick: true,
        aspectRatio: 1,
        compressWithQuality: Standards.userPicQuality,
        resizeToWidth: Standards.userPicWidth,
        assignPath: StoragePath.users_userID_pic(draft.value?.id)!,
        ownersIDs: [draft.value!.id!],
        name: 'user_pic',
    );

    /// IF DID NOT PIC ANY IMAGE
    if (_picModel == null) {
      // picture.value  = null;
      DraftUser.triggerCanPickImage(draftUser: draft, mounted: mounted, setTo: true,);
    }

    /// IF PICKED AN IMAGE
    else {

      setNotifier(
        notifier: draft,
        mounted: mounted,
        value: draft.value?.copyWith(
            picModel: _picModel,
            hasNewPic: true,
            canPickImage: true
        ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeGender({
  required Gender selectedGender,
  required ValueNotifier<DraftUser?> draft,
  required bool mounted,
}){

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        gender: selectedGender,
      )
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserNameChanged({
  required ValueNotifier<DraftUser?> draft,
  required String? text,
  required bool mounted,
}){

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        name: text,
      ),
  );


}
// --------------------
/// TESTED : WORKS PERFECT
void onUserJobTitleChanged({
  required ValueNotifier<DraftUser?> draft,
  required String? text,
  required bool mounted,
}){

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        title: text,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserCompanyNameChanged({
  required ValueNotifier<DraftUser?> draft,
  required String? text,
  required bool mounted,
}){

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        company: text,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserZoneChanged({
  required ZoneModel? selectedZone,
  required ValueNotifier<DraftUser?> draft,
  required bool mounted,
}){

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        zone: selectedZone,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUserContactChanged({
  required ValueNotifier<DraftUser?> draft,
  required ContactType contactType,
  required String? value,
  required bool mounted,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draft.value?.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  setNotifier(
      notifier: draft,
      mounted: mounted,
      value: draft.value?.copyWith(
        contacts: _contacts,
      ),
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
  required ValueNotifier<DraftUser?> draft,
  required UserModel? oldUser,
  required Function onFinish,
  required ValueNotifier<bool> loading,
  required bool forceReAuthentication,
  required bool mounted,
}) async {

  blog('confirmEdits : STARTED');

  final DraftUser? _draft = _bakeDraftTextControllers(draft.value);

  blog('confirmEdits : _draft : ${_draft == null}');

  final bool _canContinue = await _preConfirmCheckups(
    draft: _draft,
    forceReAuthentication: forceReAuthentication,
  );

  blog('confirmEdits : _canContinue : $_canContinue');

  if (_canContinue == true){

    setNotifier(
        notifier: loading,
        mounted: mounted,
        value: true
    );

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(
        id: 'phid_updating_profile',
        translate: true,
      ),
    );

    final UserModel? _userUploaded = await UserProtocols.renovate(
      newPic: Mapper.boolIsTrue(_draft?.hasNewPic) == true ? _draft?.picModel : null,
      oldUser: oldUser,
      newUser: DraftUser.toUserModel(
        draft: _draft,
      ),
      invoker: 'confirmEdits',
    );

    setNotifier(
      notifier: loading,
      mounted: mounted,
      value: false,
    );

    await WaitDialog.closeWaitDialog();

    await BldrsCenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_great_!',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'Successfully updated your user account',
        id: 'phid_updated_your_profile_successfully',
        translate: true,
      ),
    );

    await UserLDBOps.wipeEditorSession(_userUploaded?.id);

    onFinish();

  }

}
// --------------------
/// TESTED : WORKS PERFECT
DraftUser? _bakeDraftTextControllers(DraftUser? draft){

  List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draft?.contacts,
    contactToReplace: ContactModel(
      value: draft?.emailController?.text,
      type: ContactType.email,
    ),
  );

  _contacts = ContactModel.insertOrReplaceContact(
    contacts: _contacts,
    contactToReplace: ContactModel(
      value: draft?.phoneController?.text,
      type: ContactType.phone,
    ),
  );

  final DraftUser? _draft = draft?.copyWith(
    name: draft.nameController?.text,
    title: draft.titleController?.text,
    company: draft.companyController?.text,
    contacts: _contacts,
  );

  return _draft;

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preConfirmCheckups({
  required DraftUser? draft,
  required bool forceReAuthentication,
}) async {

  bool _canContinue = true;

  // _canContinue = Formers.validateForm(draft.formKey);
  //
  // /// A - IF ANY OF REQUIRED FIELDS IS NOT VALID
  // if (_canContinue == false){
  //   await Formers.showUserMissingFieldsDialog(
  //       context: context,
  //       userModel: DraftUser.toUserModel(context: context, draft: draft),
  //   );
  // }

  /// A - IF ALL REQUIRED FIELDS ARE VALID
  if (_canContinue == true){

    final UserModel? _oldUser = await UserProtocols.fetch(
      userID: draft?.id,
    );

    final bool _shouldReAuthenticate =  forceReAuthentication == true
                                        &&
                                        ContactModel.checkEmailChanged(
                                           oldContacts: _oldUser?.contacts,
                                           newContacts: draft?.contacts,
                                         ) == true;

    if (_shouldReAuthenticate == true){

      _canContinue = await reAuthenticateUser(
        dialogTitleVerse: const Verse(
          id: 'phid_enter_your_password',
          translate: true,
        ),
        dialogBodyVerse: const Verse(
          pseudo: 'Please add your password to be able to continue',
          id: 'phid_enter_your_password_description',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          id: 'phid_continue',
          translate: true,
        ),
      );

    }

    else {
      _canContinue = await BldrsCenterDialog.showCenterDialog(
        bodyVerse: const Verse(
            id: 'phid_you_want_to_continue',
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
