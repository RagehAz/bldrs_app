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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// OBELISK

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeObeliskNumbers(BuildContext context) async {
  await NotesProvider.proInitializeObeliskBadges(
    context: context,
    notify: false,
  );
}
// -----------------------------------------------------------------------------

/// USER NOTES

// --------------------
///
StreamSubscription listenToUserUnseenNotes(BuildContext context){

  StreamSubscription _sub;

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  if (_userModel != null){

    /// TASK : STREAM NEEDS TO BE CLOSED WHEN DELETING USER
    final Stream<QuerySnapshot<Object>> _unseenNotesStream = userUnseenNotesStream(
        context: context
    );

    // final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProUserUnseenReceivedNotes(
    //   context: context,
    // );

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _unseenNotesStream,
      // oldMaps: _oldMaps,
      invoker: 'listenToUserUnseenNotes',
      onChange: (List<Map<String, dynamic>> unseenNotesMaps) async {

        // blog('initializeUserNote.onStreamDataChanged : new maps are ${allUpdatedMaps.length} maps');
        // Mapper.blogMaps(allUpdatedMaps, methodName: 'initializeUserNotes');

        final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
          maps: unseenNotesMaps,
          fromJSON: false,
        );

        await NotesProvider.proSetUserObeliskBadge(
          context: context,
          unseenNotes: _unseenNotes,
          notify: true,
        );

        concludeAndActivatePyramidsFlashing(
          context: context,
          unseenNotes: _unseenNotes,
        );

        await TriggerProtocols.fireTriggers(
            context: context,
            notes: _unseenNotes,
        );

        // await _checkForBzDeletionNoteAndProceed(
        //   context: context,
        //   notes: _unseenNotes,
        // );

      },
    );

  }

  return _sub;
}
// --------------------
/*
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
 */
// -----------------------------------------------------------------------------

/// BZZ NOTES STREAMS

// --------------------
/// TESTED : WORKS PERFECT
List<StreamSubscription> listenToMyBzzUnseenNotes(BuildContext context){

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);
  // blog('initializeMyBzzNotes : _userIsAuthor : $_userIsAuthor');

  if (_userIsAuthor == true){

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(context: context, listen: false);

    for (final BzModel bzModel in _myBzz){

      final StreamSubscription _sub = _listenToMyBzUnseenNotes(
        context: context,
        bzID: bzModel.id,
      );

      _subs.add(_sub);

    }

  }

  return _subs;
}
// --------------------
/// DEPRECATED
/*
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
 */
// --------------------
///
StreamSubscription _listenToMyBzUnseenNotes({
  @required BuildContext context,
  @required String bzID,
}){

  final Stream<QuerySnapshot<Object>> _bzUnseenNotesStream  = bzUnseenNotesStream(
    bzID: bzID,
  );

  final StreamSubscription _streamSubscription = FireCollStreamer.onStreamDataChanged(
    stream: _bzUnseenNotesStream,
    // oldMaps: _oldMaps,
    invoker: '_listenToMyBzUnseenNotes : bzID : $bzID',
    onChange: (List<Map<String, dynamic>> unseenNotesMaps) async {

      final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
        maps: unseenNotesMaps,
        fromJSON: false,
      );

      await NotesProvider.proSetBzObeliskBadge(
          context: context,
          bzID: bzID,
          unseenNotes: _unseenNotes,
          notify: true
      );

      concludeAndActivatePyramidsFlashing(
        context: context,
        unseenNotes: _unseenNotes,
      );

      await TriggerProtocols.fireTriggers(
        context: context,
        notes: _unseenNotes,
      );

      // await _bzCheckLocalFlyerUpdatesNotesAndProceed(
      //   context: context,
      //   newBzNotes: _unseenNotes,
      // );

    },
  );

  return _streamSubscription;
}
// -----------------------------------------------------------------------------

/// PYRAMIDS FLASHING

// --------------------
///
void concludeAndActivatePyramidsFlashing({
  @required BuildContext context,
  @required List<NoteModel> unseenNotes,
}){

  final bool _noteDotIsOn = _checkNoteDotIsOn(
    context: context,
    unseenNotes: unseenNotes,
  );

  if (_noteDotIsOn == true){
    NotesProvider.proSetIsFlashing(
      context: context,
      setTo: true,
      notify: true,
    );
  }
  
}
// --------------------
/// TESTED : WORKS PERFECT
bool _checkNoteDotIsOn({
  @required BuildContext context,
  @required List<NoteModel> unseenNotes,
}){

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(_userModel);


  bool _isOn = false;

  if (_thereAreMissingFields == true){
    _isOn = true;
  }
  else {

    if (Mapper.checkCanLoopList(unseenNotes) == true){
      _isOn = NoteModel.checkThereAreUnSeenNotes(unseenNotes);
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
