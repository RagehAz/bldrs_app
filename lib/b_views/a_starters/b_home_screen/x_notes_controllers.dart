import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/note_protocols/b_trigger_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_streamer.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// OBELISK

// --------------------
/// TESTED : WORKS PERFECT
void initializeObeliskNumbers(BuildContext context){
  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  _notesProvider.generateSetInitialObeliskNumbers(
    context: context,
    notify: false,
  );
}
// -----------------------------------------------------------------------------

/// USER NOTES

// --------------------
///
StreamSubscription initializeUserNotes(BuildContext context){

  StreamSubscription _sub;

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  if (_userModel != null){

    /// TASK : STREAM NEEDS TO BE CLOSED WHEN DELETING USER
    final Stream<QuerySnapshot<Object>> _stream = userUnseenNotesStream(
        context: context
    );

    final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProUserUnseenReceivedNotes(
      context: context,
    );

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      invoker: 'initializeUserNotes',
      onChange: (List<Map<String, dynamic>> allUpdatedMaps) async {

        blog('initializeUserNote.onStreamDataChanged : new maps are ${allUpdatedMaps.length} maps');
        // Mapper.blogMaps(allUpdatedMaps, methodName: 'initializeUserNotes');

        final List<NoteModel> _notes = NoteModel.decipherNotes(
          maps: allUpdatedMaps,
          fromJSON: false,
        );

        _notesProvider.setUserNotesAndRebuild(
          context: context,
          notes: _notes,
          notify: true,
        );

        final bool _noteDotIsOn = _checkNoteDotIsOn(
          context: context,
          notes: _notes,
        );

        if (_noteDotIsOn == true){
          _notesProvider.setIsFlashing(
            setTo: true,
            notify: true,
          );
        }

        await TriggerProtocols.fireTriggers(
            context: context,
            notes: _notes,
        );

        // await _checkForBzDeletionNoteAndProceed(
        //   context: context,
        //   notes: _notes,
        // );

      },
    );

  }

  return _sub;
}
// --------------------
/// TESTED : WORKS PERFECT
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProUserUnseenReceivedNotes({
  @required BuildContext context,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _notesProvider.userNotes,
    toJSON: false,
  );

  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
// -----------------------------------------------------------------------------

/// BZZ NOTES STREAMS

// --------------------
/// TESTED : WORKS PERFECT
List<StreamSubscription> initializeMyBzzNotes(BuildContext context){

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);
  // blog('initializeMyBzzNotes : _userIsAuthor : $_userIsAuthor');

  if (_userIsAuthor == true){

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: false);

    for (final BzModel bzModel in _myBzz){

      final StreamSubscription _sub = _initializeBzNotesStream(
        context: context,
        bzID: bzModel.id,
      );

      _subs.add(_sub);

    }

  }

  return _subs;
}
// --------------------
/// TESTED : WORKS PERFECT
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProBzUnseenReceivedNotes ({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

  final List<NoteModel> _bzOldNotes = _notesProvider.myBzzNotes[bzID];

  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _bzOldNotes,
    toJSON: false,
  );

  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
// --------------------
/// TESTED : WORKS PERFECT
StreamSubscription _initializeBzNotesStream({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);


  final Stream<QuerySnapshot<Object>> _stream  = bzUnseenNotesStream(
    bzID: bzID,
  );

  // final _stream.listen((event) { });


  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProBzUnseenReceivedNotes(
    context: context,
    bzID: bzID,
  );

  final StreamSubscription _streamSubscription = FireCollStreamer.onStreamDataChanged(
    stream: _stream,
    oldMaps: _oldMaps,
    invoker: 'initializeBzNotesStream',
    onChange: (List<Map<String, dynamic>> allBzNotes) async {

      final List<NoteModel> _allBzNotes = NoteModel.decipherNotes(
        maps: allBzNotes,
        fromJSON: false,
      );

      _notesProvider.setBzNotesAndRebuildObelisk(
          context: context,
          bzID: bzID,
          notes: _allBzNotes,
          notify: true
      );

      final bool _noteDotIsOn = _checkNoteDotIsOn(
        context: context,
        notes: _allBzNotes,
      );

      if (_noteDotIsOn == true){
        _notesProvider.setIsFlashing(
          setTo: true,
          notify: true,
        );
      }

      await TriggerProtocols.fireTriggers(
        context: context,
        notes: _allBzNotes,
      );

      // await _bzCheckLocalFlyerUpdatesNotesAndProceed(
      //   context: context,
      //   newBzNotes: _allBzNotes,
      // );

    },
  );

  return _streamSubscription;
}
// -----------------------------------------------------------------------------

/// NOTES CHECKERS

// --------------------
/// TESTED : WORKS PERFECT
bool _checkNoteDotIsOn({
  @required BuildContext context,
  @required List<NoteModel> notes,
}){

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(_userModel);


  bool _isOn = false;

  if (_thereAreMissingFields == true){
    _isOn = true;
  }
  else {

    if (Mapper.checkCanLoopList(notes) == true){
      _isOn = NoteModel.checkThereAreUnSeenNotes(notes);
    }

  }

  return _isOn;
}
// --------------------
/*
// int _getNotesCount({
//   @required bool thereAreMissingFields,
//   @required List<NoteModel> notes,
// }){
//   int _count;
//
//   if (thereAreMissingFields == false){
//     if (Mapper.checkCanLoopList(notes) == true){
//       _count = NoteModel.getNumberOfUnseenNotes(notes);
//     }
//   }
//
//   return _count;
// }
 */
// -----------------------------------------------------------------------------
