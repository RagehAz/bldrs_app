import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/d_user/d_user_search_screen/search_users_screen.dart';
import 'package:bldrs/b_views/f_bz/g_search_bzz_screen/search_bzz_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _showEthicalConfirmationDialog({
  @required BuildContext context,
  @required PartyType senderType,
}) async {

  bool _canContinue = true;

  if (
  senderType == PartyType.bz
      ||
      senderType == PartyType.user
  ){

    final String _senderTypeString = NoteParties.cipherPartyType(senderType);

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
/// TESTED : WORKS PERFECT
Future<void> onSelectNoteSender({
  @required BuildContext context,
  @required PartyType senderType,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required bool mounted,
}) async {

  final bool _continue = await _showEthicalConfirmationDialog(
    context: context,
    senderType: senderType,
  );

  if (_continue == true){

    /// BY USER
    if (senderType == PartyType.user){

      await _onSelectUserAsNoteSender(
        context: context,
        note: noteNotifier,
        senderType: senderType,
        mounted: mounted,
      );

    }

    /// BY BZ
    if (senderType == PartyType.bz){
      await _onSelectBzAsNoteSender(
        context: context,
        note: noteNotifier,
        senderType: senderType,
        mounted: mounted,
      );
    }

    /// BY COUNTRY
    if (senderType == PartyType.country){
      await _onSelectCountryAsNoteSender(
        context: context,
        note: noteNotifier,
        senderType: senderType,
        mounted: mounted,
      );
    }

    if (senderType == PartyType.bldrs){
      await _onSelectBldrsAsNoteSender(
        context: context,
        note: noteNotifier,
        senderType: senderType,
        mounted: mounted,
      );
    }
  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onSelectUserAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PartyType senderType,
  @required bool mounted,
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

    setNotifier(
        notifier: note,
        mounted: mounted,
        value: note.value.copyWith(
          parties: note.value.parties.copyWith(
            senderID: _userModel.id,
            senderImageURL: _userModel.picPath,
            senderType: senderType,
          ),
        )
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onSelectBzAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PartyType senderType,
  @required bool mounted,
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

    setNotifier(
        notifier: note,
        mounted: mounted,
        value: note.value.copyWith(
          parties: note.value.parties.copyWith(
            senderID: _bzModel.id,
            senderImageURL: _bzModel.logoPath,
            senderType: senderType,
          ),
        )
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onSelectCountryAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PartyType senderType,
  @required bool mounted,
}) async {

  final ZoneModel _zoneModel = await ZoneSelection.goBringAZone(
    context: context,
    zoneViewingEvent: ViewingEvent.admin, // so can select any country
    settingCurrentZone: false,
    depth: ZoneDepth.district,
  );

  final bool _newSelection =_zoneModel != null;
  if (_newSelection == true){

    final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
      countryID: _zoneModel.countryID,
    );

    setNotifier(
        notifier: note,
        mounted: mounted,
        value: note.value.copyWith(
          parties: note.value.parties.copyWith(
            senderID: _countryModel.id,
            senderImageURL: Flag.getCountryIcon(_countryModel.id), /// TASK : THIS BRINGS LOCAL PATH,, ARE YOU SURE ? IT WANTS A URL MAN
            senderType: senderType,
          ),
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onSelectBldrsAsNoteSender({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> note,
  @required PartyType senderType,
  @required bool mounted,
}) async {


  setNotifier(
      notifier: note,
      mounted: mounted,
      value:  note.value.copyWith(
        parties: note.value.parties.copyWith(
          senderID: NoteParties.bldrsSenderID,
          senderImageURL: NoteParties.bldrsLogoStaticURL,
          senderType: senderType,
        ),
      )
  );

}
// -----------------------------------------------------------------------------

/// RECEIVER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectReceiverType({
  @required BuildContext context,
  @required ValueNotifier<NoteModel> noteNotifier,
  @required PartyType selectedReceiverType,
  @required ValueNotifier<List<dynamic>> receiversModels,
  @required bool mounted,
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
      invertButtons: true,
    );

  }

  if (_go == true){

    if (_typeHasChanged == true){

      setNotifier(
          notifier: receiversModels,
          mounted: mounted,
          value: [],
      );

      setNotifier(
          notifier: noteNotifier,
          mounted: mounted,
          value: noteNotifier.value.nullifyField(topic: true),
      );

    }

    /// IF USER
    if (selectedReceiverType == PartyType.user){
      final List<UserModel> _users = [...receiversModels.value ?? []];
      _models = await onSelectUserAsNoteReceiver(
        context: context,
        selectedUsers: _users,
      );
    }
    /// IF BZ
    else {
      final List<BzModel> _bzz = [...receiversModels.value];
      _models = await onSelectBzAsNoteReceiver(
        context: context,
        selectedBzz: _bzz,
      );
    }

    /// WHEN NOTHING IS SELECTED
    if (_models.isEmpty == true){

      clearReceivers(
        receiversModels: receiversModels,
        noteNotifier: noteNotifier,
        mounted: mounted,
      );

    }
    /// WHEN SELECTED MODELS
    else {

      final NoteParties _newParties = noteNotifier.value.parties.copyWith(
        receiverType: selectedReceiverType,
        receiverID: 'xxx',
      );

      setNotifier(
          notifier: noteNotifier,
          mounted: mounted,
          value: _newParties,
      );

      setNotifier(
          notifier: receiversModels,
          mounted: mounted,
          value: _models,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<List<UserModel>> onSelectUserAsNoteReceiver({
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
Future<List<BzModel>> onSelectBzAsNoteReceiver({
  @required BuildContext context,
  @required List<BzModel> selectedBzz,
}) async {

  List<BzModel> _bzz = <BzModel>[];

  final List<BzModel> _bzzModels = await Nav.goToNewScreen(
    context: context,
    screen: SearchBzzScreen(
      // multipleSelection: false,
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
  @required bool mounted,
}){

  setNotifier(
      notifier: noteNotifier,
      mounted: mounted,
      value: noteNotifier.value.copyWith(
        parties: noteNotifier.value.parties.nullifyField(
          receiverType: true,
          receiverID: true,
        ),
      ),
  );

  setNotifier(
      notifier: receiversModels,
      mounted: mounted,
      value: [],
  );

}
// -----------------------------------------------------------------------------

/// VALIDATORS
///
// --------------------
/// TESTED : WORKS PERFECT
String noteSenderValidator(NoteModel note){
  String _message;

  /// NOTE IS NULL
  if (note == null){
    _message = 'Note is null';
  }

  /// NO SENDER SELECTED
  else if (note?.parties?.senderID == null){
    _message = 'Select a sender';
  }

  /// NO SENDER TYPE
  else if (note?.parties?.senderType == null){
    _message = 'SenderType is null';
  }

  /// IMAGE IN NULL
  else if (note?.parties?.senderImageURL == null){
    _message = 'Sender pic is null';
  }

  /// OTHERWISE
  else {

    // _message ??= NoteModel.senderVsNoteTypeValidator(
    //     senderType: note?.senderType,
    //     noteType: note?.type,
    // );

    _message ??= NoteModel.receiverVsSenderValidator(
        senderType: note?.parties?.senderType,
        receiverType: note?.parties?.receiverType
    );

  }

  return _message;
}
// --------------------
/// TESTED : WORKS PERFECT
String noteRecieverValidator(NoteModel note){
  String _message;

  /// NOTE IS NULL
  if (note == null){
    _message = 'Note is null';
  }

  /// NO SENDER SELECTED
  else if (note?.parties?.receiverID == null){
    _message = 'Select a receiver';
  }

  /// NO SENDER TYPE
  else if (note?.parties?.receiverType == null){
    _message = 'Receiver type is null';
  }

  /// OTHERWISE
  else {

    // _message ??= NoteModel.receiverVsNoteTypeValidator(
    //     receiverType: note?.receiverType,
    //     noteType: note?.type,
    // );

    _message ??= NoteModel.receiverVsSenderValidator(
        senderType: note?.parties?.senderType,
        receiverType: note?.parties?.receiverType
    );

  }

  return _message;
}
// --------------------
/*
  List<Verse> _getNotTypeBulletPoints(NoteType noteType){

    // /// NOTHING SELECTED
    // if (noteType == null){
    //   return <Verse>[];
    // }
    //
    // /// NOTICE
    // else if (noteType == NoteType.notice){
    //   return <Verse>[
    //     const Verse(
    //       text: 'Notice note : is the default type of notes',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// AUTHORSHIP
    // else if (noteType == NoteType.authorship){
    //   return <Verse>[
    //     const Verse(
    //       text: 'Authorship note : is when business invites user to become an author in the team',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// FLYER UPDATE
    // else if (noteType == NoteType.flyerUpdate){
    //   return <Verse>[
    //     const Verse(
    //       text: 'FlyerUpdate note : is when an author updates a flyer, note is sent to his bz',
    //       translate: false,
    //     ),
    //     const Verse(
    //       text: 'This fires [reFetchFlyer] mesh faker esm el protocol',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// BZ DELETION
    // else if (noteType == NoteType.bzDeletion){
    //   return <Verse>[
    //     const Verse(
    //       text: 'bzDeletion note : is when an author deletes his bz, all authors team receive this',
    //       translate: false,
    //     ),
    //     const Verse(
    //       text: 'This fires [deleteBzLocally] protocol, bardo mesh faker esm el protocol awy delwa2ty',
    //       translate: false,
    //     ),
    //   ];
    // }
    //
    // /// OTHERWISE
    // else {
    //   return null;
    // }

  }
   */
// --------------------
/*
  String _noteTypeValidator(NoteModel note){
    String _message;

    /// NOTE NULL
    if (note == null){
      _message = 'Note is null';
    }

    /// TYPE IS NULL
    else if (note?.type == null){
      _message = 'Select note type';
    }

    /// OTHERWISE
    else {

      _message ??= NoteModel.receiverVsNoteTypeValidator(
          receiverType: note?.receiverType,
          noteType: note?.type,
      );

      _message ??= NoteModel.senderVsNoteTypeValidator(
          senderType: note?.senderType,
        noteType: note?.type,
      );

    }

    return _message;
  }
   */
// -----------------------------------------------------------------------------
