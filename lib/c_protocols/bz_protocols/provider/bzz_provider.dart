import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
class BzzProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  void removeProBzEveryWhere({
    required String? bzID,
    required bool notify,
  }){

    removeBzFromMyBzz(
      bzID: bzID,
      notify: false,
    );
    removeBzFromSponsors(
      bzIDToRemove: bzID,
      notify: false,
    );
    removeBzFromFollowedBzz(
      bzIDToRemove: bzID,
      notify: false,
    );

    // / NO NEED TO CLEAR LAST INSTANCE IN ACTIVE BZ AS WE WILL NAVIGATE BACK
    // / TO HOME SCREEN, THEN RESET MY ACTIVE BZ ON NEXT BZ SCREEN OPENING
    if (bzID != _myActiveBz?.id){
      clearMyActiveBz(
        notify: notify,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);

    ///_sponsors
    _bzzProvider.clearSponsors(
      notify: false,
    );

    ///_myBzz
    _bzzProvider.clearMyBzz(notify: false);

    /// _followedBzz
    _bzzProvider.clearFollowedBzz(notify: false);

    /// _myActiveBz
    _bzzProvider.clearMyActiveBz(notify: notify);

    /// _pendingAuthorshipInvitationsUsersIDs
    // _bzzProvider.setPendingAuthorshipInvitations(
    //   notes: <NoteModel>[],
    //   notify: true,
    // );

  }
  // -----------------------------------------------------------------------------

  /// SPONSORS

  // --------------------
  List<BzModel> _sponsors = <BzModel>[];
  // --------------------
  List<BzModel> get sponsors {
    return <BzModel>[..._sponsors];
  }
  // --------------------
  /// TASK : sponsors bzz should depend on which city
  /// FETCH SPONSORS
  /// 1 - get sponsors from app state
  /// 2 - fetch each bzID if found
  Future<void> fetchSetSponsors({
    required bool notify,
  }) async {
    /// 1 - get sponsorsIDs from app state
    // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final List<String> _sponsorsBzzIDs = []; /// TASK : RESTRUCTURE SPONSORS THING

    if (Lister.checkCanLoop(_sponsorsBzzIDs)) {
      /// 2 - fetch bzz
      final List<BzModel> _bzzSponsors = await BzProtocols.fetchBzz(
          bzzIDs: _sponsorsBzzIDs
      );

      _setSponsors(
        bzz: _bzzSponsors,
        notify: notify,
      );
    }
  }
  // --------------------
  void _setSponsors({
    required List<BzModel> bzz,
    required bool notify,
  }){
    _sponsors = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  void clearSponsors({
    required bool notify,
  }){
    _setSponsors(
      bzz: <BzModel>[],
      notify: notify,
    );

  }
  // --------------------
  void removeBzFromSponsors({
    required String? bzIDToRemove,
    required bool notify,
  }){

    final int _index = _sponsors.indexWhere((bz) => bz.id == bzIDToRemove);

    if (_index != -1){
      _sponsors.removeAt(_index);

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// USER BZZ

  // --------------------
  List<BzModel> _myBzz = <BzModel>[];
  // --------------------
  List<BzModel> get myBzz {
    return <BzModel>[..._myBzz];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetMyBzz({
    required BuildContext context,
    required List<BzModel> myBzz,
    required bool notify,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider._setMyBzz(
        bzz: myBzz,
        notify: notify
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzModel> proGetMyBzz({
    required BuildContext context,
    required bool listen,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
    return _myBzz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> proGetMyBzzIDs({
    required BuildContext context,
    required bool listen,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
    final List<String> _myBzzIDs = BzModel.getBzzIDs(_myBzz);
    return _myBzzIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetMyBzz({
    required bool notify,
  }) async {

    /// 1 - get userBzzIDs from userModel
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
    final List<String>? _userBzzIDs = _usersProvider.myUserModel?.myBzzIDs;

    if (Lister.checkCanLoop(_userBzzIDs) == true) {
      /// 2 - fetch bzz
      final List<BzModel> _bzz = await BzProtocols.fetchBzz(
        bzzIDs: _userBzzIDs,
      );

      _setMyBzz(
        bzz: _bzz,
        notify: notify,
      );

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setMyBzz({
    required List<BzModel> bzz,
    required bool notify,
  }){

    // blog('BZZ PROVIDER : _setMyBzz : new bz has been set');
    _myBzz = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearMyBzz({
    required bool notify,
  }){
    _setMyBzz(
      bzz: <BzModel>[],
      notify: notify,
    );
  }
  // --------------------
  /// TASK : TEST ME
  static void proRemoveBzFromMyBzz({
    required String? bzID,
    required bool notify,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
    _bzzProvider.removeBzFromMyBzz(
      bzID: bzID,
      notify: true,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeBzFromMyBzz({
    required String? bzID,
    required bool notify,
  }) {

    if (Lister.checkCanLoop(_myBzz) == true) {

      final int _index = _myBzz.indexWhere((BzModel bzModel) => bzModel.id == bzID);

      if (_index != -1){
        _myBzz.removeAt(_index);
      }

      if (notify == true){
        blog('pro: removeBzFromMyBzz : should remove and notify');
        notifyListeners();
      }

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void addBzToMyBzz({
    required BzModel? bzModel,
    required bool notify,
  }) {
    if (bzModel != null){
      _myBzz.add(bzModel);
      if (notify == true){
        notifyListeners();
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void updateBzInMyBzz({
    required BzModel? modifiedBz,
    required bool notify,
  }) {

    if (Lister.checkCanLoop(_myBzz) == true && modifiedBz != null) {

      final int _index = _myBzz.indexWhere((BzModel bz) => modifiedBz.id == bz.id);

      if (_index != -1){

        final List<BzModel> _newList = <BzModel>[..._myBzz];
        _newList.removeAt(_index);
        _newList.insert(_index, modifiedBz);

        _setMyBzz(
          bzz: _newList,
          notify: notify,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// FOLLOWED BZZ

  // --------------------
  List<BzModel> _followedBzz = <BzModel>[];
  // --------------------
  List<BzModel> get followedBzz {
    return <BzModel>[..._followedBzz];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetFollowedBzz({
    required bool notify,
  }) async {
    /// 1 - get user saved followed bzz IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
    final UserModel? _myUserModel = _usersProvider.myUserModel;
    final List<String>? _followedBzzIDs = _myUserModel?.followedBzz?.all;

    if (Lister.checkCanLoop(_followedBzzIDs)) {

      final List<BzModel> _bzz = await BzProtocols.fetchBzz(
        bzzIDs: _followedBzzIDs,
      );

      _setFollowedBzz(
        bzz: _bzz,
        notify: notify,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setFollowedBzz({
    required List<BzModel> bzz,
    required bool notify,
  }){
    _followedBzz = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearFollowedBzz({
    required bool notify,
  }){
    _setFollowedBzz(
      bzz: <BzModel>[],
      notify: notify,
    );
  }
  // --------------------
  /// TASK : TEST ME
  bool checkFollow({
    required String? bzID,
  }) {
    bool _isFollowing = false;

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
    );

    final String? _id = _myUserModel?.followedBzz?.all?.firstWhereOrNull(
          (String id) => id == bzID,
       );

    if (_id == null) {
      _isFollowing = false;
    }

    else {
      _isFollowing = true;
    }

    // blog('_isFollowing = $_isFollowing');

    return _isFollowing;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeBzFromFollowedBzz({
    required String? bzIDToRemove,
    required bool notify,
  }){

    final int _index = _followedBzz.indexWhere((bz) => bz.id == bzIDToRemove);

    if (_index != -1){
      _followedBzz.removeAt(_index);

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MY ACTIVE BZ

  // --------------------
  BzModel? _myActiveBz;
  BzModel? get myActiveBz => _myActiveBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetActiveBzModel({
    required BzModel bzModel,
    required BuildContext context,
    required bool notify,
  }) {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.setActiveBz(
      bzModel: bzModel,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel? proGetActiveBzModel({
    required BuildContext context,
    required bool listen,
  }) {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    return _bzzProvider.myActiveBz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setActiveBz({
    required BzModel? bzModel,
    required bool notify,
  }) {

    // blog('BZZ PROVIDER : setActiveBz : setting active bz to ${bzModel?.id}');

    _myActiveBz = bzModel;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void resetActiveBz(){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
    final BzModel? _bzModel = _bzzProvider.myActiveBz?.copyWith();

    if (_bzModel != null){
      _bzzProvider.setActiveBz(
        bzModel: _bzModel,
        notify: true,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearMyActiveBz({
    required bool notify,
  }){
    setActiveBz(
      bzModel: null,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------
  /*

  /// PENDING AUTHORSHIP INVITATIONS

  // --------------------
  List<String> _pendingAuthorshipInvitationsUsersIDs = <String>[];
  List<String> get pendingAuthorsIDs => _pendingAuthorshipInvitationsUsersIDs;
  // --------------------
  /// TESTED : WORKS PERFECT
  void setPendingAuthorshipInvitations({
    required List<NoteModel> notes,
    required bool notify,
  }){

    blog('setPendingAuthorshipInvitations : starting : ${_pendingAuthorshipInvitationsUsersIDs.length} ids');

    if (notes != null){

      final List<String> _receiversIDs = NoteModel.getReceiversIDs(
        notes: notes,
      );

      blog('_receiversIDs : $_receiversIDs');
      blog('_pendingAuthorshipInvitationsUsersIDs : $_pendingAuthorshipInvitationsUsersIDs');

      final bool _idsAreIdentical = Lister.checkListsAreIdentical(
          list1: _pendingAuthorshipInvitationsUsersIDs,
          list2: _receiversIDs
      );

      blog('_idsAreIdentical : $_idsAreIdentical');

      if (_idsAreIdentical == false){

        _pendingAuthorshipInvitationsUsersIDs = _receiversIDs;

        if (notify == true){
          notifyListeners();
        }

      }

    }

    blog('setPendingAuthorshipInvitations : end : ${_pendingAuthorshipInvitationsUsersIDs.length} ids');

  }
   */
  // -----------------------------------------------------------------------------
}
