import 'dart:async';

import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/b_note_fun_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/x_queries/notes_queries.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:fire/super_fire.dart';
// -----------------------------------------------------------------------------

/// OBELISK

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeObeliskNumbers() async {
  await NotesProvider.proInitializeObeliskBadges(
    notify: false,
  );
}
// -----------------------------------------------------------------------------

/// USER NOTES

// --------------------
/// TESTED : WORKS PERFECT
StreamSubscription? listenToUserUnseenNotes(){

  StreamSubscription? _sub;

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

    final Stream<List<Map<String, dynamic>>>? _unseenNotesStream = userUnseenNotesStream();

    _sub = FireCollStreamer.onStreamDataChanged(
      stream: _unseenNotesStream,
      // oldMaps: _oldMaps,
      invoker: 'listenToUserUnseenNotes',
      onChange: (List<Map<String, dynamic>>? unseenNotesMaps) async {

        // blog('listenToUserUnseenNotes.onStreamDataChanged : unseenNotesMaps are ${unseenNotesMaps.length} maps');
        // Mapper.blogMaps(allUpdatedMaps, invoker: 'initializeUserNotes');

        final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
          maps: unseenNotesMaps,
          fromJSON: false,
        );

        await NotesProvider.proSetUserObeliskBadge(
          unseenNotes: _unseenNotes,
          notify: true,
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
List<StreamSubscription> listenToMyBzzUnseenNotes(){

  final List<StreamSubscription> _subs = <StreamSubscription>[];

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  final bool _userIsAuthor = UserModel.checkUserIsAuthor(_userModel);
  // blog('initializeMyBzzNotes : _userIsAuthor : $_userIsAuthor');

  if (_userIsAuthor == true){

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(
      context: getMainContext(),
      listen: false,
    );

    for (final BzModel bzModel in _myBzz){

      final StreamSubscription? _sub = _listenToMyBzUnseenNotes(
        bzID: bzModel.id,
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
}){

  final Stream<List<Map<String, dynamic>>>? _bzUnseenNotesStream  = bzUnseenNotesStream(
    bzID: bzID,
  );

  final StreamSubscription? _streamSubscription = FireCollStreamer.onStreamDataChanged(
    stream: _bzUnseenNotesStream,
    // oldMaps: _oldMaps,
    invoker: '_listenToMyBzUnseenNotes : bzID : $bzID',
    onChange: (List<Map<String, dynamic>> unseenNotesMaps) async {

      final List<NoteModel> _unseenNotes = NoteModel.decipherNotes(
        maps: unseenNotesMaps,
        fromJSON: false,
      );

      await NotesProvider.proSetBzObeliskBadge(
          bzID: bzID,
          unseenNotes: _unseenNotes,
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

  return _streamSubscription;
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

    if (Mapper.checkCanLoopList(unseenNotes) == true){
      _isOn = NoteModel.checkThereAreUnSeenNotes(unseenNotes);
    }

  }

  return _isOn;
}
// -----------------------------------------------------------------------------
