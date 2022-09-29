import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
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
  void generateSetInitialObeliskNumbers({
    @required BuildContext context,
    @required bool notify,
  }){

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

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
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

    // blog('setObeliskNoteNumber (caller : $caller) : (navModelID : $navModelID) : value : $value');

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
  // --------------------
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
  // --------------------
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
  // --------------------
  void _calculateAndSetAllMainBzzProfilesNumbers({
    @required BuildContext context,
    @required bool notify,
  }){

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

        _calculateAndSetMainBzProfileNumber(
          context: context,
          bzID: _bzzIDs[i],
          notify: _notify,
        );

      }

    }

  }
  // --------------------
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
  // --------------------
  void wipeObeliskNumbers({@required bool notify}){

    _obeliskNotesNumbers = <MapModel>[];

    if (notify == true){
      notifyListeners();
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
  void setUserNotesAndRebuild({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _userNotes = notes;

    setObeliskNumberAndRebuild(
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
  void setBzNotesAndRebuildObelisk({
    @required BuildContext context,
    @required String bzID,
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _myBzzNotes[bzID] = notes;

    setObeliskNumberAndRebuild(
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
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    ///_obeliskNotesNumbers
    _notesProvider.wipeObeliskNumbers(notify: false);

    ///_isFlashing
    _notesProvider.setIsFlashing(setTo: false, notify: false);

    ///_userNotes
    _notesProvider.wipeUserNotes(notify: false);

    ///_myBzzNotes
    _notesProvider.wipeAllBzzNotes(notify: true);

  }
  // -----------------------------------------------------------------------------
}
