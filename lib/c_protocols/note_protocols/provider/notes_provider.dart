import 'dart:async';

import 'package:basics/helpers/streamers/streamer.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/x_utilities/badger.dart';
import 'package:bldrs/b_screens/a_home_screen/x_notes_controllers.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:fire/super_fire.dart';
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

  /// NOTES STREAM SUBSCRIPTIONS

  // --------------------
  StreamSubscription? _userNotesStreamSub;
  List<StreamSubscription>? _bzzNotesStreamsSubs;
  ValueNotifier<List<Map<String, dynamic>>>? _userOldNotesNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);
  List<ValueNotifier<List<Map<String, dynamic>>>>? _myBzzOldNotesNotifiers;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeNoteStreams({
    required bool mounted,
  }) async{

    // blog('_initializeNoteStreams START');

    if (mounted){

      final UserModel? _userModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      );

      // blog('_initializeNoteStreams signed up : ${Authing.userIsSignedUp(_userModel?.signInMethod)}');

      if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

        _userOldNotesNotifier ??= ValueNotifier<List<Map<String, dynamic>>>([]);
        _myBzzOldNotesNotifiers ??= createMyBzOldUnseenNotesMaps();

        await NotesProvider.proInitializeBadger(
          notify: false,
        );

        // blog('ta3ala _userNotesStreamSub : $_userNotesStreamSub');
        _userNotesStreamSub ??= listenToUserUnseenNotes(
          mounted: mounted,
          oldMaps: _userOldNotesNotifier!,
        );
        _bzzNotesStreamsSubs ??= listenToMyBzzUnseenNotes(
          mounted: mounted,
          bzzOldMaps: _myBzzOldNotesNotifiers!,
        );
      }

      }

  }
  // --------------------
  void _disposeNoteStreams(){
    disposeMyBzOldUnseenNotesMaps(
      notifiers: _myBzzOldNotesNotifiers,
    );
    _userOldNotesNotifier?.dispose();
    _userNotesStreamSub?.cancel();
    Streamer.disposeStreamSubscriptions(_bzzNotesStreamsSubs);
    _myBzzOldNotesNotifiers = null;
    _userOldNotesNotifier = null;
    _userNotesStreamSub = null;
    _bzzNotesStreamsSubs = null;

  }
  // --------------------
  static Future<void> proInitializeNoteStreams({
    required bool mounted,
  }) async {
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    await _notesProvider._initializeNoteStreams(mounted: mounted);
  }
  // --------------------
  static void disposeNoteStreams(){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);
    _notesProvider._disposeNoteStreams();
  }
  // -----------------------------------------------------------------------------

  /// BADGER

  // --------------------
  Badger _badger = const Badger(map: {});
  Badger get badger => _badger;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proInitializeBadger({
    required bool notify,
  }) async {

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(getMainContext(), listen: false);


    /// UPDATE APP
    final bool _appNeedUpdate = await AppStateProtocols.shouldUpdateApp();

    if (_appNeedUpdate == true){

      _notesProvider._badger = Badger.insertBadge(
        badger: _notesProvider._badger,
        key: TabName.bid_AppSettings,
        value: getWord('phid_update'),
      );

    }

    await _notesProvider._rebuildLocalAndGlobalBadges(
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetBadge({
    required String bid,
    required dynamic value,
    required bool notify,
  }) async {

    /*

    YOU CAN DO THOSE

        await NotesProvider.proSetBadge(
                      bid: BldrsTabber.bidMySaves,
                      value: 31,
                      notify: true,
                  );

                  await NotesProvider.proSetBadge(
                    bid: BldrsTabber.generateBzBid(bzID: 'Gjm747w1UpfsPUlWXtMc', bid: BldrsTabber.bidMyBzTeam),
                    value: 2,
                    notify: true,
                  );

                  await NotesProvider.proSetBadge(
                    bid: 'phid_k_flyer_type_equipment/phid_k_group_equip_handling/',
                    value: 15,
                    notify: true,
                  );

     */

    final NotesProvider _pro = Provider.of<NotesProvider>(getMainContext(), listen: false);

    _pro._badger = Badger.setBadge(
        badger: _pro._badger,
        key: bid,
        value: value,
    );

    await _pro._rebuildLocalAndGlobalBadges(
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Badger proGetBadger({
    required BuildContext context,
    required bool listen,
  }){
    final NotesProvider _pro = Provider.of<NotesProvider>(context, listen: listen);
    return _pro.badger;
  }
  // --------------------
  /*
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
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  Future<void> _setUserObeliskNumber({
    required List<NoteModel> unseenNotes,
    required bool notify,
  }) async {

    await _setObeliskNumberAndRebuild(
      invoker: 'setUserObeliskNumber',
      value: unseenNotes.length,
      bid: BldrsTabber.bidProfileNotifications,
      rebuildAllMainNumbers: true,
      notify: notify,
    );

  }
   */
  // -----
  /*
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
      bid: NavModel.getBzTabNavID(
        bzTab: BzTab.notes,
        bzID: bzID,
      ),
    );

  }
   */
  // -----
  /*
  /// TESTED : WORKS PERFECT
  Future<void> _setObeliskNumberAndRebuild({
    required int? value,
    required String? bid,
    required bool notify,
    required bool rebuildAllMainNumbers,
  }) async {

    final MapModel _mapModel = MapModel(
      key: bid,
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

    await _rebuildLocalAndGlobalBadges(
      notify: notify,
    );


  }
   */
  // --------------------
  /*
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
    if (Lister.checkCanLoop(_values) == true){

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
      bid: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      notify: notify,
      rebuildAllMainNumbers: false,
    );

  }
   */
  // -----
  /*
  /// TESTED : WORKS PERFECT
  Future<void> _calculateAndSetAllMainBzzProfilesNumbers({
    required bool notify,
  }) async {

    final List<String> _bzzIDs = UsersProvider.proGetMyBzzIDs(
      context: getMainContext(),
      listen: false,
    );

    if (Lister.checkCanLoop(_bzzIDs) == true){

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
   */
  // -----
  /*
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
      if (Lister.checkCanLoop(_values) == true){

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
        bid: NavModel.getMainNavIDString(
          navID: MainNavModel.bz,
          bzID: bzID,
        ),
      );

    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _rebuildLocalAndGlobalBadges({
    required bool notify
  }) async {

    if (notify == true){
      await _decrementGlobalBadgeNumIfPossible();
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _decrementGlobalBadgeNumIfPossible() async {

    final int _globalNumber = await FCM.getGlobalBadgeNumber();

    final int _badgerTotal = Badger.calculateGrandTotal(
      badger: _badger,
      onlyNumbers: true,
    );

    /// GLOBAL BADGE AUTO INCREMENTS THROUGH FCM SERVICE, BUT TO BE MANUALLY DECREMENTED HERE
    if (_badgerTotal < _globalNumber){
      await FCM.setGlobalBadgeNumber(_badgerTotal);
    }

    /// ALWAYS SET LOCALLY FOR DEV MONITORING
    _badgeNum = _globalNumber;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> removeAllRelatedToBzID({
    required String? bzID,
    required bool notify,
  }) async {

    if (bzID != null){

      _badger = Badger.wipeAllRelatedToBzID(
          bzID: bzID,
          badger: _badger,
      );

      await _rebuildLocalAndGlobalBadges(
        notify: notify,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> wipeObeliskNumbers({required bool notify}) async {

    _badger = const Badger(map: {});

    await _rebuildLocalAndGlobalBadges(
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
    _notesProvider.removeAllRelatedToBzID(
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
