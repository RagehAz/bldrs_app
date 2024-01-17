import 'dart:async';

import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabs.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// USER NOTES

// --------------------
/// TESTED : WORKS PERFECT
StreamSubscription? listenToUserUnseenNotes({
    required ValueNotifier<List<Map<String, dynamic>>> oldMaps,
    required bool mounted,
}){

  StreamSubscription? _sub;

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

    final Stream<List<Map<String, dynamic>>>? _unseenNotesStream = userUnseenNotesStream();

    _sub = FireCollStreamer.initializeStreamListener(
      stream: _unseenNotesStream,
      oldMaps: oldMaps,
      mounted: mounted,
      onChanged: (List<Map<String, dynamic>> oldMaps, List<Map<String, dynamic>> newMaps) async {

        // blog('listenToUserUnseenNotes.onStreamDataChanged : unseenNotesMaps are ${unseenNotesMaps.length} maps');
        // Mapper.blogMaps(allUpdatedMaps, invoker: 'initializeUserNotes');

        final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
          maps: newMaps,
          fromJSON: false,
        );

        await NotesProvider.proSetBadge(
            bid: BldrsTabber.bidProfileNotifications,
            value: _unseenNotes.length,
            notify: true
        );

        concludeAndActivatePyramidsFlashing(
          unseenNotes: _unseenNotes,
        );

        await NoteFunProtocols.fireTriggers(
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
List<StreamSubscription> listenToMyBzzUnseenNotes({
  required List<ValueNotifier<List<Map<String, dynamic>>>> bzzOldMaps,
  required bool mounted,
}){
  final List<StreamSubscription> _subs = <StreamSubscription>[];

  final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
    context: getMainContext(),
    listen: false,
  );

  if (Lister.checkCanLoop(_myBzzIDs) == true){

    for (int i = 0; i < _myBzzIDs.length; i++){

      final String _bzID = _myBzzIDs[i];
      final ValueNotifier<List<Map<String, dynamic>>> oldMaps = bzzOldMaps[i];

      final StreamSubscription? _sub = _listenToMyBzUnseenNotes(
        bzID: _bzID,
        mounted: mounted,
        oldMaps: oldMaps,
      );

      if (_sub != null){
        _subs.add(_sub);
      }

    }

  }

  return _subs;
}
// --------------------
/// TESTED : WORKS PERFECT
StreamSubscription? _listenToMyBzUnseenNotes({
  required String? bzID,
  required ValueNotifier<List<Map<String, dynamic>>> oldMaps,
  required bool mounted,
}){
  StreamSubscription? _streamSubscription;

  if (bzID != null){

      final Stream<List<Map<String, dynamic>>>? _bzUnseenNotesStream  = bzUnseenNotesStream(
        bzID: bzID,
      );

      _streamSubscription = FireCollStreamer.initializeStreamListener(
        stream: _bzUnseenNotesStream,
        oldMaps: oldMaps,
        mounted: mounted,
        onChanged: (List<Map<String, dynamic>> oldMaps, List<Map<String, dynamic>> newMaps) async {

          final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
            maps: newMaps,
            fromJSON: false,
          );

          await NotesProvider.proSetBadge(
              bid: BldrsTabber.generateBzBid(bzID: bzID, bid: BldrsTabber.bidMyBzNotes),
              value: _unseenNotes.length,
              notify: true
          );

          concludeAndActivatePyramidsFlashing(
            unseenNotes: _unseenNotes,
          );

          await NoteFunProtocols.fireTriggers(
            notes: _unseenNotes,
          );

          // await _bzCheckLocalFlyerUpdatesNotesAndProceed(
          //   context: context,
          //   newBzNotes: _unseenNotes,
          // );

        },
      );

  }

  return _streamSubscription;
}
// --------------------
/// TESTED : WORKS PERFECT
List<ValueNotifier<List<Map<String, dynamic>>>> createMyBzOldUnseenNotesMaps(){

  final List<ValueNotifier<List<Map<String, dynamic>>>> _output = [];

  final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
    context: getMainContext(),
    listen: false,
  );

  if (Lister.checkCanLoop(_myBzzIDs) == true){

    for (int i = 0; i < _myBzzIDs.length; i++){

      final ValueNotifier<List<Map<String, dynamic>>> notifier = ValueNotifier([]);
      _output.add(notifier);

    }

  }

  return _output;
}
// --------------------
/// TESTED : WORKS PERFECT
void disposeMyBzOldUnseenNotesMaps({
  required List<ValueNotifier<List<Map<String, dynamic>>>>? notifiers
}){

  if (Lister.checkCanLoop(notifiers) == true){

    for (final ValueNotifier<List<Map<String, dynamic>>> notifier in notifiers!){
      notifier.dispose();
    }

  }

}
// -----------------------------------------------------------------------------

/// PYRAMIDS FLASHING

// --------------------
/// TESTED : WORKS PERFECT
void concludeAndActivatePyramidsFlashing({
  required List<NoteModel> unseenNotes,
}){

  final bool _noteDotIsOn = _checkNoteDotIsOn(
    unseenNotes: unseenNotes,
  );

    NotesProvider.proSetIsFlashing(
      setTo: _noteDotIsOn,
      notify: true,
    );

}
// --------------------
/// TESTED : WORKS PERFECT
bool _checkNoteDotIsOn({
  required List<NoteModel> unseenNotes,
}){

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
    userModel: _userModel,
  );


  bool _isOn = false;

  if (_thereAreMissingFields == true){
    _isOn = true;
  }
  else {

    if (Lister.checkCanLoop(unseenNotes) == true){
      _isOn = NoteModel.checkThereAreUnSeenNotes(unseenNotes);
    }

  }

  return _isOn;
}
// -----------------------------------------------------------------------------
