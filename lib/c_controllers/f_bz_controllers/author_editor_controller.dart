import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/my_bz_screen_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;

// ----------------------------------
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

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  final BzModel _bzModel = _bzzProvider.myActiveBz;

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

    final BzModel _updatedBzModel = _bzModel.copyWith(
      authors: AuthorModel.replaceAuthorModelInAuthorsList(
          authorToReplace: _author,
          authors: _bzModel.authors,
      ),
    );

    final BzModel _uploadedModel = await BzFireOps.updateBz(
        context: context,
        newBzModel: _updatedBzModel,
        oldBzModel: _bzModel,
        authorPicFile: objectIsFile(_author.pic) == true ? _author.pic : null,
    );

    await myActiveBzLocalUpdateProtocol(
      context: context,
      newBzModel: _uploadedModel,
      oldBzModel: _bzModel,
      bzzProvider: _bzzProvider,
    );


    WaitDialog.closeWaitDialog(context);

    Nav.goBack(context);
  }


}
// ----------------------------------
