import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/e_notes/aa_trigger_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_streamer.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/flyer_fire_ops.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
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

/// USER NOTES STREAM

// --------------------
///
StreamSubscription initializeUserNotes(BuildContext context){

  StreamSubscription _sub;

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: false);

  if (_userModel != null){

    /// TASK : STREAM NEEDS TO BE CLOSED WHEN DELETING USER
    final Stream<QuerySnapshot<Object>> _stream = getUserUnseenNotesStream(
        context: context
    );

    final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = _getCipheredProUserUnseenReceivedNotes(
      context: context,
    );

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _stream,
      oldMaps: _oldMaps,
      onChange: (List<Map<String, dynamic>> allUpdatedMaps) async {

        // blog('new maps are :-');
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

        await _checkForBzDeletionNoteAndProceed(
          context: context,
          notes: _notes,
        );

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

// --------------------
///
Future<void> _checkForBzDeletionNoteAndProceed({
  @required BuildContext context,
  @required List<NoteModel> notes,
}) async {

  // blog('_checkForBzDeletionNoteAndProceed : start');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (UserModel.checkUserIsAuthor(_userModel) == true){

    // blog('_checkForBzDeletionNoteAndProceed : user is author');

    final List<NoteModel> _bzDeletionNotes = NoteModel.getNotesContainingTrigger(
      notes: notes,
      triggerFunctionName: TriggerModel.deleteBzLocally,
    );

    if (Mapper.checkCanLoopList(_bzDeletionNotes) == true){

      // blog('_checkForBzDeletionNoteAndProceed : ${_bzDeletionNotes.length} bz deletion notes');

      for (final NoteModel note in _bzDeletionNotes){

        /// in the case of bzDeletion NoteType : trigger argument is bzID
        final String _bzID = note.trigger.argument;

        final bool _bzIDisInMyBzzIDs = Stringer.checkStringsContainString(
          strings: _userModel.myBzzIDs,
          string: _bzID,
        );

        if (_bzIDisInMyBzzIDs == true){
          await AuthorshipProtocols.removeMeAfterBzDeletion(
            context: context,
            bzID: _bzID,
          );
        }

      }

    }

  }

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

      final StreamSubscription _sub = initializeBzNotesStream(
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
Stream<QuerySnapshot<Object>> _bzUnseenReceivedNotesStream({
  @required String bzID,
}){

  final Stream<QuerySnapshot<Object>> _stream  = Fire.streamCollection(
    queryModel: FireQueryModel(
        collRef: Fire.getSuperCollRef(aCollName: FireColl.notes),
        limit: 100,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        finders: <FireFinder>[

          FireFinder(
            field: 'receiverID',
            comparison: FireComparison.equalTo,
            value: bzID,
          ),

          const FireFinder(
            field: 'seen',
            comparison: FireComparison.equalTo,
            value: false,
          ),

        ],
        onDataChanged: (List<Map<String, dynamic>> maps){
          blog('_bzUnseenReceivedNotesStream : onDataChanged : ${maps.length} maps');
        }
    ),
  );

  return _stream;
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
StreamSubscription initializeBzNotesStream({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);


  final Stream<QuerySnapshot<Object>> _stream  = _bzUnseenReceivedNotesStream(
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

      await _bzCheckLocalFlyerUpdatesNotesAndProceed(
        context: context,
        newBzNotes: _allBzNotes,
      );

    },
  );

  return _streamSubscription;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _bzCheckLocalFlyerUpdatesNotesAndProceed({
  @required BuildContext context,
  @required List<NoteModel> newBzNotes,
}) async {

  final List<NoteModel> _flyerUpdatesNotes = NoteModel.getNotesContainingTrigger(
    notes: newBzNotes,
    triggerFunctionName: TriggerModel.refetchFlyer,
  );

  if (Mapper.checkCanLoopList(_flyerUpdatesNotes) == true){

    for (int i =0; i < _flyerUpdatesNotes.length; i++){

      final NoteModel note = _flyerUpdatesNotes[i];

      final String _flyerID = note.trigger.argument;

      if (_flyerID != null){

        final FlyerModel flyerModel = await FlyerFireOps.readFlyerOps(
            flyerID: _flyerID
        );

        await FlyerProtocols.updateFlyerLocally(
          context: context,
          flyerModel: flyerModel,
          notifyFlyerPro: (i + 1) == _flyerUpdatesNotes.length,
          resetActiveBz: true,
        );

      }


    }

  }

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
