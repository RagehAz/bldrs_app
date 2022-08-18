import 'dart:async';
import 'dart:io';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/e_saves/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_controllers/h_zoning_controllers/zoning_controllers.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/helper_screens/search_bzz_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/helper_screens/search_users_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/d_notes_creator/helper_screens/template_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------
/// TESTED : WORKS PERFECT
void initializeVariables({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}){
  final NoteModel _initialNote = createInitialNote(context);
  note.value = _initialNote;
}
// -------------------------------
/// TESTED : WORKS PERFECT
NoteModel createInitialNote(BuildContext context) {

  final NoteModel _noteModel = NoteModel(
    id: null,
    senderID: NoteModel.bldrsSenderModel.key,
    senderImageURL: NoteModel.bldrsSenderModel.value,
    noteSenderType: null,
    receiverID: null,
    receiverType: null,
    title: null,
    body: null,
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    attachment: null,
    attachmentType: NoteAttachmentType.non,
    seen: false,
    seenTime: null,
    sendFCM: false,
    noteType: NoteType.announcement,
    response: null,
    responseTime: null,
    buttons: null,
    token: null,
  );

  return _noteModel;
}
// -----------------------------------------------------------------------------

/// NOTE TYPE

// -------------------------------
/// TESTED : WORKS PERFECT
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
        receiverType: null,
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
        token: _old.token,
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

// /// TESTED : WORKS PERFECT
// Future<void> onSelectNoteReceiverTap({
//   @required BuildContext context,
//   @required ValueNotifier<UserModel> receiver,
//   @required ValueNotifier<NoteModel> note,
// }) async {
//
//   Keyboarders.closeKeyboard(context);
//
//   final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
//       context: context,
//       screen: const SearchUsersScreen(
//         excludeMyself: false,
//         // multipleSelection: false,
//         // selectedUsers: null,
//       ),
//   );
//
//     if (Mapper.checkCanLoopList(_selectedUsers) == true){
//       receiver.value = _selectedUsers.first;
//       note.value = note.value.copyWith(
//         receiverID: _selectedUsers.first.id,
//       );
//     }
//
// }
// -------------------------------

Future<void> onSelectReceiverType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteReceiverType receiverType,
}) async {

  String _receiverID;

  /// if user
  if (receiverType == NoteReceiverType.user){
    _receiverID = await _onSelectUserAsNoteReceiver(
      context: context,
    );
  }

  /// if bz
  else {
    _receiverID = await _onSelectBzAsNoteReceiver(
      context: context,
    );
  }

  if (_receiverID != null){
    note.value = note.value.copyWith(
        receiverType: receiverType,
        receiverID: _receiverID,
    );
  }

}
// -------------------------------

Future<String> _onSelectUserAsNoteReceiver({
  @required BuildContext context,
}) async {
  String _userID;

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
    context: context,
    screen: const SearchUsersScreen(
      userIDsToExcludeInSearch: <String>[],
    ),
  );

  final bool _newSelection = Mapper.checkCanLoopList(_selectedUsers);
  if (_newSelection == true) {

    final UserModel _userModel = _newSelection == true ?
    _selectedUsers.first
        :
    null;

    _userID = _userModel?.id;

  }

  return _userID;
}
// -------------------------------

  Future<String> _onSelectBzAsNoteReceiver({
    @required BuildContext context,
  }) async {
  String _bzID;

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  final bool _newSelection = Mapper.checkCanLoopList(_bzModels);
  if (_newSelection == true){

    final BzModel _bzModel = Mapper.checkCanLoopList(_bzModels) == true ?
    _bzModels.first
        :
    null;

    _bzID = _bzModel?.id;

  }


  return _bzID;
}
// -------------------------------
/// TESTED : WORKS PERFECT
void deleteSelectedReciever({
  @required ValueNotifier<UserModel> selectedUser,
}){

  selectedUser.value = null;

}
// -----------------------------------------------------------------------------

/// BODY AND TITLE

// -------------------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> _onSelectUserAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ValueNotifier<NoteModel> note,
  @required NoteSenderType senderType,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
}) async {

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
    context: context,
    screen: const SearchUsersScreen(
      userIDsToExcludeInSearch: [],
    ),
  );

  final bool _newSelection = Mapper.checkCanLoopList(_selectedUsers);
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
/// TESTED : WORKS PERFECT
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

  final bool _newSelection = Mapper.checkCanLoopList(_bzModels);
  if (_newSelection == true){

    final BzModel _bzModel = Mapper.checkCanLoopList(_bzModels) == true ?
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
/// TESTED : WORKS PERFECT
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

    final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
      context: context,
      countryID: _zoneModel.countryID,
    );


    selectedSenderModel.value = _countryModel;
    selectedSenderType.value = senderType;
    note.value = note.value.copyWith(
      senderID: _countryModel.id,
      senderImageURL: Flag.getFlagIcon(_countryModel.id),
      noteSenderType: senderType,
    );

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
void onAddNoteButton({
  @required ValueNotifier<NoteModel> note,
  @required String button,
}){

  final List<String> _updatedButtons = Stringer.addOrRemoveStringToStrings(
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> _onSelectBzAsAttachment({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  final List<BzModel> _bzModels = await Nav.goToNewScreen(
    context: context,
    screen: const SearchBzzScreen(),
  );

  final bool _newSelection = Mapper.checkCanLoopList(_bzModels);
  if (_newSelection == true){

    final BzModel _bzModel = Mapper.checkCanLoopList(_bzModels) == true ?
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
/// TESTED :
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

  final bool _newSelection = Mapper.checkCanLoopList(_selectedFlyers);
  if (_newSelection == true){

    _ids = FlyerModel.getFlyersIDsFromFlyers(_selectedFlyers);

    note.value = note.value.copyWith(
      attachmentType: attachmentType,
      attachment: _ids,
    );

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> _onSelectImageURLAsAttachment({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NoteAttachmentType attachmentType,
}) async {

  final File _file = await Imagers.pickAndCropSingleImage(
    context: context,
    cropAfterPick: true,
    isFlyerRatio: false,
    resizeToWidth: Standards.noteAttachmentWidthPixels,
  );

  // final ImageSize _picSize = await ImageSize.superImageSize(_pic);
  // final double _picViewHeight = ImageSize.concludeHeightByGraphicSizes(
  //   width: NoteCard.bodyWidth(context),
  //   graphicWidth: _picSize.width,
  //   graphicHeight: _picSize.height,
  // );

  note.value = note.value.copyWith(
    attachmentType: attachmentType,
    attachment: _file,
  );

}
// -------------------------------
/// TESTED : WORKS PERFECT
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
    receiverType: _note.receiverType,
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
    token: _note.token,
  );

}
// -----------------------------------------------------------------------------

/// SEND

// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSendNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required String receiverName,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ValueNotifier<dynamic> selectedSenderModel,
  @required ScrollController scrollController,
}) async {

  final bool _formIsValid = formKey.currentState.validate();

  if (_formIsValid == true){

    final bool _confirmSend = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Send ?',
      body: 'Do you want to confirm sending this notification to $receiverName : ( ${note.value.receiverType} )',
      boolDialog: true,
    );

    if (_confirmSend == true){

      // blog('should send note naaaaaw');

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

      _clearNote(
        context: context,
        note: note,
        titleController: titleController,
        bodyController: bodyController,
        selectedSenderModel: selectedSenderModel,
        selectedSenderType: selectedSenderType,
      );

      await Scrollers.scrollToTop(
          controller: scrollController,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstLine: 'Note Sent',
        secondLine: 'Alf Mabrouk ya5oya',
      ));

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
/// TESTED : WORKS PERFECT
Future<void> _modifyAttachmentIfFile({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}) async {

  if (note != null && ObjectChecker.objectIsFile(note.value.attachment) == true){

      final String _id = '${Numeric.createUniqueID()}';

    final String _url = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: note.value.attachment,
      fileName: _id,
      docName: StorageDoc.notesBanners,
      ownersIDs: _concludeImageOwnersIDs(note.value),
    );

    if (_url != null){
      note.value = note.value.copyWith(
        attachment: _url,
      );
    }

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
List<String> _concludeImageOwnersIDs(NoteModel noteModel){

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

  return <String>[_ownerID];
}
// -------------------------------
/// TESTED : WORKS PERFECT
void _clearNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ValueNotifier<dynamic> selectedSenderModel,
}){
  note.value = createInitialNote(context);
  titleController.clear();
  bodyController.clear();
  selectedSenderType.value = NoteSenderType.bldrs;
  selectedSenderModel.value = null;

}
// -----------------------------------------------------------------------------

/// DELETE NOTE (ALL NOTES PAGINATOR SCREEN)

// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteNote({
  @required BuildContext context,
  @required NoteModel noteModel,
  // @required ValueNotifier<List<NoteModel>> notes,
  @required ValueNotifier<bool> loading,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete Note ?',
    body: 'Will Delete on Database and can never be recovered',
    boolDialog: true,
  );

  if (_result == true){

    Nav.goBack(
      context: context,
      invoker: 'onDeleteNote',
    );
    loading.value = true;

    /// DELETE ATTACHMENT IF IMAGE
    if (noteModel.attachmentType == NoteAttachmentType.imageURL){

      final String _picName = await Storage.getImageNameByURL(
        context: context,
        url: noteModel.attachment,
      );

      await Storage.deleteStoragePic(
          context: context,
          storageDocName: StorageDoc.notesBanners,
          fileName: _picName,
      );

    }

    /// DELETE ON FIRESTORE
    await NoteFireOps.deleteNote(
      context: context,
      noteID: noteModel.id,
    );

    /// DELETE LOCALLY
    // final List<NoteModel> _newList = NoteModel.removeNoteFromNotes(
    //   notes: notes.value,
    //   noteModel: noteModel,
    // );
    // notes.value = _newList;

    loading.value = false;

    /// SHOW CONFIRMATION DIALOG
    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Note Deleted',
      secondLine: 'Tamam keda',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------

/// TEMPLATE NOTES

// -------------------------------
Future<void> onGoToNoteTemplatesScreen({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ValueNotifier<NoteSenderType> selectedSenderType,
  @required ScrollController scrollController,
  @required ValueNotifier<dynamic> selectedSenderModel,
}) async {

  final NoteModel _templateNote = await Nav.goToNewScreen(
    context: context,
    screen: const TemplateNotesScreen(),
    transitionType: PageTransitionType.rightToLeft,
  );

  if (_templateNote != null){

    note.value = _templateNote;
    titleController.text = _templateNote.title;
    bodyController.text = _templateNote.body;
    selectedSenderType.value = _templateNote.noteSenderType;
    selectedSenderModel.value = null;

    await Scrollers.scrollToTop(
      controller: scrollController,
    );

  }

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectNoteTemplateTap({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  Nav.goBack(
      context: context,
      invoker: 'onSelectNoteTemplateTap',
      passedData: noteModel,
  );

}
// -------------------------------
