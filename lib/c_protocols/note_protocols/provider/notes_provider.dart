import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/e_notes/a_note_model.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
class NotesProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// PYRAMID IS FLASHING

  // --------------------
  bool _isFlashing = false;
  bool get isFlashing => _isFlashing;
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proGetIsFlashing({
    required BuildContext context,
    required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.isFlashing;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setIsFlashing({
    required bool setTo,
    required bool notify,
  }){

    if (_isFlashing != setTo){

      _isFlashing = setTo;

      // blog('setIsFlashing : to : $setTo ');

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetIsFlashing({
    required bool setTo,
    required bool notify,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    _notesProvider._setIsFlashing(
      setTo: setTo,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// OBELISK NOTES BADGE NUMBERS

  // -------------------------------------------------
  /// MapModel(key: navModelID, value: numberOfNotes)
  List<MapModel> _obeliskBadges = <MapModel>[];
  List<MapModel> get obeliskBadges => _obeliskBadges;
  // -------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proInitializeObeliskBadges({
    required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    await _notesProvider._initializeObeliskBadges(
        notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetUserObeliskBadge({
    required List<NoteModel> unseenNotes,
    required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    await _notesProvider._setUserObeliskNumber(
      unseenNotes: unseenNotes,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetBzObeliskBadge({
    required String? bzID,
    required List<NoteModel>? unseenNotes,
    required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    await _notesProvider._setBzObeliskNumber(
      unseenNotes: unseenNotes,
      bzID: bzID,
      notify: notify,
    );
  }
  // -------------------------------------------------
  /// INITIALIZATION
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _initializeObeliskBadges({
    required bool notify,
  }) async {

    /// NOTE: generates all navModels and creates a MapModel for each one in Obelisk

    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(
      context: getMainContext(),
      listen: false,
    );

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

    /// UPDATE APP
    final bool _appNeedUpdate = await AppStateProtocols.shouldUpdateApp();

    if (_appNeedUpdate == true){
      final MapModel _updateModel = MapModel(
        key: 'settings',
        value: getWord('phid_update'),
      );
      MapModel.replaceMapModel(mapModels: _initialList, mapModel: _updateModel);
    }

    _obeliskBadges = _initialList;

    await _rebuildObeliskNumbers(
        notify: notify,
    );

  }
  // -------------------------------------------------
  /// SETTING
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _setUserObeliskNumber({
    required List<NoteModel> unseenNotes,
    required bool notify,
  }) async {

    await _setObeliskNumberAndRebuild(
      invoker: 'setUserObeliskNumber',
      value: unseenNotes.length,
      navModelID: NavModel.getUserTabNavID(UserTab.notifications),
      rebuildAllMainNumbers: true,
      notify: notify,
    );

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _setBzObeliskNumber({
    required String? bzID,
    required List<NoteModel>? unseenNotes,
    required bool notify,
  }) async {

    await _setObeliskNumberAndRebuild(
      invoker: 'setBzObeliskNumber',
      value: unseenNotes?.length,
      notify: notify,
      rebuildAllMainNumbers: true,
      navModelID: NavModel.getBzTabNavID(
        bzTab: BzTab.notes,
        bzID: bzID,
      ),
    );

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _setObeliskNumberAndRebuild({
    required String invoker,
    required int? value,
    required String? navModelID,
    required bool notify,
    required bool rebuildAllMainNumbers,
  }) async {

    final MapModel _mapModel = MapModel(
      key: navModelID,
      value: value,
    );

    _obeliskBadges = MapModel.insertMapModel(
      mapModels: _obeliskBadges,
      mapModel: _mapModel,
    );

    // blog('setObeliskNoteNumber (caller : $caller) : (navModelID : $navModelID) : value : $value');

    if (rebuildAllMainNumbers == true){

      await Future.wait(<Future>[

        _calculateAndSetMainUserProfileNumber(
          notify: false,
        ),

        _calculateAndSetAllMainBzzProfilesNumbers(
          notify: false,
        ),


      ]);

    }

    await _rebuildObeliskNumbers(
      notify: notify,
    );


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetMainUserProfileNumber({
    required bool notify,
  }) async {

    final List<String> _userProfileNavIDs = NavModel.generateUserTabsNavModelsIDs();

    /// internal tabs numbers
    final List<MapModel> _profileNumbers = MapModel.getModelsByKeys(
      keys: _userProfileNavIDs,
      allModels: _obeliskBadges,
    );

    final List<dynamic> _values = MapModel.getValuesFromMapModels(_profileNumbers);

    int _totalCount = 0;
    if (Lister.checkCanLoopList(_values) == true){

      for (final dynamic value in _values){

        if (value is! String){
          final int _addOn = value?.toInt() ?? 0;
          _totalCount = _totalCount + _addOn;
        }

      }

    }

    await _setObeliskNumberAndRebuild(
      invoker: 'calculateAndSetUserProfileNumbers',
      value: _totalCount,
      navModelID: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      notify: notify,
      rebuildAllMainNumbers: false,
    );

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetAllMainBzzProfilesNumbers({
    required bool notify,
  }) async {

    final List<BzModel> _myBzz = BzzProvider.proGetMyBzz(
      context: getMainContext(),
      listen: false,
    );

    final List<String> _bzzIDs = BzModel.getBzzIDs(_myBzz);

    if (Lister.checkCanLoopList(_bzzIDs) == true){

      for (int i = 0; i < _bzzIDs.length; i++){

        bool _notify = false;
        /// only listen to notify if at last one
        if (i == _bzzIDs.length - 1){
          _notify = notify;
        }

        await _calculateAndSetMainBzProfileNumber(
          bzID: _bzzIDs[i],
          notify: _notify,
        );

      }

    }

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetMainBzProfileNumber({
    required String? bzID,
    required bool notify,
  }) async {

    if (bzID != null){

      final List<String> _bzProfileNavIDs = NavModel.generateBzTabsNavModelsIDs(
        bzID: bzID,
      );

      final List<MapModel> _bzNumbers = MapModel.getModelsByKeys(
        keys: _bzProfileNavIDs,
        allModels: _obeliskBadges,
      );

      final List<dynamic> _values = MapModel.getValuesFromMapModels(_bzNumbers);

      int _totalCount = 0;
      if (Lister.checkCanLoopList(_values) == true){

        for (final dynamic value in _values){

          if (value != null && value is! String){
            final int _addOn = value.toInt();
            _totalCount = _totalCount + _addOn;
          }


        }

      }

      await _setObeliskNumberAndRebuild(
        invoker: 'calculateAndSetBzProfileNumbers',
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
  Future<void> _rebuildObeliskNumbers({
    required bool notify
  }) async {

    if (notify == true){
      await _decrementGlobalBadgeNumIfPossible();
      notifyListeners();
    }

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> _decrementGlobalBadgeNumIfPossible() async {
    // ---

    /// GLOBAL BADGE NUMBER IS THE SUM OF ALL NUMBERS IN [_obeliskNotesNumbers]

    // ---
    /// GET GLOBAL NUMBER
    final int _globalNumber = await FCM.getGlobalBadgeNumber();
    // ---
    /// CALCULATE OBELISK TOTAL
    int _obeliskTotal = 0;
    final List<dynamic> _values = MapModel.getValuesFromMapModels(_obeliskBadges);
    if (Lister.checkCanLoopList(_values) == true){
      for (final dynamic value in _values){
        if (value != null && value is! String){
          final int _addOn = value.toInt();
          _obeliskTotal = _obeliskTotal + _addOn;
        }
      }
    }
    // ---

    /// GLOBAL BADGE AUTO INCREMENTS THROUGH FCM SERVICE, BUT TO BE MANUALLY DECREMENTED HERE
    if (_obeliskTotal < _globalNumber){
      await FCM.setGlobalBadgeNumber(_obeliskTotal);
    }
    // ---
    /// ALWAYS SET LOCALLY FOR DEV MONITORING
    _badgeNum = _globalNumber;
    // ---
  }
  // -------------------------------------------------
  /// DELETING
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> removeAllObeliskNoteNumbersRelatedToBzID({
    required String? bzID,
    required bool notify,
  }) async {

    final List<String> _bzNavModelsIDs = NavModel.generateSuperBzNavIDs(
      bzID: bzID,
    );

    for (final String navModelID in _bzNavModelsIDs){
      _obeliskBadges.removeWhere((mm) => mm.key == navModelID);
    }

    await _rebuildObeliskNumbers(
        notify: notify,
    );

  }
  // -----
  /// TESTED : WORKS PERFECT
  Future<void> wipeObeliskNumbers({required bool notify}) async {

    _obeliskBadges = <MapModel>[];

    await _rebuildObeliskNumbers(
      notify: notify,
    );

  }
  // -----------------------------------------------------------------------------

  /// PRO NOTES OPS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void proAuthorResignationNotesRemovalOps({
    required String? bzIDResigned,
    bool notify = true,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    // _notesProvider.removeAllNotesOfThisBzFromAllBzzNotes(
    //   bzID: bzIDResigned,
    //   notify: false,
    // );
    _notesProvider.removeAllObeliskNoteNumbersRelatedToBzID(
        bzID: bzIDResigned,
        notify: notify,
    );

  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  static Future<void> wipeOut({
    required bool notify,
  }) async {

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);

    ///_obeliskNotesNumbers
    await _notesProvider.wipeObeliskNumbers(notify: false);

    ///_isFlashing
    _notesProvider._setIsFlashing(setTo: false, notify: false);

    /// DEPRECATED
    // ///_userNotes
    // _notesProvider.wipeUserNotes(notify: false);

    /// DEPRECATED
    // ///_myBzzNotes
    // _notesProvider.wipeAllBzzNotes(notify: true);

  }
  // -----------------------------------------------------------------------------

  /// ======>
  // BADGE NUMBER MONITOR
  /// ======>

  // --------------------
  int _badgeNum = 0;
  int get badgeNum => _badgeNum;
  Future<void> setBadgeNum() async {
    _badgeNum = await FCM.getAwesomeNoots()?.getGlobalBadgeCounter() ?? 0;
    notifyListeners();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proRefreshBadgeNum() async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    await _notesProvider.setBadgeNum();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int proGetBadgeNum({
    required BuildContext context,
    required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.badgeNum;
  }
  // -----------------------------------------------------------------------------

}
