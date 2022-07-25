import 'dart:async';
import 'dart:io';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// AUTHOR PROFILE EDITOR

// -------------------------------
Future<void> takeAuthorImage({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> author,
}) async {

  final List<File> _imageFiles = await Imagers.pickMultipleImages(
    context: context,
    maxAssets: 1
    // picType: Imagers.PicType.authorPic
  );

  final File _file = _imageFiles?.first;

  author.value = author.value.copyWith(
    pic: _file,
  );

}
// ----------------------------------
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
// ----------------------------------
Future<void> onConfirmAuthorUpdates({
  @required BuildContext context,
  @required ValueNotifier<AuthorModel> author,
  @required TextEditingController nameController,
  @required TextEditingController titleController,
  @required List<TextEditingController> generatedControllers,
}) async {

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
    context: context,
    listen: false,
  );

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Confirm Edits ?',
    body: 'This will only edit your details as author in ${_bzModel.name} '
        'business account, and will not impact your personal profile',
    boolDialog: true,
    confirmButtonText: 'Confirm',
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading new Author details',
    ));

    final AuthorModel _author = AuthorModel(
        userID: author.value.userID,
        role: author.value.role,
        pic: author.value.pic,
        flyersIDs: author.value.flyersIDs,
        name: nameController.text,
        title: titleController.text,
        contacts: ContactModel.createContactsListByGeneratedControllers(
          generatedControllers: generatedControllers,
        )
    );

    author.value = _author;

    await AuthorProtocols.updateAuthorProtocol(
      context: context,
      oldBzModel: _bzModel,
      newAuthorModel: _author,
    );


    WaitDialog.closeWaitDialog(context);

    Nav.goBack(context);
  }


}
// -----------------------------------------------------------------------------

/// AUTHOR ROLE EDITOR

// -------------------------------
Future<void> onChangeAuthorRoleOps({
  @required BuildContext context,
  @required ValueNotifier<AuthorRole> authorRole,
  @required AuthorModel author,
}) async {

  if (authorRole.value != author.role){

    final String _role = AuthorModel.translateRole(
      context: context,
      role: authorRole.value,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Change Author Role',
      body: 'This will set ${author.name} as $_role',
      boolDialog: true,
    );

    if (_result == false){
      authorRole.value = author.role;
    }

    else {

      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Uploading new Author details',
      ));

      final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: false,
      );

      final AuthorModel _author = author.copyWith(
        role: authorRole.value,
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

      Nav.goBack(context);

    }


  }


}
// -----------------------------------------------------------------------------
