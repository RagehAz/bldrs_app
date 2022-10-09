import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/a_models/d_zone/flag_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/a_models/e_notes/aa_poster_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/f_bz/g_search_bzz_screen/search_bzz_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zoning_controllers.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/a_notes_lab_home.dart';
import 'package:bldrs/x_dashboard/l_notes_creator/x_lab/note_templates/a_template_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeVariables({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}){
  note.value = _createInitialNote(context);
}
// --------------------
/// TESTED : WORKS PERFECT
NoteModel _createInitialNote(BuildContext context) {

  return NoteModel(
    id: null,
    parties: const NoteParties(
      senderID: null, //NoteModel.bldrsSenderModel.key,
      senderImageURL: null, //NoteModel.bldrsSenderModel.value,
      senderType: null,
      receiverID: null,
      receiverType: null,
    ),
    title: null,
    body: null,
    metaData: NoteModel.defaultMetaData,
    sentTime: DateTime.now(),
    trigger: null,
    poster: null,
    sendFCM: false,
    poll: null,
    token: null,
    topic: null,
    seen: false,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onNoteCreatorCardOptionsTap({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ScrollController scrollController,
}) async {

  // await BottomDialog.showButtonsBottomDialog(
  //     context: context,
  //     draggable: true,
  //     numberOfWidgets: 2,
  //     titleVerse: const Verse(
  //       text: 'phid_options',
  //       translate: true,
  //     ),
  //     buttonHeight: 50,
  //     builder: (_){
  //
  //       return <Widget>[
  //
  //
  //
  //       ];
  //
  //     }
  // );

}
// -----------------------------------------------------------------------------

/// NOTE RECEIVER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectReceiverType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required NotePartyType selectedReceiverType,
  @required ValueNotifier<List<dynamic>> receiversModels,
}) async {
  List<dynamic> _models = [];
  bool _go = true;

  final bool _typeHasChanged = noteNotifier.value.parties.receiverType != selectedReceiverType;

  /// CHECK WHEN TYPE IS CHANGED & WHEN ALREADY HAVE SELECTED MODELS
  if (
      _typeHasChanged == true
      &&
      receiversModels.value.isNotEmpty
  ){

    _go = await Dialogs.confirmProceed(
      context: context,
      titleVerse: Verse.plain('Remove selected'),
      bodyVerse: Verse.plain('This will clear all selected receivers'),
    );

  }

  if (_go == true){

    if (_typeHasChanged == true){
      receiversModels.value = [];
    }

    /// IF USER
    if (selectedReceiverType == NotePartyType.user){
      final List<UserModel> _users = [...receiversModels.value ?? []];
      _models = await _onSelectUserAsNoteReceiver(
        context: context,
        selectedUsers: _users,
      );
    }
    /// IF BZ
    else {
      final List<BzModel> _bzz = [...receiversModels.value];
      _models = await _onSelectBzAsNoteReceiver(
        context: context,
        selectedBzz: _bzz,
      );
    }

    /// WHEN NOTHING IS SELECTED
    if (_models.isEmpty == true){

      clearReceivers(
        receiversModels: receiversModels,
        noteNotifier: noteNotifier,
      );

    }
    /// WHEN SELECTED MODELS
    else {

      noteNotifier.value = noteNotifier.value.copyWith(
        parties: noteNotifier.value.parties.copyWith(
          receiverType: selectedReceiverType,
          receiverID: 'xxx',
        ),
      );

      receiversModels.value = _models;

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<UserModel>> _onSelectUserAsNoteReceiver({
  @required BuildContext context,
  @required List<UserModel> selectedUsers,
}) async {

  final List<UserModel> _selectedUsers = await Nav.goToNewScreen(
    context: context,
    screen: SearchUsersScreen(
      userIDsToExcludeInSearch: const <String>[],
      multipleSelection: true,
      selectedUsers: await UserProtocols.fetchUsers(
          context: context,
          usersIDs: UserModel.getUsersIDs(selectedUsers),
      ),
    ),
  );

  if (Mapper.checkCanLoopList(_selectedUsers) == true) {
    return _selectedUsers;
  }

  else {
    return [];
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<BzModel>> _onSelectBzAsNoteReceiver({
  @required BuildContext context,
  @required List<BzModel> selectedBzz,
}) async {

  List<BzModel> _bzz = <BzModel>[];

  final List<BzModel> _bzzModels = await Nav.goToNewScreen(
    context: context,
    screen: SearchBzzScreen(
      multipleSelection: true,
      selectedBzz: selectedBzz,
    ),
  );

  if (Mapper.checkCanLoopList(_bzzModels) == true){

    _bzz = _bzzModels;

  }

  return _bzz;
}
// --------------------
/// TESTED : WORKS PERFECT
void clearReceivers({
  @required ValueNotifier<List<dynamic>> receiversModels,
  @required ValueNotifier<NoteModel> noteNotifier,
}){

  noteNotifier.value = noteNotifier.value.copyWith(
    parties: noteNotifier.value.parties.nullifyField(
      receiverType: true,
      receiverID: true,
    ),
  );

  receiversModels.value = [];

}
// -----------------------------------------------------------------------------

/// BODY AND TITLE

// --------------------
///
void onTitleChanged({
  @required String text,
  @required ValueNotifier<NoteModel> note,
}){

  final NoteModel _updated = note.value.copyWith(
    title: text,
  );

  note.value = _updated;
}
// --------------------
///
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

// --------------------
/// TESTED :
Future<void> onSelectNoteSender({
  @required BuildContext context,
  @required NotePartyType senderType,
  @required ValueNotifier<NoteModel> note,
}) async {

  final bool _continue = await _showEthicalConfirmationDialog(
    context: context,
    senderType: senderType,
  );

  if (_continue == true){

    /// BY USER
    if (senderType == NotePartyType.user){

      await _onSelectUserAsNoteSender(
        context: context,
        note: note,
        senderType: senderType,
      );

    }

    /// BY BZ
    if (senderType == NotePartyType.bz){
      await _onSelectBzAsNoteSender(
        context: context,
        note: note,
        senderType: senderType,
      );
    }

    /// BY COUNTRY
    if (senderType == NotePartyType.country){
      await _onSelectCountryAsNoteSender(
        context: context,
        note: note,
        senderType: senderType,
      );
    }

    if (senderType == NotePartyType.bldrs){
      await _onSelectBldrsAsNoteSender(
        context: context,
        note: note,
        senderType: senderType,
      );
    }
  }


}
// --------------------
/// TESTED :
Future<bool> _showEthicalConfirmationDialog({
  @required BuildContext context,
  @required NotePartyType senderType,
}) async {

  bool _canContinue = true;

  if (
      senderType == NotePartyType.bz
      ||
      senderType == NotePartyType.user
  ){

    final String _senderTypeString = NoteParties.cipherNoteSenderOrRecieverType(senderType);

    _canContinue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Ethical Alert'),
      bodyVerse: Verse.plain('Sending Notes on behalf of a $_senderTypeString '
          "is kind of little bit unethical, isn't it ?\n"
          'Anyways, Would you like to continue ?'),
      boolDialog: true,
      confirmButtonVerse: Verse.plain('Fuck Yeah'),
    );

  }

  return _canContinue;
}
// --------------------
/// TESTED :
Future<void> _onSelectUserAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NotePartyType senderType,
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

    note.value = note.value.copyWith(
      parties: note.value.parties.copyWith(
        senderID: _userModel.id,
        senderImageURL: _userModel.pic,
        senderType: senderType,
      ),
    );

  }

}
// --------------------
/// TESTED :
Future<void> _onSelectBzAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NotePartyType senderType,
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
      parties: note.value.parties.copyWith(
        senderID: _bzModel.id,
        senderImageURL: _bzModel.logo,
        senderType: senderType,
      ),
    );

  }

}
// --------------------
/// TESTED :
Future<void> _onSelectCountryAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NotePartyType senderType,
}) async {

  final ZoneModel _zoneModel = await controlSelectCountryOnly(context);

  final bool _newSelection =_zoneModel != null;
  if (_newSelection == true){

    final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
      context: context,
      countryID: _zoneModel.countryID,
    );

    note.value = note.value.copyWith(
      parties: note.value.parties.copyWith(
        senderID: _countryModel.id,
        senderImageURL: Flag.getFlagIcon(_countryModel.id),
        senderType: senderType,
      ),
    );

  }

}
// --------------------
/// TESTED :
Future<void> _onSelectBldrsAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required NotePartyType senderType,
}) async {

  note.value = note.value.copyWith(
    parties: note.value.parties.copyWith(
      senderID: NoteParties.bldrsSenderID,
      senderImageURL: NoteParties.bldrsLogoStaticURL,
      senderType: senderType,
    ),
  );

}
// -----------------------------------------------------------------------------

/// SEND FCM SWITCH

// --------------------
///
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

// --------------------
///
void onAddNoteButton({
  @required ValueNotifier<NoteModel> note,
  @required String button,
}){

  // final List<String> _updatedButtons = Stringer.addOrRemoveStringToStrings(
  //   strings: note.value?.poll?.buttons,
  //   string: button,
  // );
  //
  // NoteModel _note = note.value.copyWith(
  //   poll: _updatedButtons,
  // );
  //
  // _note = _note.nullifyField(
  //   poll: true,
  // );
  //
  // note.value = _note;

}
// -----------------------------------------------------------------------------

/// ATTACHMENTS

// --------------------
/// TESTED :
Future<void> onSelectPosterType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PosterType posterType,
}) async {

  /// NO ATTACHMENT
  if (posterType == null){
    _onClearPoster(
      note: note,
    );
  }

  /// BZ ID
  else if (posterType == PosterType.bz){
    await _onAddBzToPoster(
      context: context,
      note: note,
      posterType: posterType,
    );
  }

  /// FLYERS IDS
  else if (posterType == PosterType.flyer){
    await _onAddFlyerToPoster(
      context: context,
      note: note,
      posterType: posterType,
    );
  }

  /// IMAGE
  else if (posterType == PosterType.image){
    await _onAddImageToPoster(
      context: context,
      note: note,
      posterType: posterType,
    );
  }
  else {
    _onClearPoster(
      note: note,
    );
  }

}
// --------------------
/// TESTED :
Future<void> _onAddBzToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PosterType posterType,
}) async {

  // final List<BzModel> _bzModels = await Nav.goToNewScreen(
  //   context: context,
  //   screen: const SearchBzzScreen(),
  // );
  //
  // final bool _newSelection = Mapper.checkCanLoopList(_bzModels);
  // if (_newSelection == true){
  //
  //   final BzModel _bzModel = Mapper.checkCanLoopList(_bzModels) == true ?
  //   _bzModels.first
  //       :
  //   null;
  //
  //   note.value = note.value.copyWith(
  //     poster: PosterModel(
  //       type: posterType,
  //       id: _bzModel.id,
  //       url: null,
  //     ),
  //
  //   );
  //
  // }

}
// --------------------
/// TESTED :
Future<void> _onAddFlyerToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PosterType posterType,
}) async {

  // final List<FlyerModel> _selectedFlyers = await Nav.goToNewScreen(
  //   context: context,
  //   screen: const SavedFlyersScreen(
  //     selectionMode: true,
  //   ),
  // );
  //
  // if (Mapper.checkCanLoopList(_selectedFlyers) == true){
  //
  //   note.value = note.value.copyWith(
  //     poster: PosterModel(
  //       type: posterType,
  //       id: _selectedFlyers.first.id,
  //       url: null,
  //     ),
  //   );
  //
  // }

}
// --------------------
///
Future<void> _onAddImageToPoster({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PosterType posterType,
}) async {

  // final FileModel _fileModel = await Imagers.pickAndCropSingleImage(
  //   context: context,
  //   cropAfterPick: true,
  //   aspectRatio: NotePosterBox.getAspectRatio(),
  //   resizeToWidth: Standards.noteAttachmentWidthPixels,
  // );
  //
  // // final ImageSize _picSize = await ImageSize.superImageSize(_pic);
  // // final double _picViewHeight = ImageSize.concludeHeightByGraphicSizes(
  // //   width: NoteCard.bodyWidth(context),
  // //   graphicWidth: _picSize.width,
  // //   graphicHeight: _picSize.height,
  // // );
  //
  // if (_fileModel != null){
  //   note.value = note.value.copyWith(
  //     poster: PosterModel(
  //       type: posterType,
  //       id: _fileModel.file.fileNameWithExtension,
  //       url: null,
  //     ),
  //
  //   );
  // }

}
// --------------------
///
void _onClearPoster({
  @required ValueNotifier<NoteModel> note,
}){

  final NoteModel _note = note.value.nullifyField(
    poster: true,
  );

  note.value = _note;

}
// -----------------------------------------------------------------------------

/// SEND

// --------------------
///
Future<void> onSendNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required GlobalKey<FormState> formKey,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ScrollController scrollController,
  @required ValueNotifier<List<dynamic>> receiversModels,
}) async {

  blog('a77a? ');

  final bool _formIsValid = formKey.currentState.validate();

  if (_formIsValid == true){

    final String _receiverTypeString = note.value.parties.receiverType == NotePartyType.bz ? 'Bzz' : 'Users';

    final bool _confirmSend = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse.plain('Send ?'),
      bodyVerse: Verse.plain('Do you want to confirm sending this notification to ${receiversModels.value.length} $_receiverTypeString '),
      boolDialog: true,
    );

    if (_confirmSend == true){

      unawaited(WaitDialog.showWaitDialog(context: context));

      await _modifyPosterIfFile(
        context: context,
        note: note,
      );

      await NoteProtocols.compose(
        context: context,
        note: note.value,
      );

      // _clearNote(
      //   context: context,
      //   note: note,
      //   titleController: titleController,
      //   bodyController: bodyController,
      // );

      await WaitDialog.closeWaitDialog(context);

      await Scrollers.scrollToTop(
        controller: scrollController,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstVerse: Verse.plain('Note Sent'),
        secondVerse: Verse.plain('Alf Mabrouk ya5oya'),
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
// --------------------

Future<void> _modifyPosterIfFile({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
}) async {

  // if (note != null && ObjectCheck.objectIsFile(note.value.model) == true){
  //
  //   final String _id = '${Numeric.createUniqueID()}';
  //
  //   final String _url = await Storage.createStoragePicAndGetURL(
  //     context: context,
  //     inputFile: note.value.model,
  //     fileName: _id,
  //     docName: StorageDoc.notesBanners,
  //     ownersIDs: _concludeImageOwnersIDs(note.value),
  //   );
  //
  //   if (_url != null){
  //     note.value = note.value.copyWith(
  //       model: _url,
  //     );
  //   }
  //
  // }

}
// --------------------
///
List<String> _concludeImageOwnersIDs(NoteModel noteModel){

  String _ownerID;

  if (noteModel.parties.senderType == NotePartyType.bz){
    _ownerID = noteModel.parties.senderID;
  }
  else if (noteModel.parties.senderType == NotePartyType.user){
    _ownerID = noteModel.parties.senderID;
  }
  else if (noteModel.parties.senderType == NotePartyType.country){
    _ownerID = noteModel.parties.senderID;
  }
  else if (noteModel.parties.senderType == NotePartyType.bldrs){
    _ownerID = noteModel.parties.senderID;
  }

  return <String>[_ownerID];
}
// --------------------
/// TESTED : WORKS PERFECT
void clearNote({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
}){
  note.value = _createInitialNote(context);
  titleController.clear();
  bodyController.clear();

}
// -----------------------------------------------------------------------------

/// DELETE NOTE (ALL NOTES PAGINATOR SCREEN)

// --------------------
///
Future<void> onDeleteNote({
  @required BuildContext context,
  @required NoteModel noteModel,
  // @required ValueNotifier<List<NoteModel>> notes,
  @required ValueNotifier<bool> loading,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse.plain('Delete Note ?'),
    bodyVerse: Verse.plain('Will Delete on Database and can never be recovered'),
    boolDialog: true,
  );

  if (_result == true){

    await Nav.goBack(
      context: context,
      invoker: 'onDeleteNote',
    );
    loading.value = true;

    await NoteProtocols.wipeNote(
      context: context,
      note: noteModel,
    );

    loading.value = false;

    /// SHOW CONFIRMATION DIALOG
    await TopDialog.showTopDialog(
      context: context,
      firstVerse: Verse.plain('Note Deleted'),
      secondVerse: Verse.plain('Tamam keda'),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------

/// TEMPLATE NOTES

// --------------------

Future<void> onGoToNoteTemplatesScreen({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required TextEditingController titleController,
  @required TextEditingController bodyController,
  @required ScrollController scrollController,
  @required ValueNotifier<List<dynamic>> receiversModels,
}) async {

  final NoteModel _templateNote = await Nav.goToNewScreen(
    context: context,
    screen: const TemplateNotesScreen(),
    transitionType: PageTransitionType.rightToLeft,
  );

  if (_templateNote != null){

    receiversModels.value = await _getReceiversModelsByReceiversIDs(
      context: context,
      receiversIDs: <String>[_templateNote.parties.receiverID],
      partyType: _templateNote.parties.receiverType,
    );

    note.value = _templateNote;
    titleController.text = _templateNote.title;
    bodyController.text = _templateNote.body;

    await Scrollers.scrollToTop(
      controller: scrollController,
    );

  }

}
// --------------------
///
Future<List<dynamic>> _getReceiversModelsByReceiversIDs({
  @required BuildContext context,
  @required List<String> receiversIDs,
  @required NotePartyType partyType,
}) async {

  List<dynamic> _output = <dynamic>[];

  if (Mapper.checkCanLoopList(receiversIDs) == true){

    if (partyType == NotePartyType.user){
      _output = await UserProtocols.fetchUsers(
          context: context,
          usersIDs: receiversIDs,
      );
    }

    if (partyType == NotePartyType.bz){
      _output = await BzProtocols.fetchBzz(
          context: context,
          bzzIDs: receiversIDs
      );
    }

  }

  return _output;
}
// --------------------
///
Future<void> onSelectNoteTemplateTap({
  @required BuildContext context,
  @required NoteModel noteModel,
}) async {

  await Nav.goBack(
    context: context,
    invoker: 'onSelectNoteTemplateTap',
    passedData: noteModel,
  );

}
// -----------------------------------------------------------------------------

/// NOTES TESTING SCREEN

// --------------------
///
Future<void> onGoToNotesTestingScreen(BuildContext context) async {

  await Nav.goToNewScreen(
      context: context,
      screen: const NotesLabHome(),
  );

}
// -----------------------------------------------------------------------------
