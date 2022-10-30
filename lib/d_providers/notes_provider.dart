import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/bz_tabber/bz_tabber.dart';
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

  /// PYRAMID IS FLASHING

  // --------------------
  bool _isFlashing = false;
  bool get isFlashing => _isFlashing;
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setIsFlashing({
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
  /// TESTED : WORKS PERFECT
  static void proSetIsFlashing({
    @required BuildContext context,
    @required bool setTo,
    @required bool notify,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
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
    @required BuildContext context,
    @required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await _notesProvider._initializeObeliskBadges(
        context: context,
        notify: notify
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetUserObeliskBadge({
    @required BuildContext context,
    @required List<NoteModel> unseenNotes,
    @required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await _notesProvider._setUserObeliskNumber(
      context: context,
      unseenNotes: unseenNotes,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetBzObeliskBadge({
    @required BuildContext context,
    @required String bzID,
    @required List<NoteModel> unseenNotes,
    @required bool notify,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await _notesProvider._setBzObeliskNumber(
      context: context,
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
    @required BuildContext context,
    @required bool notify,
  }) async {

    /// NOTE: generates all navModels and creates a MapModel for each one in Obelisk

    final List<BzModel> _bzzModels = BzzProvider.proGetMyBzz(
        context: context,
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
    @required BuildContext context,
    @required List<NoteModel> unseenNotes,
    @required bool notify,
  }) async {

    await _setObeliskNumberAndRebuild(
      context: context,
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
    @required BuildContext context,
    @required String bzID,
    @required List<NoteModel> unseenNotes,
    @required bool notify,
  }) async {

    await _setObeliskNumberAndRebuild(
      context: context,
      invoker: 'setBzObeliskNumber',
      value: unseenNotes.length,
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
    @required BuildContext context,
    @required String invoker,
    @required int value,
    @required String navModelID,
    @required bool notify,
    @required bool rebuildAllMainNumbers,
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
          context: context,
          notify: false,
        ),

        _calculateAndSetAllMainBzzProfilesNumbers(
          context: context,
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
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<String> _userProfileNavIDs = NavModel.generateUserTabsNavModelsIDs();

    /// internal tabs numbers
    final List<MapModel> _profileNumbers = MapModel.getModelsByKeys(
      keys: _userProfileNavIDs,
      allModels: _obeliskBadges,
    );

    final List<dynamic> _values = MapModel.getValuesFromMapModels(_profileNumbers);

    int _totalCount = 0;
    if (Mapper.checkCanLoopList(_values) == true){

      for (final dynamic value in _values){

        final int _addOn = value?.toInt() ?? 0;
        _totalCount = _totalCount + _addOn;

      }

    }

    await _setObeliskNumberAndRebuild(
      context: context,
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
  // -----
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
        allModels: _obeliskBadges,
      );

      final List<dynamic> _values = MapModel.getValuesFromMapModels(_bzNumbers);

      int _totalCount = 0;
      if (Mapper.checkCanLoopList(_values) == true){

        for (final dynamic value in _values){

          _totalCount = _totalCount + (value.toInt());

        }

      }

      await _setObeliskNumberAndRebuild(
        context: context,
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
    @required bool notify
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
    if (Mapper.checkCanLoopList(_values) == true){
      for (final dynamic value in _values){
        _obeliskTotal = _obeliskTotal + value;
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
    @required String bzID,
    @required bool notify,
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
  Future<void> wipeObeliskNumbers({@required bool notify}) async {

    _obeliskBadges = <MapModel>[];

    await _rebuildObeliskNumbers(
      notify: notify,
    );

  }
  // -----------------------------------------------------------------------------

  /// PRO NOTES OPS

  // --------------------
  static void proAuthorResignationNotesRemovalOps({
    @required BuildContext context,
    @required String bzIDResigned,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    // _notesProvider.removeAllNotesOfThisBzFromAllBzzNotes(
    //   bzID: bzIDResigned,
    //   notify: false,
    // );
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
    _badgeNum = await FCM.getAwesomeNoots().getGlobalBadgeCounter();
    notifyListeners();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proRefreshBadgeNum(BuildContext context) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    await _notesProvider.setBadgeNum();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int proGetBadgeNum({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.badgeNum;
  }
  // -----------------------------------------------------------------------------

}
