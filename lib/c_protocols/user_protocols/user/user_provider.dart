import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
class UsersProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// MY USER MODEL

  // --------------------
  UserModel _myUserModel;
  AuthModel _myAuthModel;
  // --------------------
  UserModel get myUserModel => _myUserModel;
  AuthModel get myAuthModel => _myAuthModel;
  // --------------------
  /// TESTED : WORKS PERFECT
  static AuthModel proGetAuthModel({
    @required BuildContext context,
    @required bool listen,
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);
    return _usersProvider.myAuthModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel proGetMyUserModel({
    @required BuildContext context,
    @required bool listen
  }){
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: listen);
    return _usersProvider.myUserModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetMyUserAndAuthModels({
    @required BuildContext context,
    @required UserModel userModel,
    @required bool notify,
    AuthModel authModel,
  }){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _usersProvider._setMyUserModelAndAuthModel(
      userModel: userModel,
      notify: notify,
      authModel: authModel,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setMyUserModelAndAuthModel({
    @required UserModel userModel,
    @required bool notify,
    AuthModel authModel,
  }){

    if (UserModel.checkItIsMe(userModel?.id) == true){

      _myUserModel = userModel;

      _myAuthModel = authModel ?? _myAuthModel?.copyWith(
        userModel: userModel,
      );


      if (notify == true){
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  /*
  void _setAuthModel({
    @required AuthModel setTo,
    @required bool notify,
  }){

    _myAuthModel = setTo;

    if (notify == true){
      notifyListeners();
    }

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearMyUserModelAndAuthModel({
    @required bool notify,
  }){

    _myUserModel = null;
    _myAuthModel = null;

    if (notify == true){
      notifyListeners();
    }

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
    @required List<Contact> contacts,
    @required bool notify,
  }){
    _myDeviceContacts = contacts;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
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
    @required List<String> contacts,
    @required bool notify,
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
  // --------------------
  void _serSearchedDeviceContacts({
    @required List<Contact> setTo,
    @required bool notify,
  }){

    _searchedDeviceContacts = setTo;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
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
  // --------------------
  void _setIsSearchingDeviceContacts({
    @required bool setTo,
    @required bool notify,
  }){
    _isSearchingDeviceContacts = setTo;
    if (notify == true){
      notifyListeners();
    }
  }
  */

  // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

    /// _myUserModel
    _usersProvider.clearMyUserModelAndAuthModel(
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
}

bool isRage7(){
    return AuthFireOps.superUserID() == 'z0Obwze3JLYjoEl6uVeXfo4Luup1';
}
