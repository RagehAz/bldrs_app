import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/authors_page/author_card.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// AUTHOR PROFILE EDITOR

// -------------------------------
Future<void> takeAuthorImage({
  @required ValueNotifier<AuthorModel> author,
}) async {

  final File _imageFile = await Imagers.takeGalleryPicture(
      picType: Imagers.PicType.authorPic
  );

  author.value = author.value.copyWith(
    pic: _imageFile,
  );

}
// ----------------------------------
void onDeleteAuthorImage({
  @required ValueNotifier<AuthorModel> author,
}){
  author.value = AuthorModel(
    pic: null,
    title: author.value.title,
    isMaster: author.value.isMaster,
    contacts: author.value.contacts,
    userID: author.value.userID,
    name: author.value.name,
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
        isMaster: author.value.isMaster,
        pic: author.value.pic,
        name: nameController.text,
        title: titleController.text,
        contacts: ContactModel.createContactsListByGeneratedControllers(
          generatedControllers: generatedControllers,
        )
    );

    author.value = _author;

    final BzModel _updatedBzModel = BzModel.replaceAuthor(
        updatedAuthor: _author,
        bzModel: _bzModel,
    );

    await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: _bzModel,
        authorPicFile: objectIsFile(_author.pic) == true ? _author.pic : null,
    );

    /// no need to do that as stream listener does it
    // await myActiveBzLocalUpdateProtocol(
    //   context: context,
    //   newBzModel: _uploadedModel,
    //   oldBzModel: _bzModel,
    // );


    WaitDialog.closeWaitDialog(context);

    Nav.goBack(context);
  }


}
// -----------------------------------------------------------------------------

/// AUTHOR ROLE EDITOR

// -------------------------------
Future<void> onChangeAuthorRoleOps({
  @required BuildContext context,
  @required ValueNotifier<bool> isMaster,
  @required AuthorModel author,
}) async {

  if (isMaster.value != author.isMaster){

    final String _role = AuthorCard.getAuthorRoleLine(
      isMaster: isMaster.value,
    );

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Change Author Role',
      body: 'This will set ${author.name} as $_role',
      boolDialog: true,
    );

    if (_result == false){
      isMaster.value = !isMaster.value;
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
        isMaster: isMaster.value,
      );

      final BzModel _updatedBzModel = BzModel.replaceAuthor(
        updatedAuthor: _author,
        bzModel: _bzModel,
      );

      await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: _bzModel,
        authorPicFile: null,
      );

      // await myActiveBzLocalUpdateProtocol(
      //   context: context,
      //   newBzModel: _uploadedModel,
      //   oldBzModel: _bzModel,
      // );

      WaitDialog.closeWaitDialog(context);

      Nav.goBack(context);

    }


  }


}
// -----------------------------------------------------------------------------
