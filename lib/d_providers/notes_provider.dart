import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// OBELISK NOTES NUMBERS

// -------------------------------------
  /// MapModel(key: navModelID, value: numberOfNotes)
  List<MapModel> _obeliskNotesNumbers = <MapModel>[];
  List<MapModel> get obeliskNotesNumber => _obeliskNotesNumbers;
// -------------------------------------
  static List<MapModel> proGetObeliskNotesNumbers({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.obeliskNotesNumber;
  }
// -------------------------------------
  void addObeliskNotesNumbers({
    @required List<MapModel> mapModels,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(mapModels) == true){
      _obeliskNotesNumbers.addAll(mapModels);

      if (notify == true){
        notifyListeners();
      }

    }

  }
// -------------------------------------
  void incrementObeliskNoteNumber({
    @required int value,
    @required String navModelID,
    @required bool notify,
    bool isIncrementing = true,
  }){

    final MapModel _mapModel = MapModel.getModelByKey(
      models: _obeliskNotesNumbers,
      key: navModelID,
    );

    MapModel _output = _mapModel ?? MapModel(
      key: navModelID,
      value: 0,
    );

    int _newValue;

    if (isIncrementing == true){
      _newValue = _output.value == null ? value : _output.value + value;
    }
    else {
      _newValue = _output.value == null || _output.value <= 1 ? null : _output.value - value;
    }

    if (_newValue != null){

      _output = _output.copyWith(
        value: _newValue,
      );

      _obeliskNotesNumbers = MapModel.insertMapModel(
        mapModels: _obeliskNotesNumbers,
        mapModel: _output,
      );

    }

    else {
      _obeliskNotesNumbers = MapModel.removeMapModel(
        mapModels: _obeliskNotesNumbers,
        key: navModelID,
      );
    }


    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------

  /// PYRAMID IS FLASHING

// -------------------------------------
  bool _isFlashing = false;
  bool get isFlashing => _isFlashing;
// -------------------------------------
  void setIsFlashing({
    @required bool setTo,
    @required bool notify,
  }){

    if (_isFlashing != setTo){

      _isFlashing = setTo;

      if (notify == true){
        notifyListeners();
      }

    }


  }
// -------------------------------------
  static void proSetIsFlashing({
    @required BuildContext context,
    @required bool setTo,
    @required bool notify,
}){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.setIsFlashing(
      setTo: setTo,
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// USER UNSEEN NOTES

// -------------------------------------
  List<NoteModel> _userUnseenNotes = <NoteModel>[];
  List<NoteModel> get userUnseenNotes => _userUnseenNotes;
// -------------------------------------
  void setUserUnseenNotes({
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _userUnseenNotes = notes;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  static List<NoteModel> proGetUserUnseenNotes({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.userUnseenNotes;
  }
// -----------------------------------------------------------------------------

  /// ALL BZZ UNSEEN NOTES

// -------------------------------------
  /// only the received notes
  List<NoteModel> _myBzzUnseenReceivedNotes = <NoteModel>[];
  List<NoteModel> get myBzzUnseenReceivedNotes => _myBzzUnseenReceivedNotes;
// -------------------------------------
  void setAllBzzUnseenNotes({
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _myBzzUnseenReceivedNotes = notes;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void removeNotesFromAllBzzUnseenNotes({
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

      _myBzzUnseenReceivedNotes = NoteModel.removeNotesFromNotes(
        notesToRemove: notes,
        sourceNotes: _myBzzUnseenReceivedNotes,
      );

      if (notify == true){
        notifyListeners();
      }

    }

  }

// -------------------------------------
  static List<NoteModel> proGetAllBzzUnseenNotes({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.myBzzUnseenReceivedNotes;
  }
// -----------------------------------------------------------------------------
/*
  /// BZZ SENT NOTES

// -------------------------------------
  /// PENDING SENT AUTHORSHIP NOTES
  // ----------------------------
  List<NoteModel> _pendingSentAuthorshipNotes = <NoteModel>[];
  // ----------------------------
  List<UserModel> _pendingSentAuthorshipUsers = <UserModel>[];
  // ----------------------------
  List<NoteModel> get pendingSentAuthorshipNotes => _pendingSentAuthorshipNotes;
  // ----------------------------
  List<UserModel> get pendingSentAuthorshipUsers => _pendingSentAuthorshipUsers;
  // ----------------------------
  Future<void> recallPendingSentAuthorshipNotes({
    @required BuildContext context,
    @required bool notify,
  }) async {

    if (Mapper.checkCanLoopList(_pendingSentAuthorshipNotes) == false){

      final List<NoteModel> _pendingNotes = await NoteFireOps.paginatePendingSentAuthorshipNotes(
        context: context,
        senderID: AuthFireOps.superUserID(),
        limit: 100,
        startAfter: null,
      );

      if (Mapper.checkCanLoopList(_pendingNotes) == true)   {
        final List<String> _usersIDs = NoteModel.getReceiversIDs(
          notes: _pendingNotes,
        );

        final List<UserModel> _users = await UsersProvider.proFetchUsersModels(
          context: context,
          usersIDs: _usersIDs,
        );

        _pendingSentAuthorshipNotes = _pendingNotes;
        _pendingSentAuthorshipUsers = _users;

        if (notify == true){
          notifyListeners();
        }
      }

    }

  }
  // ----------------------------
  Future<void> addNewPendingSentAuthorshipNote({
    @required BuildContext context,
    @required NoteModel note,
    @required bool notify,
  }) async {

    final UserModel _user = await UsersProvider.proFetchUserModel(
        context: context,
        userID: note.receiverID,
    );

    _pendingSentAuthorshipNotes.add(note);
    _pendingSentAuthorshipUsers.add(_user);

    if (notify == true){
      notifyListeners();
    }

  }
  // ----------------------------
  void removeSentAuthorshipNote({
    @required NoteModel note,
    @required bool notify,
  }){

    _pendingSentAuthorshipNotes.removeWhere((n) => n.id == note.id);
    _pendingSentAuthorshipUsers.removeWhere((u) => u.id == note.receiverID);

    if (notify == true){
      notifyListeners();
    }

  }
  // ----------------------------
  void clearPendingSentAuthorshipNotes({
    @required bool notify,
  }){
    _pendingSentAuthorshipUsers = <UserModel>[];
    _pendingSentAuthorshipNotes = <NoteModel>[];

    if (notify == true){
      notifyListeners();
    }
  }
 */
// -----------------------------------------------------------------------------

/// ALL BZ NOTES

// // -------------------------------------
//   List<NoteModel> _allBzzNotes = <NoteModel>[];
// // -------------------------------------
//   List<NoteModel> get allBzzNotes => _allBzzNotes;
// // -------------------------------------
//   static List<NoteModel> proGetAllBzzNotes({
//     @required BuildContext context,
//     @required bool listen,
//   }){
//     final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
//     return _notesProvider.allBzzNotes;
//   }
// // -------------------------------------
//   void insertNotesToAllBzzNotes({
//     @required List<NoteModel> notes,
//     @required bool notify,
//   }){
//
//     _allBzzNotes = NoteModel.insertNotesInNotes(
//       notesToGet: _allBzzNotes,
//       notesToInsert: notes,
//       duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
//     );
//
//     if (notify == true){
//       notifyListeners();
//     }
//
//   }

}

/*

  //   NotiModel _noti;
  bool _notiIsOn = false;
Future<void> receiveAndActUponNoti({dynamic msgMap, NotiType notiType}) async {
  blog('receiveAndActUponNoti : notiType : $notiType');

  final NotiModel _noti = await NotiOps.receiveAndActUponNoti(
    context: context,
    notiType: notiType,
    msgMap: msgMap,
  );

  if (_noti != null){
    setState(() {
      // _noti = noti;
      _notiIsOn = true;
    });
  }

}
// -----------------------------------------------------------------------------


   */
