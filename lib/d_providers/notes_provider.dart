import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
// ---------------------------------------------------------
// --------------------

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
  void generateSetInitialObeliskNumbers({
    @required BuildContext context,
    @required bool notify,
  }){

    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(context: context, listen: false);

    final List<String> _allNavModelsIDs = NavModel.generateAllNavModelsIDs(
        myBzzIDs: BzModel.getBzzIDsFromBzz(_bzzModels),
    );

    final List<MapModel> _initialList = <MapModel>[];
    for (final String navID in _allNavModelsIDs){
      final MapModel _mapModel = MapModel(
        key: navID,
        value: null,
      );
      _initialList.add(_mapModel);
    }

      _obeliskNotesNumbers = _initialList;

      if (notify == true){
        notifyListeners();
      }

  }
// -------------------------------------
  int getObeliskNumber({
    @required String navModelID,
  }){

    final MapModel _mapModel = _obeliskNotesNumbers.firstWhere(
            (m) => m.key == navModelID,
        orElse: ()=> null
    );

    return _mapModel?.value;
  }
// -------------------------------------
  void setObeliskNumberAndRebuild({
    @required BuildContext context,
    @required String caller,
    @required int value,
    @required String navModelID,
    @required bool notify,
    @required bool rebuildAllMainNumbers,
  }){

    final MapModel _mapModel = MapModel(
      key: navModelID,
      value: value,
    );

    _obeliskNotesNumbers = MapModel.insertMapModel(
      mapModels: _obeliskNotesNumbers,
      mapModel: _mapModel,
    );

    blog('setObeliskNoteNumber (caller : $caller) : (navModelID : $navModelID) : value : $value');

    if (rebuildAllMainNumbers == true){

      _calculateAndSetMainUserProfileNumber(
        context: context,
        notify: false,
      );

      _calculateAndSetAllMainBzzProfilesNumbers(
        context: context,
        notify: false,
      );

    }

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void removeAllObeliskNoteNumbersRelatedToBzID({
    @required String bzID,
    @required bool notify,
  }){

    final List<String> _bzNavModelsIDs = NavModel.generateSuperBzNavIDs(
      bzID: bzID,
    );

    for (final String navModelID in _bzNavModelsIDs){
      _obeliskNotesNumbers.removeWhere((mm) => mm.key == navModelID);
    }

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void _calculateAndSetMainUserProfileNumber({
    @required BuildContext context,
    @required bool notify,
  }){

    final List<String> _userProfileNavIDs = NavModel.generateUserTabsNavModelsIDs();

    /// internal tabs numbers
    final List<MapModel> _profileNumbers = MapModel.getModelsByKeys(
      keys: _userProfileNavIDs,
      allModels: _obeliskNotesNumbers,
    );

    final List<dynamic> _values = MapModel.getValuesFromMapModels(_profileNumbers);

    int _totalCount = 0;
    if (Mapper.checkCanLoopList(_values) == true){

      for (final dynamic value in _values){

        final int _addOn = value?.toInt() ?? 0;
        _totalCount = _totalCount + _addOn;

      }

    }

    setObeliskNumberAndRebuild(
      context: context,
      caller: 'calculateAndSetUserProfileNumbers',
      value: _totalCount,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      notify: notify,
      rebuildAllMainNumbers: false,
    );

  }
// -------------------------------------
  void _calculateAndSetAllMainBzzProfilesNumbers({
    @required BuildContext context,
    @required bool notify,
  }){

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(
        context: context,
        listen: false,
    );

    final List<String> _bzzIDs = BzModel.getBzzIDsFromBzz(_myBzz);

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (int i = 0; i < _bzzIDs.length; i++){

        bool _notify = false;
        /// only listen to notify if at last one
        if (i == _bzzIDs.length - 1){
          _notify = notify;
        }

        _calculateAndSetMainBzProfileNumber(
          context: context,
          bzID: _bzzIDs[i],
          notify: _notify,
        );

      }

    }

  }
// -------------------------------------
  void _calculateAndSetMainBzProfileNumber({
    @required BuildContext context,
    @required String bzID,
    @required bool notify,
  }){

    if (bzID != null){

      final List<String> _bzProfileNavIDs = NavModel.generateBzTabsNavModelsIDs(
        bzID: bzID,
      );

      final List<MapModel> _bzNumbers = MapModel.getModelsByKeys(
        keys: _bzProfileNavIDs,
        allModels: _obeliskNotesNumbers,
      );

      final List<dynamic> _values = MapModel.getValuesFromMapModels(_bzNumbers);

      int _totalCount = 0;
      if (Mapper.checkCanLoopList(_values) == true){

        for (final dynamic value in _values){

          _totalCount = _totalCount + (value.toInt());

        }

      }

      setObeliskNumberAndRebuild(
        context: context,
        caller: 'calculateAndSetBzProfileNumbers',
        value: _totalCount,
        notify: notify,
        rebuildAllMainNumbers: false,
        navModelID: NavModel.getMainNavIDString(
          navID: MainNavModel.bz,
          bzID: bzID,
        ),
      );

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

      blog('setIsFlashing : to : $setTo ');

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
  void setUserUnseenNotesAndRebuild({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _userUnseenNotes = notes;

    setObeliskNumberAndRebuild(
      context: context,
      caller: 'setUserUnseenNotes',
      value: _userUnseenNotes.length,
      navModelID: NavModel.getUserTabNavID(UserTab.notifications),
      rebuildAllMainNumbers: true,
      notify: notify,
    );

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
  void setAllBzzUnseenNotesAndRebuildObelisk({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _myBzzUnseenReceivedNotes = notes;

    _setMyBzzObeliskNumbersAndRebuildAfterSettingBzzUnseenNotes(
      context: context,
      notify: false,
    );

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void _setMyBzzObeliskNumbersAndRebuildAfterSettingBzzUnseenNotes({
    @required BuildContext context,
    @required bool notify,
  }){

    final List<String> _myBzzIDs = BzzProvider.proGetMyBzzIDs(
        context: context,
        listen: false
    );

    for (int i = 0; i < _myBzzIDs.length; i++){

      final String _bzID = _myBzzIDs[i];

      final List<NoteModel> _bzNotes = NoteModel.getNotesByReceiverID(
          notes: _myBzzUnseenReceivedNotes,
          receiverID: _bzID
      );

      final bool _isLast = Mapper.checkIsLastListObject(
        index: i,
        list: _myBzzIDs,
      );

      setObeliskNumberAndRebuild(
        context: context,
        caller: 'setAllBzzUnseenNotes',
        value: _bzNotes.length,
        notify: _isLast == true && notify == true,
        rebuildAllMainNumbers: _isLast,
        navModelID: NavModel.getBzTabNavID(
          bzTab: BzTab.notes,
          bzID: _bzID,
        ),
      );

    }


  }
// -------------------------------------
  void removeNotesFromAllBzzUnseenReceivedNotes({
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
  void removeAllNotesOfThisBzFromAllBzzUnseenReceivedNotes({
    @required String bzID,
    @required bool notify,
  }){

    _myBzzUnseenReceivedNotes.removeWhere((note) => note.receiverID == bzID);

    if (notify == true){
      notifyListeners();
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
