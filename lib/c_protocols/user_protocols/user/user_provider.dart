import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// MY USER MODEL

  // --------------------
  UserModel? _myUserModel;
  // --------------------
  UserModel? get myUserModel => _myUserModel;
  // --------------------
  /*
  static bool userIsSignedUp({bool listen = false}) {

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: listen);
    final UserModel _user = _usersProvider.myUserModel;
    // final AuthModel _auth = _usersProvider.myAuthModel;

    bool _isSignedUp = false;

    if (_user == null) {
      _isSignedUp = false;
    }
    else if (_user.signInMethod == null) {
      _isSignedUp = false;
    }
    else if (_user.signInMethod == SignInMethod.anonymous) {
      _isSignedUp = false;
    }
    else {
      _isSignedUp = true;
    }

    blog('userIsSignedUp() : $_isSignedUp');
    _user?.blogUserModel();

    return _isSignedUp;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? proGetMyUserModel({
    required BuildContext context,
    required bool listen
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);
    return _usersProvider.myUserModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetMyUserModel({
    required UserModel? userModel,
    required bool notify,
  }) {
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
    _usersProvider._setMyUserModel(userModel: userModel, notify: notify);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setMyUserModel({
    required UserModel? userModel,
    required bool notify,
  }) {
      _myUserModel = userModel;

      if (notify == true) {
        notifyListeners();
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearMyUserModel({
    required bool notify,
  }) {
    _myUserModel = null;

    if (notify == true) {
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool proCheckIsFollowingBz({
    required String? bzID,
  }){
    bool _output = false;

    if (bzID != null){

      final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      );

      _output = Stringer.checkStringsContainString(
          strings: _myUserModel?.followedBzz?.all,
          string: bzID,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<BzModel>> proFetchMyBzz() async {

    return BzProtocols.fetchBzz(
      bzzIDs: proGetMyBzzIDs(
        context: getMainContext(),
        listen: false,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> proGetMyBzzIDs({
    required BuildContext context,
    required bool listen,
  }){
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: listen,
    );
    return _userModel?.myBzzIDs ?? [];
  }
  // -----------------------------------------------------------------------------

  /// MY DEVICE CONTACTS

  // --------------------
  /*
  List<Contact> _myDeviceContacts = <Contact>[];
  List<String> _selectedDeviceContacts = <String>[];
  List<Contact> _searchedDeviceContacts = <Contact>[];
  bool _isSearchingDeviceContacts = false;
  // --------------------
  List<Contact> get myDeviceContacts => _myDeviceContacts;
  List<String> get selectedDeviceContacts => _selectedDeviceContacts;
  List<Contact> get searchedDeviceContacts => _searchedDeviceContacts;
  bool get isSearchingDeviceContacts => _isSearchingDeviceContacts;
  // --------------------
  void setMyDeviceContacts({
    required List<Contact> contacts,
    required bool notify,
  }){
    _myDeviceContacts = contacts;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  bool canSearchContacts(){
    bool _canSearch = false;

    if (Lister.checkCanLoop(myDeviceContacts) == true){
      _canSearch = true;
    }
    else {
      _canSearch = false;
    }
    return _canSearch;
  }
  // --------------------
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
  // --------------------
  void _setSelectedDeviceContacts({
    required List<String> contacts,
    required bool notify,
  }){

    _selectedDeviceContacts = contacts;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  bool deviceContactIsSelected(String contactString){

    final bool _alreadySelected = Mapper.checkStringsContainString(
        strings: _selectedDeviceContacts,
        string: contactString,
    );

    return _alreadySelected;
  }
  // --------------------
  void searchDeviceContacts(String searchString){

    List<Contact> _foundContacts = <Contact>[];

    /// A - WHEN CONTACTS NOT YET IMPORTED
    if (Lister.checkCanLoop(_myDeviceContacts) == false){
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
    if (Lister.checkCanLoop(_foundContacts) == true){
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
  // --------------------
  void _serSearchedDeviceContacts({
    required List<Contact> setTo,
    required bool notify,
  }){

    _searchedDeviceContacts = setTo;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void _triggerIsSearchingDeviceContacts({
    required String searchString,
    required bool notify,
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
  // --------------------
  void _setIsSearchingDeviceContacts({
    required bool setTo,
    required bool notify,
  }){
    _isSearchingDeviceContacts = setTo;
    if (notify == true){
      notifyListeners();
    }
  }
  */
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);

    /// _myUserModel
    _usersProvider.clearMyUserModel(
      notify: notify,
    );

    // /// _myDeviceContacts
    // _usersProvider.setMyDeviceContacts(
    //   contacts: <Contact>[],
    //   notify: false,
    // );
    //
    // /// _selectedDeviceContacts
    // _usersProvider._setSelectedDeviceContacts(
    //   contacts: <String>[],
    //   notify: false
    // );
    //
    // /// _searchedDeviceContacts
    // _usersProvider._serSearchedDeviceContacts(
    //     setTo: <Contact>[],
    //     notify: false,
    // );
    //
    // /// _isSearchingDeviceContacts
    // _usersProvider._setIsSearchingDeviceContacts(
    //     setTo: false,
    //     notify: notify,
    // );

  }
  // -----------------------------------------------------------------------------

  /// ADMINS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsAdmin(){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
    return _usersProvider.myUserModel?.isAdmin ?? false;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsRage7(){
    return Authing.getUserID() == BldrsKeys.ragehID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsAuthor(){
    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );
    return UserModel.checkUserIsAuthor(_user);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel? proGetUserZone(){
    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );
    return _user?.zone;
  }
  // -----------------------------------------------------------------------------
}
