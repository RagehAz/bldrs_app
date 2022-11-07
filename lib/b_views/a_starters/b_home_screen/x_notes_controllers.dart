import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_trigger_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
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
/// TESTED : WORKS PERFECT
StreamSubscription listenToUserUnseenNotes(BuildContext context){

  StreamSubscription _sub;

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  if (_userModel != null && AuthFireOps.superUserID() != null){

    final Stream<QuerySnapshot<Object>> _unseenNotesStream = userUnseenNotesStream(
        context: context
    );

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _unseenNotesStream,
      // oldMaps: _oldMaps,
      invoker: 'listenToUserUnseenNotes',
      onChange: (List<Map<String, dynamic>> unseenNotesMaps) async {

        // blog('listenToUserUnseenNotes.onStreamDataChanged : unseenNotesMaps are ${unseenNotesMaps.length} maps');
        // Mapper.blogMaps(allUpdatedMaps, invoker: 'initializeUserNotes');

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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
void concludeAndActivatePyramidsFlashing({
  @required BuildContext context,
  @required List<NoteModel> unseenNotes,
}){

  final bool _noteDotIsOn = _checkNoteDotIsOn(
    context: context,
    unseenNotes: unseenNotes,
  );

    NotesProvider.proSetIsFlashing(
      context: context,
      setTo: _noteDotIsOn,
      notify: true,
    );

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
// -----------------------------------------------------------------------------
