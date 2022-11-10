import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// AUTHOR EDITOR INITIALIZATION

// --------------------
/// TASK : TEST ME
Future<void> prepareAuthorPicForEditing({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> draftAuthor,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required bool mounted,
}) async {

  final AuthorModel _tempAuthor = await AuthorModel.prepareAuthorForEditing(
    oldAuthor: oldAuthor,
    bzModel: bzModel,
  );

  setNotifier(
    notifier: draftAuthor,
    mounted: mounted,
    value: _tempAuthor,
  );

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TASK : TEST ME
Future<void> loadAuthorEditorSession({
  @required BuildContext context,
  @required bool mounted,
  @required ValueNotifier<AuthorModel> draftAuthor,
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
/// TASK : TEST ME
Future<void> saveAuthorEditorSession({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required BzModel bzModel,
  @required ValueNotifier<AuthorModel> draftAuthor,
  @required bool mounted,
}) async {

  final AuthorModel newAuthor = AuthorModel.bakeEditorVariablesToUpload(
    bzModel: bzModel,
    oldAuthor: oldAuthor,
    draftAuthor: draftAuthor.value,
  );

  await BzLDBOps.saveAuthorEditorSession(
    authorModel: newAuthor,
  );


  // final bool authorHasChanged = AuthorModel.checkAuthorsAreIdentical(
  //   author1: newAuthor,
  //   author2: lastTempAuthor.value,
  // ) == false;
  //
  // if (authorHasChanged == true){


    // setNotifier(
    //   notifier: lastTempAuthor,
    //   mounted: mounted,
    //   value: newAuthor,
    // );

  // }

}
// -----------------------------------------------------------------------------

/// AUTHOR PROFILE EDITOR

// --------------------
/// TASK : TEST ME
Future<void> takeAuthorImage({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> author,
  @required BzModel bzModel,
  @required PicMakerType imagePickerType,
  @required ValueNotifier<bool> canPickImage,
}) async {

  if (canPickImage.value == true) {

    canPickImage.value = false;

    Uint8List _bytes;

    if(imagePickerType == PicMakerType.galleryImage){
      _bytes = await PicMaker.pickAndCropSinglePic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }
    else if (imagePickerType == PicMakerType.cameraImage){
      _bytes = await PicMaker.shootAndCropCameraPic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_bytes == null) {
      canPickImage.value = true;
    }

    /// IF PICKED AN IMAGE
    else {
      author.value = author.value.copyWith(
        picModel: PicModel(
            bytes: _bytes,
            path: StorageColl.getAuthorPicPath(bzID: bzModel.id, authorID: author.value.userID),
            meta: PicMetaModel(
              ownersIDs: AuthorModel.getAuthorPicOwnersIDs(
                  bzModel: bzModel,
                  authorModel: author.value,
              ),
              dimensions: await Dimensions.superDimensions(_bytes),
            ),
        ),
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
    picPath: null,
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
      text: 'phid_confirm_edits_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      text: 'phid_confirm_author_edits_note',
      pseudo: 'This will only update your details in this business account, and will not impact your personal profile',
      translate: true,
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
      draftAuthor: tempAuthor.value,
    );

    await BzProtocols.renovateAuthorProtocol(
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

        BzProtocols.renovateAuthorProtocol(
          context: context,
          oldBzModel: _bzModel,
          newAuthorModel: _author,
        ),

        NoteEvent.sendAuthorRoleChangeNote(
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
