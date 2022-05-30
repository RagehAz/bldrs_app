import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_db/fire/fire_models/query_order_by.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/note_ops.dart' as NoteFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// USER NOTES

// -------------------------------------
  /// NOTIFICATION IS ON
  bool _notiIsOn = false;
// -------------------------------------
  bool get notiIsOn {
    return _notiIsOn;
  }
// -------------------------------------
  void triggerNotiIsOn({
    @required bool notify,
    bool setNotiIsOn,
  }) {
    if (setNotiIsOn == null) {
      _notiIsOn = !_notiIsOn;
    } else {
      _notiIsOn = setNotiIsOn;
    }

    if (notify == true) {
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// UNREAD NOTES

// -------------------------------------
  Stream<List<NoteModel>> _receivedNotesStream;
  Stream<List<NoteModel>> get receivedNotesStream => _receivedNotesStream;
  void startSetUserNotesStream({
    @required BuildContext context,
    @required bool notify,
  }){

    final Stream<List<NoteModel>> _stream = NoteFireOps.getNoteModelsStream(
      context: context,
      limit: 100,
      orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
      finders: <FireFinder>[

        FireFinder(
          field: 'receiverID',
          comparison: FireComparison.equalTo,
          value: superUserID(),
        ),

      ],
    );

    _receivedNotesStream = _stream;

    if(notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  static Stream<List<NoteModel>> proGetUserNotesStream({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    return _notesProvider.receivedNotesStream;
  }
// -----------------------------------------------------------------------------
  /*
  List<NoteModel> _unseenUserNotes = <NoteModel>[];
// -------------------------------------
  List<NoteModel> get unreadNotifications => _unseenUserNotes;
// -------------------------------------
  void fetchSetNotiModels({
    @required bool notify,
  }) {
    /// TASK : get notifications
    /// TASK : set notifications

    _unseenUserNotes = [];
    if (notify == true) {
      notifyListeners();
    }
  }
   */
// -----------------------------------------------------------------------------

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

    if (canLoopList(_pendingSentAuthorshipNotes) == false){

      final List<NoteModel> _pendingNotes = await NoteFireOps.paginatePendingSentAuthorshipNotes(
        context: context,
        senderID: superUserID(),
        limit: 100,
        startAfter: null,
      );

      if (canLoopList(_pendingNotes) == true)   {
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
// -----------------------------------------------------------------------------
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
