import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
    // -----------------------------------------------------------------------------

  /// OBELISK NOTES NUMBERS

  // --------------------
  /// MapModel(key: navModelID, value: numberOfNotes)
  List<MapModel> _obeliskNotesNumbers = <MapModel>[];
  List<MapModel> get obeliskNotesNumber => _obeliskNotesNumbers;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> generateSetInitialObeliskNumbers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(context: context, listen: false);

    final List<String> _allNavModelsIDs = NavModel.generateAllNavModelsIDs(
      myBzzIDs: BzModel.getBzzIDs(_bzzModels),
    );

    final List<MapModel> _initialList = <MapModel>[];
    for (final String navID in _allNavModelsIDs){
      final MapModel _mapModel = MapModel(
        key: navID,
        value: 0,
      );
      _initialList.add(_mapModel);
    }

    _obeliskNotesNumbers = _initialList;

    await rebuildObeliskNumbers(
        notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  int getObeliskNumber({
    @required String navModelID,
  }){

    final MapModel _mapModel = _obeliskNotesNumbers.firstWhere(
          (m) => m.key == navModelID,
      orElse: ()=> null,
    );

    return _mapModel?.value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> setObeliskNumberAndRebuild({
    @required BuildContext context,
    @required String caller,
    @required int value,
    @required String navModelID,
    @required bool notify,
    @required bool rebuildAllMainNumbers,
  }) async {

    final MapModel _mapModel = MapModel(
      key: navModelID,
      value: value,
    );

    _obeliskNotesNumbers = MapModel.insertMapModel(
      mapModels: _obeliskNotesNumbers,
      mapModel: _mapModel,
    );

    // blog('setObeliskNoteNumber (caller : $caller) : (navModelID : $navModelID) : value : $value');

    if (rebuildAllMainNumbers == true){

      await Future.wait(<Future>[

        _calculateAndSetMainUserProfileNumber(
          context: context,
          notify: false,
        ),

        _calculateAndSetAllMainBzzProfilesNumbers(
          context: context,
          notify: false,
        ),


      ]);

    }

    await rebuildObeliskNumbers(
        notify: notify,
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> removeAllObeliskNoteNumbersRelatedToBzID({
    @required String bzID,
    @required bool notify,
  }) async {

    final List<String> _bzNavModelsIDs = NavModel.generateSuperBzNavIDs(
      bzID: bzID,
    );

    for (final String navModelID in _bzNavModelsIDs){
      _obeliskNotesNumbers.removeWhere((mm) => mm.key == navModelID);
    }

    await rebuildObeliskNumbers(
        notify: notify,
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetMainUserProfileNumber({
    @required BuildContext context,
    @required bool notify,
  }) async {

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

    await setObeliskNumberAndRebuild(
      context: context,
      caller: 'calculateAndSetUserProfileNumbers',
      value: _totalCount,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      notify: notify,
      rebuildAllMainNumbers: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetAllMainBzzProfilesNumbers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(
      context: context,
      listen: false,
    );

    final List<String> _bzzIDs = BzModel.getBzzIDs(_myBzz);

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      for (int i = 0; i < _bzzIDs.length; i++){

        bool _notify = false;
        /// only listen to notify if at last one
        if (i == _bzzIDs.length - 1){
          _notify = notify;
        }

        await _calculateAndSetMainBzProfileNumber(
          context: context,
          bzID: _bzzIDs[i],
          notify: _notify,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetMainBzProfileNumber({
    @required BuildContext context,
    @required String bzID,
    @required bool notify,
  }) async {

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

      await setObeliskNumberAndRebuild(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> wipeObeliskNumbers({@required bool notify}) async {

    _obeliskNotesNumbers = <MapModel>[];

    await rebuildObeliskNumbers(
      notify: notify,
    );

  }
  // --------------------
  ///
  Future<void> rebuildObeliskNumbers({@required bool notify}) async {

    if (notify == true){
      await _setGlobalBadgeNumber();
      notifyListeners();
    }

  }
  // --------------------
  ///
  Future<void> _setGlobalBadgeNumber() async {

    /// GLOBAL BADGE NUMBER IS THE SUM OF ALL NUMBERS IS [_obeliskNotesNumbers]

    final List<dynamic> _values = MapModel.getValuesFromMapModels(_obeliskNotesNumbers);

    if (Mapper.checkCanLoopList(_values) == true){

      int _total = 0;
      for (final dynamic value in _values){
        _total = _total + value;
      }

      await FCM.setGlobalBadgeNumber(_total);

    }
    else {
      await FCM.resetGlobalBadgeNumber();
    }

  }
  // -----------------------------------------------------------------------------

  /// PYRAMID IS FLASHING

  // --------------------
  bool _isFlashing = false;
  bool get isFlashing => _isFlashing;
  // --------------------
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
  // --------------------
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

  /// USER RECEIVED UNSEEN NOTES

  // --------------------
  List<NoteModel> _userNotes = <NoteModel>[];
  List<NoteModel> get userNotes => _userNotes;
  // --------------------
  Future<void> setUserNotesAndRebuild({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required bool notify,
  }) async {

    _userNotes = notes;

    await setObeliskNumberAndRebuild(
      context: context,
      caller: 'setUserUnseenNotes',
      value: _userNotes.length,
      navModelID: NavModel.getUserTabNavID(UserTab.notifications),
      rebuildAllMainNumbers: true,
      notify: notify,
    );

  }
  // --------------------
  static List<NoteModel> proGetUserUnseenNotes({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.userNotes;
  }
  // --------------------
  void updateNoteInUserNotes({
    @required NoteModel note,
    @required bool notify,
  }){

    _userNotes = NoteModel.replaceNoteInNotes(
        notes: _userNotes,
        noteToReplace: note
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void deleteNoteInUserNotes({
    @required String noteID,
    @required bool notify,
  }){

    _userNotes = NoteModel.removeNoteFromNotes(
      notes: _userNotes,
      noteID: noteID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void wipeUserNotes({
    @required bool notify
  }){
    _userNotes = <NoteModel>[];

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// ALL BZZ RECEIVED UNSEEN NOTES

  // --------------------
  /// only the received notes
  Map<String, List<NoteModel>> _myBzzNotes = {}; // {bzID : <NoteModel>[Note, Note, Note..]}
  Map<String, List<NoteModel>> get myBzzNotes => _myBzzNotes;
  // --------------------
  Future<void> setBzNotesAndRebuildObelisk({
    @required BuildContext context,
    @required String bzID,
    @required List<NoteModel> notes,
    @required bool notify,
  }) async {

    _myBzzNotes[bzID] = notes;

    await setObeliskNumberAndRebuild(
      context: context,
      caller: 'setBzUnseenNotesAndRebuildObelisk',
      value: notes.length,
      notify: notify,
      rebuildAllMainNumbers: true,
      navModelID: NavModel.getBzTabNavID(
        bzTab: BzTab.notes,
        bzID: bzID,
      ),
    );

  }
  // --------------------
  void removeNotesFromBzzNotes({
    @required List<NoteModel> notes,
    @required String bzID,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _updatedNotes = NoteModel.removeNotesFromNotes(
        notesToRemove: notes,
        sourceNotes: _myBzzNotes[bzID],
      );

      _myBzzNotes[bzID] = _updatedNotes;

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // --------------------
  static void proRemoveNotesFromBzzNotes({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required String bzID,
    @required bool notify,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeNotesFromBzzNotes(
      bzID: bzID,
      notify: notify,
      notes: notes,
    );
  }
  // --------------------
  void removeAllNotesOfThisBzFromAllBzzNotes({
    @required String bzID,
    @required bool notify,
  }){

    _myBzzNotes.remove(bzID);

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void updateNoteInMyBzzNotes({
    @required NoteModel note,
    @required bool notify,
  }){

    _myBzzNotes = NoteModel.updateNoteInBzzNotesMap(
      note: note,
      bzzNotesMap: _myBzzNotes,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void deleteNoteInBzzNotes({
    @required String noteID,
    @required bool notify,
  }){

    _myBzzNotes = NoteModel.removeNoteFromBzzNotesMap(
      bzzNotesMap: _myBzzNotes,
      noteID: noteID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void wipeAllBzzNotes({
    @required bool notify,
  }){

    _myBzzNotes = {};

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// PRO NOTES OPS

  // --------------------
  static void proUpdateNoteEverywhereIfExists({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required bool notify,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    _notesProvider.updateNoteInUserNotes(
      note: noteModel,
      notify: false,
    );

    _notesProvider.updateNoteInMyBzzNotes(
        note: noteModel,
        notify: notify
    );

  }
  // --------------------
  static void proDeleteNoteEverywhereIfExists({
    @required BuildContext context,
    @required String noteID,
    @required bool notify,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    _notesProvider.deleteNoteInUserNotes(
      noteID: noteID,
      notify: false,
    );

    _notesProvider.deleteNoteInBzzNotes(
        noteID: noteID,
        notify: notify
    );

  }
  // --------------------
  static void proAuthorResignationNotesRemovalOps({
    @required BuildContext context,
    @required String bzIDResigned,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeAllNotesOfThisBzFromAllBzzNotes(
      bzID: bzIDResigned,
      notify: false,
    );
    _notesProvider.removeAllObeliskNoteNumbersRelatedToBzID(
        bzID: bzIDResigned,
        notify: true
    );

  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static Future<void> wipeOut({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    ///_obeliskNotesNumbers
    await _notesProvider.wipeObeliskNumbers(notify: false);

    ///_isFlashing
    _notesProvider.setIsFlashing(setTo: false, notify: false);

    ///_userNotes
    _notesProvider.wipeUserNotes(notify: false);

    ///_myBzzNotes
    _notesProvider.wipeAllBzzNotes(notify: true);

  }
  // -----------------------------------------------------------------------------
}
