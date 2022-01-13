import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
          primaryKey: 'id',
        );
      }
    }

    return _userModel;
  }
// -------------------------------------
  /*
  /// fetch Users By IDs
  Future<List<UserModel>> _fetchUsersByIDs({BuildContext context, List<String> usersIDs}) async {
    List<UserModel> _userModels = <UserModel>[];

    if (usersIDs != null && usersIDs.isNotEmpty){

      for (String userID in usersIDs){

        final UserModel _userModel = await _fetchUserByID(context: context, userID: userID);

        if (_userModel != null){

          _userModels.add(_userModel);

        }

      }

    }

    return _userModels;
  }
   */
// -----------------------------------------------------------------------------

  /// MY USER MODEL

// -------------------------------------
  UserModel _myUserModel; //UserModel.initializeUserModelStreamFromUser(superFirebaseUser()); needs to be null if didn't find the userModel
  CountryModel _myUserCountry;
  CityModel _myUserCity;
// -------------------------------------
  UserModel get myUserModel =>_myUserModel;
  CountryModel get myUserCountry => _myUserCountry;
  CityModel get myUserCity => _myUserCity;
// -------------------------------------
  Future<void> getsetMyUserModelAndCountryAndCity(BuildContext context) async {
    UserModel _userModel;
    CountryModel _userCountry;
    CityModel _userCity;

    final String _myUserID = FireAuthOps.superUserID();

    if (_myUserID != null) {
      _userModel = await fetchUserByID(context: context, userID: _myUserID);

      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
      _userCountry = await _zoneProvider.fetchCountryByID(context: context, countryID: _userModel.zone.countryID);
      _userCity = await _zoneProvider.fetchCityByID(context: context, cityID: _userModel.zone.cityID);

      blog('_userCountry is ${_userCountry.id} ahoooooooooooooo');
      blog('_userCity is ${_userCity.cityID} ahoooooooooooooo');

      setMyUserModelAndCountryAndCity(
        userModel: _userModel,
        countryModel: _userCountry,
        cityModel: _userCity,
      );

    }

  }
// -------------------------------------
  void setMyUserModelAndCountryAndCity({
    @required UserModel userModel,
    @required CountryModel countryModel,
    @required CityModel cityModel,
  }){
    _myUserModel = userModel;
    _myUserCountry = countryModel;
    _myUserCity = cityModel;
    notifyListeners();
  }
// -------------------------------------
  void clearMyUserModelAndCountryAndCity(){
    setMyUserModelAndCountryAndCity(
      userModel: null,
      countryModel: null,
      cityModel: null,
    );
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

    if (canLoopList(myDeviceContacts) == true){
      _canSearch = true;
    }
    else {
      _canSearch = false;
    }
    return _canSearch;
  }
// -------------------------------------
  void selectDeviceContact(String contactString){

    final bool _alreadySelected = stringsContainString(strings: _selectedDeviceContacts, string: contactString);

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
    final bool _alreadySelected = stringsContainString(strings: _selectedDeviceContacts, string: contactString);
    return _alreadySelected;
  }
// -------------------------------------
  void searchDeviceContacts(String searchString){

    List<Contact> _foundContacts = <Contact>[];

    /// A - WHEN CONTACTS NOT YET IMPORTED
    if (canLoopList(_myDeviceContacts) == false){
      blog('can not search device contacts as they are not yet imported');
    }

    /// A - WHEN CONTACTS ARE IMPORTED
    else {

      _triggerIsSearchingDeviceContacts(searchString: searchString, notify: true);

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
    if (canLoopList(_foundContacts) == true){
      _searchedDeviceContacts = _foundContacts;
      _triggerIsSearchingDeviceContacts(searchString: searchString, notify: false);
      notifyListeners();
    }
    else {
      _triggerIsSearchingDeviceContacts(searchString: searchString, notify: true);
    }

  }
// -------------------------------------
  void _triggerIsSearchingDeviceContacts({@required String searchString, @required bool notify}){

    /// A - WHEN SEARCHING IS FALSE
    if (_isSearchingDeviceContacts == false){

      /// B - WHEN NOT SEARCHING
      if (searchString.isEmpty){
        /// DO NOTHING
      }

      /// B - WHEN STARTING TO SEARCH
      else {
        _setIsSearchingDeviceContacts(setTo: true, notify: notify);
      }

    }

    /// A - WHEN ALREADY SEARCHING
    else {

      /// B - WHEN STOPPED SEARCHING
      if (searchString.isEmpty){
        _setIsSearchingDeviceContacts(setTo: false, notify: notify);
      }

      /// B - WHEN CONTINUING THE SEARCH
      else {
        /// DO NOTHING
      }

    }

  }
// -------------------------------------
  void _setIsSearchingDeviceContacts({@required bool setTo, bool notify = true}){
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
}
