import 'dart:io';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/e_saves/e_0_saved_flyers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/d_zoning_controller.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/search_screens/search_bzz_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/search_users_screen.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/e_db/fire/foundation/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;

// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------
void initializeVariables({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}){
  final NoteModel _initialNote = createInitialNote(context);
  note.value = _initialNote;
}
// -------------------------------
NoteModel createInitialNote(BuildContext context) {

  final NoteModel _noteModel = NoteModel(
    id: null,
    senderID: NoteModel.bldrsSenderModel.key,
    senderImageURL: NoteModel.bldrsSenderModel.value,
    noteSenderType: NoteSenderType.bldrs,
    receiverID: null,
    title: null,
    body: null,
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: null,
    seenTime: null,
    sendFCM: false,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
  );

  return _noteModel;
}
// -----------------------------------------------------------------------------

/// NOTE TYPE

// -------------------------------
Future<void> onChangeNoteType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteType noteType,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteSenderType> noteSenderType,
}) async {

  if (
  noteType == NoteType.authorship
  &&
  noteSenderType.value != NoteSenderType.bz
  ){

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Watch out!',
      body: 'Only Business note Sender Type can send Authorship notes'
          '\n want to continue and wipe selected sender type?',
      boolDialog: true,
    );

    if (_result == true){

      selectedSenderModel.value = null;
      noteSenderType.value = NoteSenderType.bz;

      final NoteModel _old = note.value;

      note.value = NoteModel(
        noteType: noteType,
        noteSenderType: NoteSenderType.bz,
        senderID: null,
        senderImageURL: null,

        id: _old.id,
        receiverID: _old.receiverID,
        title: _old.title,
        body: _old.body,
        metaData: _old.metaData,
        sentTime: _old.sentTime,
        attachment: _old.attachment,
        attachmentType: _old.attachmentType,
        seen: _old.seen,
        seenTime: _old.seenTime,
        sendFCM: _old.sendFCM,
        response: _old.response,
        responseTime: _old.responseTime,
        buttons: _old.buttons,
      );


    }

  }

  else {

    note.value = note.value.copyWith(
      noteType: noteType,
    );

  }



}
// -----------------------------------------------------------------------------

/// NOTE RECEIVER

// -------------------------------
Future<void> onSelectNoteReceiverTap({
  @required BuildContext context,
  @required ValueNotifier<UserModel> receiver,
  @required ValueNotifier<NoteModel> note,
}) async {

  Keyboarders.closeKeyboard(context);

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
      context: context,
      screen: const SearchUsersScreen(
        // multipleSelection: false,
        // selectedUsers: null,
      ),
  );

    if (Mapper.canLoopList(_selectedUsers) == true){
      receiver.value = _selectedUsers.first;
      note.value = note.value.copyWith(
        receiverID: _selectedUsers.first.id,
      );
    }


    /*
    // -----------------------------------------------------------------------------
  Future<void> _onSelectReciever() async {



    // final double _dialogHeight = BottomDialog.dialogHeight(context, ratioOfScreenHeight: 0.85);
    //
    // final double _dialogClearWidth = BottomDialog.clearWidth(context);
    // final double _dialogClearHeight = BottomDialog.clearHeight(
    //   context: context,
    //   draggable: true,
    //   titleIsOn: true,
    //   overridingDialogHeight: _dialogHeight,
    // );
    // const double _textFieldHeight = 70;
    //
    // List<UserModel> _usersModels = <UserModel>[];
    //
    // await BottomDialog.showStatefulBottomDialog(
    //   context: context,
    //   draggable: true,
    //   title: 'Search for a user',
    //   height: _dialogHeight,
    //   builder: (BuildContext ctx, String title) {
    //     return StatefulBuilder(
    //         builder: (BuildContext xxx, void Function(void Function()) setDialogState) {
    //       return Column(
    //         children: <Widget>[
    //           /// USER NAME TEXT FIELD
    //           SizedBox(
    //             width: _dialogClearWidth,
    //             height: _textFieldHeight,
    //             child: SuperTextField(
    //                width: _dialogClearWidth,
    //               // height: _textFieldHeight,
    //               // formKey: null,
    //               textController: _userNameController,
    //               hintText: 'user name ...',
    //               keyboardTextInputType: TextInputType.multiline,
    //               maxLength: 30,
    //               maxLines: 2,
    //               keyboardTextInputAction: TextInputAction.search,
    //               onSubmitted: (String val) async {
    //                 blog('submitted : val : $val');
    //
    //                 final List<UserModel> _resultUsers = await UserFireSearch.usersByUserName(
    //                   context: context,
    //                   name: val,
    //                   startAfter: null,
    //                 );
    //
    //                 if (_resultUsers == <UserModel>[]) {
    //                   blog('result is null, no result found');
    //                 } else {
    //                   blog('_result found : ${_resultUsers.length} matches');
    //
    //                   setDialogState(() {
    //                     _usersModels = _resultUsers;
    //                   });
    //                 }
    //               },
    //             ),
    //           ),
    //
    //           SizedBox(
    //             width: _dialogClearWidth,
    //             height: _dialogClearHeight - _textFieldHeight,
    //             child: OldMaxBounceNavigator(
    //               child: ListView.builder(
    //                   physics: const BouncingScrollPhysics(),
    //                   padding: const EdgeInsets.only(bottom: Ratioz.horizon),
    //                   itemCount: _usersModels.length,
    //                   itemBuilder: (BuildContext ctx, int index) {
    //                     final bool _userSelected =
    //                         _selectedUser == _usersModels[index];
    //
    //                     return _usersModels == <UserModel>[] ?
    //
    //                     SizedBox(
    //                       width: _dialogClearWidth,
    //                       height: 70,
    //                       child: const SuperVerse(
    //                         verse: 'No match found',
    //                         size: 1,
    //                         weight: VerseWeight.thin,
    //                         italic: true,
    //                         color: Colorz.white30,
    //                       ),
    //                     )
    //                         :
    //                     Row(
    //                       children: <Widget>[
    //
    //                         DashboardUserButton(
    //                             width: _dialogClearWidth - DashboardUserButton.height(),
    //                             userModel: _usersModels[index],
    //                             index: index,
    //                             onTap: null
    //                         ),
    //
    //                         Container(
    //                                 height: DashboardUserButton.height(),
    //                                 width: DashboardUserButton.height(),
    //                                 alignment: Alignment.center,
    //                                 child: DreamBox(
    //                                   height: 50,
    //                                   width: 50,
    //                                   icon: Iconz.check,
    //                                   iconSizeFactor: 0.5,
    //                                   iconColor: _userSelected == true
    //                                       ? Colorz.green255
    //                                       : Colorz.white50,
    //                                   color: null,
    //                                   onTap: () async {
    //                                     setDialogState(() {
    //                                       _selectedUser = _usersModels[index];
    //                                     });
    //
    //                                     setState(() {
    //                                       _selectedUser = _usersModels[index];
    //                                     });
    //
    //                                     Nav.goBack(context);
    //                                     // await null;
    //                                   },
    //                                 ),
    //                               )
    //                       ],
    //                     );
    //                   }
    //                   ),
    //             ),
    //           ),
    //         ],
    //       );
    //     });
    //   },
    // );
  }

     */

}
// -------------------------------
void deleteSelectedReciever({
  @required ValueNotifier<UserModel> selectedUser,
}){

  selectedUser.value = null;

}
// -----------------------------------------------------------------------------

/// BODY AND TITLE

// -------------------------------
void onTitleChanged({
  @required String text,
  @required ValueNotifier<NoteModel> note,
}){

  final NoteModel _updated = note.value.copyWith(
    title: text,
  );

  note.value = _updated;
}
// -------------------------------
void onBodyChanged({
  @required String text,
  @required ValueNotifier<NoteModel> note,
}){

  final NoteModel _updated = note.value.copyWith(
    body: text,
  );

  note.value = _updated;
}
// -----------------------------------------------------------------------------

/// SENDER

// -------------------------------
Future<void> onSelectNoteSender({
  @required BuildContext context,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
}) async {

  final bool _continue = await _showEthicalConfirmationDialog(
    context: context,
    senderType: senderType,
  );

  if (_continue == true){

    /// BY USER
    if (senderType == NoteSenderType.user){

      await _onSelectUserAsNoteSender(
        context: context,
        note: note,
        selectedSenderModel: selectedSenderModel,
        senderType: senderType,
        selectedSenderType: selectedSenderType,
      );

    }

    /// BY BZ
    if (senderType == NoteSenderType.bz){
      await _onSelectBzAsNoteSender(
        context: context,
        note: note,
        selectedSenderModel: selectedSenderModel,
        senderType: senderType,
        selectedSenderType: selectedSenderType,
      );
    }

    /// BY COUNTRY
    if (senderType == NoteSenderType.country){
      await _onSelectCountryAsNoteSender(
        context: context,
        note: note,
        selectedSenderModel: selectedSenderModel,
        senderType: senderType,
        selectedSenderType: selectedSenderType,
      );
    }

    if (senderType == NoteSenderType.bldrs){
      await _onSelectBldrsAsNoteSender(
        context: context,
        note: note,
        selectedSenderModel: selectedSenderModel,
        senderType: senderType,
        selectedSenderType: selectedSenderType,
      );
    }
  }


}
// -------------------------------
Future<bool> _showEthicalConfirmationDialog({
  @required BuildContext context,
  @required NoteSenderType senderType,
}) async {

  bool _canContinue = true;

  if (
  senderType == NoteSenderType.bz
  ||
  senderType == NoteSenderType.user
  ){

    final String _senderTypeString = NoteModel.cipherNoteSenderType(senderType);

    _canContinue = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Ethical Alert',
      body: 'Sending Notes on behalf of a $_senderTypeString '
          "is kind of little bit unethical, isn't it ?\n"
          'Anyways, Would you like to continue ?',
      boolDialog: true,
      confirmButtonText: 'Fuck Yeah',
    );

  }

  return _canContinue;
}
// -------------------------------
Future<void> _onSelectUserAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
}) async {

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
    context: context,
    screen: const SearchUsersScreen(),
  );

  final bool _newSelection = Mapper.canLoopList(_selectedUsers);
  if (_newSelection == true){

    final UserModel _userModel = _newSelection == true ?
    _selectedUsers.first
        :
    null;

    selectedSenderType.value = senderType;
    selectedSenderModel.value = _userModel;
    note.value = note.value.copyWith(
      senderID: _userModel.id,
      senderImageURL: _userModel.pic,
      noteSenderType: senderType,
    );

  }

}
// -------------------------------
Future<void> _onSelectBzAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
}) async {

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  final bool _newSelection = Mapper.canLoopList(_bzModels);
  if (_newSelection == true){

    final BzModel _bzModel = Mapper.canLoopList(_bzModels) == true ?
    _bzModels.first
        :
    null;

    selectedSenderModel.value = _bzModel;
    selectedSenderType.value = senderType;
    note.value = note.value.copyWith(
      senderID: _bzModel.id,
      senderImageURL: _bzModel.logo,
      noteSenderType: senderType,
    );

  }

}
// -------------------------------
Future<void> _onSelectCountryAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
}) async {

  final ZoneModel _zoneModel = await controlSelectCountryOnly(context);

  final bool _newSelection =_zoneModel != null;
  if (_newSelection == true){

    final CountryModel _countryModel = await ZoneProvider.proFetchCountry(
      context: context,
      countryID: _zoneModel.countryID,
    );


    selectedSenderModel.value = _countryModel;
    selectedSenderType.value = senderType;
    note.value = note.value.copyWith(
      senderID: _countryModel.id,
      senderImageURL: Flag.getFlagIconByCountryID(_countryModel.id),
      noteSenderType: senderType,
    );

  }

}
// -------------------------------
Future<void> _onSelectBldrsAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
}) async {

  selectedSenderType.value = senderType;
  selectedSenderModel.value = NoteModel.bldrsSenderModel;

  note.value = note.value.copyWith(
    senderID: NoteModel.bldrsSenderModel.key,
    senderImageURL: NoteModel.bldrsSenderModel.value,
    noteSenderType: senderType,
  );

}
// -----------------------------------------------------------------------------

/// SEND FCM SWITCH

// -------------------------------
void onSwitchSendFCM({
  @required ValueNotifier<NoteModel> note,
  @required bool value,
}){

  note.value = note.value.copyWith(
    sendFCM: value,
  );

}
// -----------------------------------------------------------------------------

/// BUTTONS

// -------------------------------
void onAddNoteButton({
  @required ValueNotifier<NoteModel> note,
  @required String button,
}){

  final List<String> _updatedButtons = addOrRemoveStringToStrings(
      strings: note.value?.buttons,
      string: button,
  );

  note.value = note.value.copyWith(
    buttons: _updatedButtons,
  );

}
// -----------------------------------------------------------------------------

/// ATTACHMENTS

// -------------------------------
Future<void> onSelectAttachmentType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  /// NO ATTACHMENT
  if (attachmentType == NoteAttachmentType.non){
    _onClearAttachments(
      note: note,
    );
  }

  /// BZ ID
  else if (attachmentType == NoteAttachmentType.bzID){
    await _onSelectBzAsAttachment(
      context: context,
      note: note,
      attachmentType: attachmentType,
    );
  }

  /// FLYERS IDS
  else if (attachmentType == NoteAttachmentType.flyersIDs){
    await _onSelectFlyersIDsAsAttachment(
      context: context,
      note: note,
      attachmentType: attachmentType,
    );
  }

  /// IMAGE
  else if (attachmentType == NoteAttachmentType.imageURL){
    await _onSelectImageURLAsAttachment(
      context: context,
      note: note,
      attachmentType: attachmentType,
    );
  }

}
// -------------------------------
Future<void> _onSelectBzAsAttachment({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  final bool _newSelection = Mapper.canLoopList(_bzModels);
  if (_newSelection == true){

    final BzModel _bzModel = Mapper.canLoopList(_bzModels) == true ?
    _bzModels.first
        :
    null;

    note.value = note.value.copyWith(
      attachmentType: attachmentType,
      attachment: _bzModel.id,
    );

  }

}
// -------------------------------
Future<void> _onSelectFlyersIDsAsAttachment({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  List<String> _ids;

  final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
    context: context,
    screen: const SavedFlyersScreen(
      selectionMode: true,
    ),
  );

  final bool _newSelection = Mapper.canLoopList(_selectedFlyers);
  if (_newSelection == true){

    _ids = FlyerModel.getFlyersIDsFromFlyers(_selectedFlyers);

    note.value = note.value.copyWith(
      attachmentType: attachmentType,
      attachment: _ids,
    );

  }

}
// -------------------------------
Future<void> _onSelectImageURLAsAttachment({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  final File _pic = await Imagers.takeGalleryPicture(
    picType: Imagers.PicType.slideHighRes,
  );

  // final ImageSize _picSize = await ImageSize.superImageSize(_pic);
  // final double _picViewHeight = ImageSize.concludeHeightByGraphicSizes(
  //   width: NoteCard.bodyWidth(context),
  //   graphicWidth: _picSize.width,
  //   graphicHeight: _picSize.height,
  // );

  note.value = note.value.copyWith(
    attachmentType: attachmentType,
    attachment: _pic,
  );

}
// -------------------------------
void _onClearAttachments({
  @required ValueNotifier<NoteModel> note,
}){

  final NoteModel _note = note.value;

  note.value = NoteModel(
    attachment: null,
    attachmentType: NoteAttachmentType.non,

    id: _note.id,
    senderID: _note.senderID,
    senderImageURL: _note.senderImageURL,
    noteSenderType: _note.noteSenderType,
    receiverID: _note.receiverID,
    title: _note.title,
    body: _note.body,
    metaData: _note.metaData,
    sentTime: _note.sentTime,
    seen: _note.seen,
    seenTime: _note.seenTime,
    sendFCM: _note.sendFCM,
    noteType: _note.noteType,
    response: _note.response,
    responseTime: _note.responseTime,
    buttons: _note.buttons,
  );

}
// -----------------------------------------------------------------------------

/// SEND

// -------------------------------
Future<void> onSendNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required ValueNotifier<UserModel> reciever,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ValueNotifier<UserModel> selectedReciever,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ValueNotifier<dynamic> selectedSenderModel,
}) async {

  final bool _formIsValid = formKey.currentState.validate();

  if (_formIsValid == true){

    final bool _confirmSend = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Send ?',
      body: 'Do you want to confirm sending this notification to ${reciever.value.name}',
      boolDialog: true,
    );

    if (_confirmSend == true){

      blog('should send note naaaaaw');

      await _modifyAttachmentIfFile(
        context: context,
        note: note,
      );

      final NoteModel _finalNoteModel = note.value.copyWith(
        sentTime: DateTime.now(),
      );

      await NoteFireOps.createNote(
        context: context,
        noteModel: _finalNoteModel,
      );

      /// TASK : SHOULD VISIT THIS onSendNoteOps thing
      /// MAYBE SAVE A REFERENCE OF THIS NOTE ID SOMEWHERE ON SUB DOC OF BZ
      /// TO BE EASY TO TRACE AND DELETE WHILE IN DELETE BZ OPS

      await TopDialog.showTopDialog(
        context: context,
        firstLine: 'Note Sent',
        secondLine: 'Alf Mabrouk ya5oya',
      );

      _clearNote(
        context: context,
        note: note,
        titleController: titleController,
        bodyController: bodyController,
        selectedSenderModel: selectedSenderModel,
        selectedSenderType: selectedSenderType,
        selectedReciever: selectedReciever,
      );

      /// FAILED SCENARIO
      //   if (result == true) {
      //
      //     await CenterDialog.showCenterDialog(
      //       context: context,
      //       title: 'Done',
      //       body: 'Notification has been sent to $_userName',
      //     );
      //
      //   }


    }

  }

}
// -------------------------------
Future<void> _modifyAttachmentIfFile({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}) async {

  if (note != null && objectIsFile(note.value.attachment) == true){

      final String _id = '${Numeric.createUniqueID()}';

    final String _url = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: note.value.attachment,
      picName: _id,
      docName: StorageDoc.notesBanners,
      ownerID: _concludeImageOwnerID(note.value),
    );

    if (_url != null){
      note.value = note.value.copyWith(
        attachment: _url,
      );
    }

  }

}
// -------------------------------
String _concludeImageOwnerID(NoteModel noteModel){

  String _ownerID;

  if (noteModel.noteSenderType == NoteSenderType.bz){
    _ownerID = noteModel.senderID;
  }
  else if (noteModel.noteSenderType == NoteSenderType.user){
    _ownerID = noteModel.senderID;
  }
  else if (noteModel.noteSenderType == NoteSenderType.country){
    _ownerID = noteModel.senderID;
  }
  else if (noteModel.noteSenderType == NoteSenderType.bldrs){
  _ownerID = noteModel.senderID;
  }

  return _ownerID;
}

void _clearNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ValueNotifier<UserModel> selectedReciever,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ValueNotifier<dynamic> selectedSenderModel,
}){
  note.value = createInitialNote(context);
  titleController.clear();
  bodyController.clear();
  selectedReciever.value = null;
  selectedSenderType.value = NoteSenderType.bldrs;
  selectedSenderModel.value = null;

}
// -----------------------------------------------------------------------------
