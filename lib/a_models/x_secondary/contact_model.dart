import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:filers/filers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

enum ContactType {
  phone,
  email,

  website,

  facebook,
  linkedIn,
  youtube,
  instagram,
  pinterest,
  tiktok,
  twitter,
}

enum ContactsOwnerType {
  bz,
  author,
  user,
}

/// => TAMAM
@immutable
class ContactModel {
  /// --------------------------------------------------------------------------
  const ContactModel({
    @required this.value,
    @required this.type,
    this.controller,
  });
  /// --------------------------------------------------------------------------
  final String value;
  final ContactType type;
  final TextEditingController controller;
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  static const List<ContactType> contactTypesList = <ContactType>[
    ContactType.phone,
    ContactType.email,
    ContactType.website,
    ContactType.facebook,
    ContactType.linkedIn,
    ContactType.youtube,
    ContactType.instagram,
    ContactType.pinterest,
    ContactType.tiktok,
    ContactType.twitter,
  ];
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> generateContactsFromFirebaseUser(User user) {
    return generateBasicContacts(
      email: user?.email,
      phone: user?.phoneNumber,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> generateBasicContacts({
    @required String email,
    @required String phone,
  }){
    final List<ContactModel> _userContacts = <ContactModel>[];

    if (email != null) {
      _userContacts.add(
          ContactModel(value: email, type: ContactType.email));
    }

    if (phone != null) {
      _userContacts.add(
          ContactModel(value: phone, type: ContactType.phone));
    }

    return _userContacts;

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT : toMap();
  /*
  Map<String, Object> _toMap() {
    return <String, Object>{
      'value': value,
      'contactType': _cipherContactType(contactType),
    };
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, Object> cipherContacts(List<ContactModel> contacts) {
    Map<String, Object> _map = <String, Object>{};

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel contact in contacts) {
        if (contact.value != null && contact.value != '') {
          _map = Mapper.insertPairInMap(
            map: _map,
            key: _cipherContactType(contact.type),
            value: contact.value,
            overrideExisting: true,
          );
        }
      }
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> decipherContacts(Map<String, dynamic> maps) {
    final List<ContactModel> _contacts = <ContactModel>[];

    if (maps != null) {
      final List<String> _keys = maps.keys.toList();

      if (Mapper.checkCanLoopList(_keys)) {
        for (final String key in _keys) {

          final ContactModel _contact = ContactModel(
              value: maps[key],
              type: _decipherContactType(key)
          );

          _contacts.add(_contact);

        }
      }
    }

    return _contacts;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ContactType _decipherContactType(String contactType) {
    switch (contactType) {
      case 'phone':     return ContactType.phone;     break;
      case 'email':     return ContactType.email;     break;
      case 'website':   return ContactType.website;   break;
      case 'facebook':  return ContactType.facebook;  break;
      case 'linkedIn':  return ContactType.linkedIn;  break;
      case 'youtube':   return ContactType.youtube;   break;
      case 'instagram': return ContactType.instagram; break;
      case 'pinterest': return ContactType.pinterest; break;
      case 'tiktok':    return ContactType.tiktok;    break;
      case 'twitter':   return ContactType.twitter;   break;
      default:          return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _cipherContactType(ContactType contactType) {
    switch (contactType) {
      case ContactType.phone:     return 'phone';     break;
      case ContactType.email:     return 'email';     break;
      case ContactType.website:   return 'website';   break;
      case ContactType.facebook:  return 'facebook';  break;
      case ContactType.linkedIn:  return 'linkedIn';  break;
      case ContactType.youtube:   return 'youtube';   break;
      case ContactType.instagram: return 'instagram'; break;
      case ContactType.pinterest: return 'pinterest'; break;
      case ContactType.tiktok:    return 'tiktok';    break;
      case ContactType.twitter:   return 'twitter';   break;
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// EDITING INITIALIZERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> prepareContactsForEditing({
    @required List<ContactModel> contacts,
    @required String countryID,
  }){
    final List<ContactModel> _output = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final ContactModel _existingContact = getContactFromContacts(
        contacts: contacts,
        type: type,
      );

      final String _initialValue = _initializeContactValue(
        existingContact: _existingContact,
        type: type,
        countryID: countryID,
      );

      // final TextEditingController _controller = _existingContact?.controller ?? TextEditingController();
      // _controller.text = _initialValue;

      final ContactModel _contact = ContactModel(
        value: _initialValue,
        type: type,
      );

      // _contact.blogContact(invoker: 'initializeContactsForEditing');

      _output.add(_contact);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getInitialContactValue({
    @required List<ContactModel> existingContacts,
    @required ContactType type,
    @required String countryID,
  }){

    final ContactModel _existingContact = getContactFromContacts(
      contacts: existingContacts,
      type: type,
    );

    return _initializeContactValue(
        existingContact: _existingContact,
        type: type,
        countryID: countryID
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _initializeContactValue({
    @required ContactModel existingContact,
    @required ContactType type,
    @required String countryID,
  }){
    String _output = '';


    /// IF PHONE
    if (type == ContactType.phone){
      _output = TextMod.initializePhoneNumber(
        countryPhoneCode: Flag.getCountryPhoneCode(countryID),
        number : existingContact?.value,
      );
    }
    /// IF WEB LINK
    else if (checkIsWebLink(type) == true){
      _output = TextMod.initializeWebLink(
        url: existingContact?.value,
      );
    }
    /// OTHERWISE
    else {
      _output = existingContact?.value;
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void createListenersToControllers({
    @required List<ContactModel> contacts,
    @required Function listener,
  }){

    if (Mapper.checkCanLoopList(contacts) == true){

      for (final ContactModel contact in contacts){

        if (contact.controller != null){
          blog('createListenersToControllers : creating listener to ${contact.type} : _controller: ${contact.controller.hashCode} : ${contact.controller.text}');
          contact.controller.addListener((){
            blog('createListenersToControllers :  IS CHANGING TO : ${contact.controller.text}');
            listener();
          });
        }

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// EDITING DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeContactsControllers(List<ContactModel> contacts){
    if (Mapper.checkCanLoopList(contacts) == true){
      for (final ContactModel contact in contacts){

        if (contact.controller != null){
          contact.controller.dispose();
        }

      }
    }
  }
  // -----------------------------------------------------------------------------

  /// EDITING FINISHING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> bakeContactsAfterEditing({
    @required List<ContactModel> contacts,
    @required String countryID,
  }){

    final List<ContactModel> _output = <ContactModel>[];

    if (Mapper.checkCanLoopList(contacts) == true){

      for (int i = 0; i < contacts.length; i++){

        final ContactModel _contact = contacts[i];
        final ContactType _contactType = _contact.type;
        final String _value = _contact?.controller ?? _contact.value;

        String _endValue;

        /// IF PHONE
        if (_contactType == ContactType.phone){
          _endValue = TextMod.nullifyNumberIfOnlyCountryCode(
            number: _value,
            countryPhoneCode: Flag.getCountryPhoneCode(countryID),
          );
        }
        /// IF WEB LINK
        else if (checkIsWebLink(_contactType) == true){
          _endValue = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _value);
        }
        /// OTHERWISE
        else {
          _endValue = _value;
        }

        if (TextCheck.isEmpty(_endValue) == false){

          final ContactModel _model = ContactModel(
            value: _endValue,
            type: _contactType,
          );

          _output.add(_model);

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getContactTypePhid({
    @required BuildContext context,
    @required ContactType contactType,
  }){

    switch (contactType){
      case ContactType.phone:      return 'phid_phone'; break;
      case ContactType.email:      return 'phid_emailAddress'; break;
      case ContactType.website:    return 'phid_website'; break;
      case ContactType.facebook:   return 'phid_facebook'; break;
      case ContactType.linkedIn:   return 'phid_linkedIn'; break;
      case ContactType.youtube:    return 'phid_youtube'; break;
      case ContactType.instagram:  return 'phid_instagram'; break;
      case ContactType.pinterest:  return 'phid_pinterest'; break;
      case ContactType.tiktok:     return 'phid_tiktok'; break;
      case ContactType.twitter:    return 'phid_twitter'; break;
      default: return null;

    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ContactModel getContactFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType type,
  }) {
    final ContactModel contact = contacts?.singleWhere(
            (ContactModel x) => x.type == type,
        orElse: () => null);
    return contact;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getValueFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }) {

    String _contactValue;

    if (Mapper.checkCanLoopList(contacts) == true){

      _contactValue = getContactFromContacts(
        contacts: contacts,
        type: contactType,
      )?.value;

    }

    return _contactValue;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextEditingController getControllerFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }) {

    TextEditingController _controller;

    if (Mapper.checkCanLoopList(contacts) == true){

      _controller = getContactFromContacts(
        contacts: contacts,
        type: contactType,
      )?.controller;

    }

    return _controller;
  }
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> filterContactsWhichShouldViewValue(List<ContactModel> contacts) {

    final List<ContactModel> _contacts = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final bool _shouldViewString = checkShouldViewValue(type);

      if (_shouldViewString == true){

        final ContactModel _contact = getContactFromContacts(
          contacts: contacts,
          type: type,
        );

        if (ContactModel.checkContactIsEmpty(_contact) == false) {
          _contacts.add(_contact);
        }

      }

    }

    return _contacts;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> filterSocialMediaContacts(List<ContactModel> contacts) {

    final List<ContactModel> _contacts = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final bool _isSocialMedia = checkContactIsSocialMedia(type);

      if (_isSocialMedia == true){

        final ContactModel _contact = getContactFromContacts(
          contacts: contacts,
          type: type,
        );

        if (ContactModel.checkContactIsEmpty(_contact) == false) {
          _contacts.add(_contact);
        }

      }

    }

    return _contacts;
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String concludeContactIcon(ContactType contactType) {
    switch (contactType) {
      case ContactType.phone: return Iconz.comPhone; break;
      case ContactType.email: return Iconz.comEmail; break;
      case ContactType.website: return Iconz.comWebsite; break;
      case ContactType.facebook: return Iconz.comFacebook; break;
      case ContactType.linkedIn: return Iconz.comLinkedin; break;
      case ContactType.youtube: return Iconz.comYoutube; break;
      case ContactType.instagram: return Iconz.comInstagram; break;
      case ContactType.pinterest: return Iconz.comPinterest; break;
      case ContactType.tiktok: return Iconz.comTikTok; break;
      case ContactType.twitter: return Iconz.comTwitter; break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType concludeContactTextInputType({
    @required ContactType contactType,
  }){

    switch (contactType){
      case ContactType.phone:      return TextInputType.phone  ; break;
      case ContactType.email:      return TextInputType.emailAddress  ; break;
      case ContactType.website:    return TextInputType.url  ; break;
      case ContactType.facebook:   return TextInputType.url  ; break;
      case ContactType.linkedIn:   return TextInputType.url  ; break;
      case ContactType.youtube:    return TextInputType.url  ; break;
      case ContactType.instagram:  return TextInputType.url  ; break;
      case ContactType.pinterest:  return TextInputType.url  ; break;
      case ContactType.tiktok:     return TextInputType.url  ; break;
      case ContactType.twitter:    return TextInputType.url  ; break;
      default: return TextInputType.text;
    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> insertOrReplaceContact({
    @required List<ContactModel> contacts,
    @required ContactModel contactToReplace,
  }){
    List<ContactModel> _output = <ContactModel>[];

    /// NOTE : REPLACES CONTACT OF THAT TYPE OR INSERTS NEW ONE

    if (Mapper.checkCanLoopList(contacts) == true && contactToReplace != null){

      _output = <ContactModel>[...contacts];

      final int _index = contacts.indexWhere((element) => element.type == contactToReplace.type);

      if (_index != -1){
        _output.removeAt(_index);
        _output.insert(_index, contactToReplace);
      }
      else{
        _output.insert(_index, contactToReplace);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> dummyContacts(){

    return const <ContactModel>[

      ContactModel(
          value: 'rageh@bldrs.net',
          type: ContactType.email
      ),

      ContactModel(
          value: '0123456789',
          type: ContactType.phone
      ),

    ];

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogContact({
    String invoker = 'ContactModel',
  }){
    blog('$invoker : $type : $value : controller : ${controller?.text}');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogContacts({
    @required List<ContactModel> contacts,
    String invoker = 'Contacts Models',
  }){

    if (Mapper.checkCanLoopList(contacts) == true){
      for (final ContactModel contact in contacts){

        contact.blogContact(
          invoker: invoker,
        );

      }
    }

  }
  // -----------------------------------------------------------------------------

  /// CONTACT OWNER : REQUIRED - BLOCKED

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsRequired({
    @required ContactType contactType,
    @required ContactsOwnerType ownerType,
  }){

    /// USER CONTACTS
    if (ownerType == ContactsOwnerType.user){
      switch (contactType){
        case ContactType.phone:      return false   ; break;
        case ContactType.email:      return true   ; break;
        case ContactType.website:    return false   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return false   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return false   ; break;
        case ContactType.tiktok:     return false   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return false;
      }
    }

    /// BZ CONTACTS
    else if (ownerType == ContactsOwnerType.bz){
      switch (contactType){
        case ContactType.phone:      return true   ; break;
        case ContactType.email:      return true   ; break;
        case ContactType.website:    return false   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return false   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return false   ; break;
        case ContactType.tiktok:     return false   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return false;
      }
    }

    /// AUTHOR CONTACTS
    else {
      switch (contactType){
        case ContactType.phone:      return true   ; break;
        case ContactType.email:      return true   ; break;
        case ContactType.website:    return false   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return false   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return false   ; break;
        case ContactType.tiktok:     return false   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return false;
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsBlocked({
    @required ContactType contactType,
    @required ContactsOwnerType ownerType,
  }){

    /// USER CONTACTS
    if (ownerType == ContactsOwnerType.user){
      switch (contactType){
        case ContactType.phone:      return false   ; break;
        case ContactType.email:      return false   ; break;
        case ContactType.website:    return true   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return true   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return true   ; break;
        case ContactType.tiktok:     return true   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return true;
      }
    }

    /// BZ CONTACTS
    else if (ownerType == ContactsOwnerType.bz){
      switch (contactType){
        case ContactType.phone:      return false   ; break;
        case ContactType.email:      return false   ; break;
        case ContactType.website:    return false   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return false   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return true   ; break;
        case ContactType.tiktok:     return false   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return true;
      }
    }

    /// AUTHOR CONTACTS
    else {
      switch (contactType){
        case ContactType.phone:      return false   ; break;
        case ContactType.email:      return false   ; break;
        case ContactType.website:    return false   ; break;
        case ContactType.facebook:   return false   ; break;
        case ContactType.linkedIn:   return false   ; break;
        case ContactType.youtube:    return false   ; break;
        case ContactType.instagram:  return false   ; break;
        case ContactType.pinterest:  return true   ; break;
        case ContactType.tiktok:     return false   ; break;
        case ContactType.twitter:    return false   ; break;
        default: return true;
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// changes CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactsListsAreIdentical({
    @required List<ContactModel> contacts1,
    @required List<ContactModel> contacts2,
  }){
    bool _identical = false;

    if (contacts1 == null && contacts2 == null){
      _identical = true;
    }
    else if (contacts1?.isEmpty == true && contacts2?.isEmpty == true){
      _identical = true;
    }
    else if (contacts1 != null && contacts2 != null){
      if (contacts1.length == contacts2.length){

        bool _allContactsAreIdentical = false;

        for (int i = 0; i < contacts1.length; i++){

          final bool _areIdentical = checkContactsAreIdentical(
            contact1: contacts1[i],
            contact2: contacts2[i],
          );

          if (_areIdentical == false){
            _allContactsAreIdentical = false;
            break;
          }
          else {
            _allContactsAreIdentical = true;
          }

        }

        if (_allContactsAreIdentical == true){
          _identical = true;
        }

      }
    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactsAreIdentical({
    @required ContactModel contact1,
    @required ContactModel contact2,
  }){
    bool _areIdentical = false;

    if (contact1 != null && contact2 != null){

      if (
          contact1.value  == contact2.value &&
          contact1.type == contact2.type &&
          contact1?.controller?.text == contact2?.controller?.text
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkEmailChanged({
    @required List<ContactModel> oldContacts,
    @required List<ContactModel> newContacts,
  }){
    bool _changed = false;

    final ContactModel _oldModel = getContactFromContacts(
      contacts: oldContacts,
      type: ContactType.email,
    );

    final ContactModel _newModel = getContactFromContacts(
      contacts: newContacts,
      type: ContactType.email,
    );

    blog('checkEmailChanged : ${_oldModel.value} == ${_newModel.value} ?');

    if (_oldModel?.value != _newModel?.value){
      _changed = true;
    }

    return _changed;
  }
  // -----------------------------------------------------------------------------

  /// TYPE CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsEmpty(ContactModel contact){
    bool _isEmpty = true;

    if (contact != null){

      if (contact.type != null){

        if (TextCheck.isEmpty(contact.value) == false){
          _isEmpty = false;
        }

      }

    }

    return _isEmpty;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsSocialMedia(ContactType type){

    switch (type) {

      case ContactType.phone:     return false; break;
      case ContactType.email:     return false; break;

      case ContactType.website:   return false; break;

      case ContactType.facebook:  return true; break;
      case ContactType.linkedIn:  return true; break;
      case ContactType.youtube:   return true; break;
      case ContactType.instagram: return true; break;
      case ContactType.pinterest: return true; break;
      case ContactType.tiktok:    return true; break;
      case ContactType.twitter:   return true; break;

      default: return false;

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsWebLink(ContactType type){
    switch (type) {

      case ContactType.phone:     return false; break;
      case ContactType.email:     return false; break;

      case ContactType.website:   return true; break;

      case ContactType.facebook:  return true; break;
      case ContactType.linkedIn:  return true; break;
      case ContactType.youtube:   return true; break;
      case ContactType.instagram: return true; break;
      case ContactType.pinterest: return true; break;
      case ContactType.tiktok:    return true; break;
      case ContactType.twitter:   return true; break;

      default: return false;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldViewValue(ContactType type){
    switch (type) {

      case ContactType.phone:     return true; break;
      case ContactType.email:     return true; break;

      case ContactType.website:   return true; break;

      case ContactType.facebook:  return false; break;
      case ContactType.linkedIn:  return false; break;
      case ContactType.youtube:   return false; break;
      case ContactType.instagram: return false; break;
      case ContactType.pinterest: return false; break;
      case ContactType.tiktok:    return false; break;
      case ContactType.twitter:   return false; break;

      default: return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ContactModel){
      _areIdentical = checkContactsAreIdentical(
        contact1: this,
        contact2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      value.hashCode^
      type.hashCode^
      controller.hashCode;
  // -----------------------------------------------------------------------------
}
