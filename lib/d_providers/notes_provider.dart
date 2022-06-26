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
        value: 0,
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
        orElse: ()=> null,
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
  final Map<String, List<NoteModel>> _myBzzUnseenReceivedNotes = {};
  Map<String, List<NoteModel>> get myBzzUnseenReceivedNotes => _myBzzUnseenReceivedNotes;
// -------------------------------------
  void setBzUnseenNotesAndRebuildObelisk({
    @required BuildContext context,
    @required String bzID,
    @required List<NoteModel> notes,
    @required bool notify,
  }){

    _myBzzUnseenReceivedNotes[bzID] = notes;

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
// -------------------------------------
  void removeNotesFromAllBzzUnseenReceivedNotes({
    @required List<NoteModel> notes,
    @required String bzID,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _updatedNotes = NoteModel.removeNotesFromNotes(
        notesToRemove: notes,
        sourceNotes: _myBzzUnseenReceivedNotes[bzID],
      );

      _myBzzUnseenReceivedNotes[bzID] = _updatedNotes;

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

    _myBzzUnseenReceivedNotes.remove(bzID);

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------
  static void proAuthorResignationNotesRemovalOps({
    @required BuildContext context,
    @required String bzIDResigned,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeAllNotesOfThisBzFromAllBzzUnseenReceivedNotes(
      bzID: bzIDResigned,
      notify: false,
    );
    _notesProvider.removeAllObeliskNoteNumbersRelatedToBzID(
        bzID: bzIDResigned,
        notify: true
    );

  }

}
