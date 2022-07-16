import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
// -------------------------------------

  /// FETCHING USER

// -------------------------------------
  Future<UserModel> fetchUserByID({
    @required BuildContext context,
    @required String userID
  }) async {

    /// 1 - GET USER FROM LDB
    UserModel _userModel= await UserLDBOps.readUserOps(
      userID: userID,
    );

    if (_userModel != null){
      blog('fetchUserByID : ($userID) UserModel FOUND in LDB');
    }

    else {

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
        context: context,
        userID: userID,
      );

      /// 2.2 if found on firebase, store in ldb sessionUsers
      if (_userModel != null) {
        blog('fetchUserByID : ($userID) UserModel FOUND in FIRESTORE and inserted in LDB');
        await UserLDBOps.insertUserModel(_userModel);
      }

    }

    if (_userModel == null){
      blog('fetchUserByID : ($userID) UserModel NOT FOUND');
    }

    return _userModel;
  }
// -------------------------------------
  Future<List<UserModel>> fetchUsersByIDs({
    @required BuildContext context,
    @required List<String> usersIDs,
  }) async {

    final List<UserModel> _userModels = <UserModel>[];

    if (Mapper.checkCanLoopList(usersIDs) == true){

      for (final String userID in usersIDs){

        final UserModel _userModel = await fetchUserByID(
            context: context,
            userID: userID,
        );

        if (_userModel != null){

          _userModels.add(_userModel);

        }

      }

    }

    return _userModels;
  }
// -----------------------------------------------------------------------------

  /// MY USER MODEL

// -------------------------------------
  UserModel _myUserModel;
  AuthModel _myAuthModel;
// -------------------------------------
  UserModel get myUserModel => _myUserModel;
  AuthModel get myAuthModel => _myAuthModel;
// -------------------------------------
  static AuthModel proGetAuthModel({
    @required BuildContext context,
    @required bool listen,
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);
    return _usersProvider.myAuthModel;
  }
// -------------------------------------
  Future<void> fetchSetMyUserModelAndFixZone(BuildContext context) async {
    UserModel _userModel;

    final String _myUserID = AuthFireOps.superUserID();

    if (_myUserID != null) {

      _userModel = await fetchUserByID(
          context: context,
          userID: _myUserID,
      );

      final ZoneModel _completeZoneModel = await ZoneProvider.proFetchCompleteZoneModel(
          context: context,
          incompleteZoneModel: _userModel.zone,
      );

      _userModel = _userModel.copyWith(
        zone: _completeZoneModel,
      );

      setMyUserModelAndAuthModel(
        userModel: _userModel,
        notify: true,
      );

    }

  }
// -------------------------------------
  void setMyUserModelAndAuthModel({
    @required UserModel userModel,
    @required bool notify,
    AuthModel authModel,
  }){

    _myUserModel = userModel;

    _myAuthModel = authModel ?? _myAuthModel?.copyWith(
      userModel: userModel,
    );


    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void _setAuthModel({
    @required AuthModel setTo,
    @required bool notify,
  }){

    _myAuthModel = setTo;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void clearMyUserModelAndAuthModel({
    @required bool notify,
  }){

    _myUserModel = null;
    _myAuthModel = null;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void addBzIDToMyBzzIDs({
    @required String bzIDToAdd,
    @required bool notify,
  }) {

    /// THIS UPDATES MY AUTH MODEL AND MY USER MODEL

    final List<String> _newList = <String>[bzIDToAdd, ..._myUserModel.myBzzIDs];
    _myUserModel = _myUserModel.copyWith(
      myBzzIDs: _newList,
    );
    _myAuthModel = _myAuthModel.copyWith(
      userModel: _myUserModel,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // -------------------------------------
  void removeBzIDFromMyBzzIDs({
    @required String bzIDToRemove,
    @required bool notify,
  }){

    /// THIS UPDATES MY AUTH MODEL AND MY USER MODEL

    if (Mapper.checkCanLoopList(_myUserModel.myBzzIDs)) {

      _myUserModel = UserModel.removeBzIDFromMyBzzIDs(
          bzIDToRemove: bzIDToRemove,
          userModel: _myUserModel,
      );

      _myAuthModel = _myAuthModel.copyWith(
        userModel: _myUserModel,
      );

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // -------------------------------------
  /// TESTED : WORKS PERFECT
  static void proUpdateUserAndAuthModels({
    @required BuildContext context,
    @required UserModel userModel,
    @required bool notify,
  }){

    // SchedulerBinding.instance.addPostFrameCallback((_) {

      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      _usersProvider.setMyUserModelAndAuthModel(
        userModel: userModel,
        notify: notify,
      );

    // });

  }
// -----------------------------------------------------------------------------

  /// MY DEVICE CONTACTS

// -------------------------------------
  List<Contact> _myDeviceContacts = <Contact>[];
  List<String> _selectedDeviceContacts = <String>[];
  List<Contact> _searchedDeviceContacts = <Contact>[];
  bool _isSearchingDeviceContacts = false;
// -------------------------------------
  List<Contact> get myDeviceContacts => _myDeviceContacts;
  List<String> get selectedDeviceContacts => _selectedDeviceContacts;
  List<Contact> get searchedDeviceContacts => _searchedDeviceContacts;
  bool get isSearchingDeviceContacts => _isSearchingDeviceContacts;
// -------------------------------------
  void setMyDeviceContacts({
    @required List<Contact> contacts,
    @required bool notify,
  }){
    _myDeviceContacts = contacts;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  bool canSearchContacts(){
    bool _canSearch = false;

    if (Mapper.checkCanLoopList(myDeviceContacts) == true){
      _canSearch = true;
    }
    else {
      _canSearch = false;
    }
    return _canSearch;
  }
// -------------------------------------
  void selectDeviceContact(String contactString){

    final bool _alreadySelected = Mapper.checkStringsContainString(
        strings: _selectedDeviceContacts,
        string: contactString,
    );

    if (_alreadySelected == true){
      _selectedDeviceContacts.remove(contactString);
    }
    else {
      _selectedDeviceContacts.add(contactString);
    }

    notifyListeners();
  }
// -------------------------------------
  void _setSelectedDeviceContacts({
    @required List<String> contacts,
    @required bool notify,
  }){

    _selectedDeviceContacts = contacts;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  bool deviceContactIsSelected(String contactString){

    final bool _alreadySelected = Mapper.checkStringsContainString(
        strings: _selectedDeviceContacts,
        string: contactString,
    );

    return _alreadySelected;
  }
// -------------------------------------
  void searchDeviceContacts(String searchString){

    List<Contact> _foundContacts = <Contact>[];

    /// A - WHEN CONTACTS NOT YET IMPORTED
    if (Mapper.checkCanLoopList(_myDeviceContacts) == false){
      blog('can not search device contacts as they are not yet imported');
    }

    /// A - WHEN CONTACTS ARE IMPORTED
    else {

      _triggerIsSearchingDeviceContacts(
          searchString: searchString,
          notify: true,
      );

      _foundContacts = _myDeviceContacts.where((contact){

        final String _fixeContact = contact.displayName; //TextMod.fixSearchText(contact.givenName);
        final String _fixedSearchText = searchString; //TextMod.fixSearchText(searchString);

        blog('_fixeContact : $_fixeContact : _fixedSearchText : $_fixedSearchText');

        return
        TextChecker.stringContainsSubStringRegExp(
          string: _fixeContact,
          subString: _fixedSearchText,
        ) == true;

      })?.toList();
    }

    /// B - WHEN FOUND CONTACTS
    if (Mapper.checkCanLoopList(_foundContacts) == true){
      _triggerIsSearchingDeviceContacts(searchString: searchString, notify: false);
      _serSearchedDeviceContacts(
        setTo: _foundContacts,
        notify: true,
      );
    }
    else {
      _triggerIsSearchingDeviceContacts(
          searchString: searchString,
          notify: true,
      );
    }

  }
// -------------------------------------
  void _serSearchedDeviceContacts({
    @required List<Contact> setTo,
    @required bool notify,
  }){

    _searchedDeviceContacts = setTo;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void _triggerIsSearchingDeviceContacts({
    @required String searchString,
    @required bool notify,
  }){

    /// A - WHEN SEARCHING IS FALSE
    if (_isSearchingDeviceContacts == false){

      /// B - WHEN NOT SEARCHING
      if (searchString.isEmpty){
        /// DO NOTHING
      }

      /// B - WHEN STARTING TO SEARCH
      else {
        _setIsSearchingDeviceContacts(
            setTo: true,
            notify: notify,
        );
      }

    }

    /// A - WHEN ALREADY SEARCHING
    else {

      /// B - WHEN STOPPED SEARCHING
      if (searchString.isEmpty){
        _setIsSearchingDeviceContacts(
            setTo: false,
            notify: notify,
        );
      }

      /// B - WHEN CONTINUING THE SEARCH
      else {
        /// DO NOTHING
      }

    }

  }
// -------------------------------------
  void _setIsSearchingDeviceContacts({
    @required bool setTo,
    @required bool notify,
  }){
    _isSearchingDeviceContacts = setTo;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// PRO FETCHERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static UserModel proGetMyUserModel({
    @required BuildContext context,
    @required bool listen
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);
    return _usersProvider.myUserModel;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<UserModel>> proFetchUsersModels({
    @required BuildContext context,
    @required List<String> usersIDs,
}) async {

    List<UserModel> _output = <UserModel>[];

    if (Mapper.checkCanLoopList(usersIDs) == true){

      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      final List<UserModel> _users = await _usersProvider.fetchUsersByIDs(
        context: context,
        usersIDs: usersIDs,
      );

      _output = _users;
    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> proFetchUserModel({
    @required BuildContext context,
    @required String userID,
  }) async {
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _userModel = await _usersProvider.fetchUserByID(
        context: context,
        userID: userID
    );

    return _userModel;
  }
// -----------------------------------------------------------------------------

  /// WIPE OUT

// -------------------------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

    /// _myUserModel
    _usersProvider.setMyUserModelAndAuthModel(
        userModel: null,
        notify: false,
    );
    /// _myAuthModel
    _usersProvider._setAuthModel(
      setTo: null,
      notify: false,
    );

    /// _myDeviceContacts
    _usersProvider.setMyDeviceContacts(
      contacts: <Contact>[],
      notify: false,
    );

    /// _selectedDeviceContacts
    _usersProvider._setSelectedDeviceContacts(
      contacts: <String>[],
      notify: false
    );

    /// _searchedDeviceContacts
    _usersProvider._serSearchedDeviceContacts(
        setTo: <Contact>[],
        notify: false,
    );

    /// _isSearchingDeviceContacts
    _usersProvider._setIsSearchingDeviceContacts(
        setTo: false,
        notify: notify,
    );

  }
// -----------------------------------------------------------------------------
}
