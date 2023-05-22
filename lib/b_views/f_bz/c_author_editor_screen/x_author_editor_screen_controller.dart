import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/a_author_editor_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths_generators.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_pic_maker.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mediators/mediators.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// AUTHOR EDITOR INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> takeAuthorImage({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> author,
  @required BzModel bzModel,
  @required PicMakerType imagePickerType,
  @required ValueNotifier<bool> canPickImage,
  @required bool mounted,
}) async {

  if (canPickImage.value  == true) {

    setNotifier(
        notifier: canPickImage,
        mounted: mounted,
        value: false,
    );

    Uint8List _bytes;

    if(imagePickerType == PicMakerType.galleryImage){
      _bytes = await BldrsPicMaker.pickAndCropSinglePic(
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

      setNotifier(
          notifier: canPickImage,
          mounted: mounted,
          value: true
      );

    }

    /// IF PICKED AN IMAGE
    else {

      final Dimensions _dims = await Dimensions.superDimensions(_bytes);
      final double _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);

      setNotifier(
          notifier: author,
          mounted: mounted,
          value: author.value.copyWith(
            picModel: PicModel(
              bytes: _bytes,
              path: StoragePath.bzz_bzID_authorID(bzID: bzModel.id, authorID: author.value.userID),
              meta: StorageMetaModel(
                sizeMB: _mega,
                ownersIDs: AuthorModel.getAuthorPicOwnersIDs(
                  bzModel: bzModel,
                  authorModel: author.value,
                ),
                width: _dims.width,
                height: _dims.height,
              ),
            ),
          ),
      );

      setNotifier(
          notifier: canPickImage,
          mounted: mounted,
          value: true,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onDeleteAuthorImage({
  @required ValueNotifier<AuthorModel> author,
  @required bool mounted,
}){

  setNotifier(
    notifier: author,
    mounted: mounted,
    value: AuthorModel(
      picPath: null,
      title: author.value.title,
      role: author.value.role,
      contacts: author.value.contacts,
      userID: author.value.userID,
      name: author.value.name,
      flyersIDs: author.value.flyersIDs,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorNameChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required String text,
  @required bool mounted,
}){

  setNotifier(
      notifier: tempAuthor,
      mounted: mounted,
      value: tempAuthor.value.copyWith(
        name: text,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorTitleChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required String text,
  @required bool mounted,
}){

  setNotifier(
      notifier: tempAuthor,
      mounted: mounted,
      value: tempAuthor.value.copyWith(
        title: text,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onAuthorContactChanged({
  @required ValueNotifier<AuthorModel> tempAuthor,
  @required ContactType contactType,
  @required String value,
  @required bool mounted,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: tempAuthor.value.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  setNotifier(
      notifier: tempAuthor,
      mounted: mounted,
      value: tempAuthor.value.copyWith(
        contacts: _contacts,
      ),
  );


}
// -----------------------------------------------------------------------------

/// CONFIRMATION OPS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmAuthorUpdates({
  @required BuildContext context,
  @required AuthorModel oldAuthor,
  @required ValueNotifier<AuthorModel> draftAuthor,
  @required BzModel oldBz,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      id: 'phid_confirm_edits_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      id: 'phid_confirm_author_edits_note',
      translate: true,
    ),
    boolDialog: true,
    confirmButtonVerse: const Verse(
      id: 'phid_confirm',
      translate: true,
    ),
  );

  if (_result == true){

    pushWaitDialog(
      context: context,
      verse: const Verse(
        id: 'phid_updating_author_profile',
        translate: true,
      ),
    );

    final AuthorModel _newAuthor = AuthorModel.bakeEditorVariablesToUpload(
      bzModel: oldBz,
      oldAuthor: oldAuthor,
      draftAuthor: draftAuthor.value,
    );

    await BzProtocols.renovateAuthorProtocol(
      context: context,
      oldBz: oldBz,
      newAuthor: _newAuthor,
    );

    await BzLDBOps.deleteAuthorEditorSession(oldAuthor.userID);

    await WaitDialog.closeWaitDialog();

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
  @required ValueNotifier<AuthorRole> draftRole,
  @required AuthorModel oldAuthor,
  @required bool mounted,
}) async {

  if (draftRole.value != oldAuthor.role){

    final String _rolePhid = AuthorModel.getAuthorRolePhid(
      context: context,
      role: draftRole.value,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        id: 'phid_confirm_author_role_?',
        translate: true,
      ),
      bodyVerse: Verse(
        id: '${Verse.transBake('phid_this_will_change_the_role_of')}\n'
              '${oldAuthor.name}\n'
              '${Verse.transBake('phid_to')}'
              '${Verse.transBake(_rolePhid)}',
        translate: false,
      ),
      boolDialog: true,
    );

    if (_result == false){
      setNotifier(
          notifier: draftRole,
          mounted: mounted,
          value: oldAuthor.role
      );
    }

    else {

      pushWaitDialog(
        context: context,
        verse: const Verse(
          id: 'phid_updating_author_profile',
          translate: true,
        ),
      );

      final BzModel _oldBz = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: false,
      );

      final AuthorModel _newAuthor = oldAuthor.copyWith(
        role: draftRole.value,
      );

      await Future.wait(<Future>[

        BzProtocols.renovateAuthorProtocol(
          context: context,
          oldBz: _oldBz,
          newAuthor: _newAuthor,
        ),

        NoteEvent.sendAuthorRoleChangeNote(
          context: context,
          bzID: _oldBz.id,
          author: _newAuthor,
        )

      ]);

      await WaitDialog.closeWaitDialog();

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
  @required bool mounted,
}) async {

  final bool _canChangeRole = await _checkCanChangeRole(
    context: context,
    role: selectedRole,
    oldAuthor: oldAuthor,
  );

  if (_canChangeRole == true){

    setNotifier(
        notifier: tempRole,
        mounted: mounted,
        value: selectedRole,
    );

    await onChangeAuthorRoleOps(
      context: context,
      draftRole: tempRole,
      oldAuthor: oldAuthor,
      mounted: mounted,
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
          id: 'phid_cant_change_member_role',
          translate: true,
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
          id: 'phid_only_one_creator_allowed',
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
