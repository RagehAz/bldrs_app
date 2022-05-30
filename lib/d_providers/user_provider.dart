import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
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
    UserModel _userModel;

    /// 1 - search in entire LDBs for this userModel
    for (final String doc in LDBDoc.userModelsDocs) {
      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: doc,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchValue: userID,
      );

      if (_map != null && _map != <String, dynamic>{}) {
        blog('fetchUserModelByID : UserModel found in local db : $doc');
        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: true);
        break;
      }
    }

    /// 2 - if not found, search firebase
    if (_userModel == null) {
      blog('fetchUserModelByID : UserModel NOT found in local db');

      /// 2.1 read firebase UserOps
      _userModel = await UserFireOps.readUser(
        context: context,
        userID: userID,
      );

      /// 2.2 if found on firebase, store in ldb sessionUsers
      if (_userModel != null) {
        blog('fetchUserModelByID : UserModel found in firestore db');

        await LDBOps.insertMap(
          input: _userModel.toMap(toJSON: true),
          docName: LDBDoc.users,
        );
      }
    }

    return _userModel;
  }
// -------------------------------------
  Future<List<UserModel>> fetchUsersByIDs({
    @required BuildContext context,
    @required List<String> usersIDs,
  }) async {

    final List<UserModel> _userModels = <UserModel>[];

    if (Mapper.canLoopList(usersIDs) == true){

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
  Future<void> fetchSetMyUserModelAndFixZone(BuildContext context) async {
    UserModel _userModel;

    final String _myUserID = FireAuthOps.superUserID();

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

      setMyUserModel(
        userModel: _userModel,
        notify: true,
      );

    }

  }
// -------------------------------------
  void setMyUserModel({
    @required UserModel userModel,
    @required bool notify,
  }){

    _myUserModel = userModel;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void setMyAuthModel({
    @required AuthModel authModel,
    @required bool notify,
}){

    _myAuthModel = authModel;

    if (notify == true){
      notifyListeners();
    }
}
// -------------------------------------
  void clearMyUserModelAndAuthModel(){

    setMyUserModel(
      userModel: null,
      notify: false,
    );

    setMyAuthModel(
        authModel: null,
        notify: true
    );

  }
// -------------------------------------
  void addBzIDToMyBzzIDs({
    @required String bzIDToAdd,
    @required bool notify,
  }) {

    final List<String> _newList = <String>[bzIDToAdd, ..._myUserModel.myBzzIDs];
    _myUserModel = _myUserModel.copyWith(
      myBzzIDs: _newList,
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

    if (Mapper.canLoopList(_myUserModel.myBzzIDs)) {

      final List<String> _newList = Mapper.removeStringsFromStrings(
          removeFrom: _myUserModel.myBzzIDs,
          removeThis: <String>[bzIDToRemove],
      );

      final UserModel _updatedUser = _myUserModel.copyWith(
        myBzzIDs: _newList,
      );

      _myUserModel = _updatedUser;

      if (notify == true){
        notifyListeners();
      }


    }
  }
// -----------------------------------------------------------------------------

  /// MY DEVICE CONTACTS

// -------------------------------------
  List<Contact> _myDeviceContacts = <Contact>[];
  final List<String> _selectedDeviceContacts = <String>[];
  List<Contact> _searchedDeviceContacts = <Contact>[];
  bool _isSearchingDeviceContacts = false;
// -------------------------------------
  List<Contact> get myDeviceContacts => _myDeviceContacts;
  List<String> get selectedDeviceContacts => _selectedDeviceContacts;
  List<Contact> get searchedDeviceContacts => _searchedDeviceContacts;
  bool get isSearchingDeviceContacts => _isSearchingDeviceContacts;
// -------------------------------------
  void setMyDeviceContacts(List<Contact> contacts){
    _myDeviceContacts = contacts;
    notifyListeners();
  }
// -------------------------------------
  bool canSearchContacts(){
    bool _canSearch = false;

    if (Mapper.canLoopList(myDeviceContacts) == true){
      _canSearch = true;
    }
    else {
      _canSearch = false;
    }
    return _canSearch;
  }
// -------------------------------------
  void selectDeviceContact(String contactString){

    final bool _alreadySelected = Mapper.stringsContainString(
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
  bool deviceContactIsSelected(String contactString){

    final bool _alreadySelected = Mapper.stringsContainString(
        strings: _selectedDeviceContacts,
        string: contactString,
    );

    return _alreadySelected;
  }
// -------------------------------------
  void searchDeviceContacts(String searchString){

    List<Contact> _foundContacts = <Contact>[];

    /// A - WHEN CONTACTS NOT YET IMPORTED
    if (Mapper.canLoopList(_myDeviceContacts) == false){
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
    if (Mapper.canLoopList(_foundContacts) == true){
      _searchedDeviceContacts = _foundContacts;
      _triggerIsSearchingDeviceContacts(searchString: searchString, notify: false);
      notifyListeners();
    }
    else {
      _triggerIsSearchingDeviceContacts(
          searchString: searchString,
          notify: true,
      );
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

  /// USER STREAM

// -------------------------------------
  /*

  Stream<UserModel> get myUserModelStream {
    final CollectionReference<Object> _userCollection = UserFireOps.collRef();
    final Stream<UserModel> _stream = _userCollection
        .doc(_myUserModel?.id)
        .snapshots()
        .map(_userModelFromSnapshot);
    return _stream;
  }
// -------------------------------------
  static UserModel _userModelFromSnapshot(DocumentSnapshot<Object> doc) {
    UserModel _userModel;

    if (doc != null) {
      try {
        final Map<String, dynamic> _map = doc.data() as Map<String, dynamic>;

        _userModel = UserModel.decipherUserMap(map: _map, fromJSON: false);
      } on Exception catch (error) {
        blog('_userModelFromSnapshot error is : $error');
        rethrow;
      }
    }

    return _userModel;
  }
   */
// -----------------------------------------------------------------------------

  /// PRO FETCHERS

// -------------------------------------
  static UserModel proFetchMyUserModel(BuildContext context, {bool listen = false}){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);

    return _usersProvider.myUserModel;

  }
// -------------------------------------
  static Future<List<UserModel>> proFetchUsersModels({
    @required BuildContext context,
    @required List<String> usersIDs,
}) async {

    List<UserModel> _output = <UserModel>[];

    if (Mapper.canLoopList(usersIDs) == true){

      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      final List<UserModel> _users = await _usersProvider.fetchUsersByIDs(
        context: context,
        usersIDs: usersIDs,
      );

      _output = _users;
    }

    return _output;
  }
// -----------------------------------------------------------------------------
}
