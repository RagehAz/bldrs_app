import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
enum ContactsOwnerType {
  bz,
  author,
  user,
}
// -----------------------------------------------------------------------------
@immutable
class ContactModel {
  /// --------------------------------------------------------------------------
  const ContactModel({
    @required this.value,
    @required this.contactType,
  });
  /// --------------------------------------------------------------------------
  final String value;
  final ContactType contactType;
// -----------------------------------------------------------------------------

  /// INITIALIZERS

// ----------------------------------
  static List<ContactModel> createContactsList({
    List<ContactModel> existingContacts,
    String phone,
    String email,
    String webSite,
    String facebook,
    String linkedIn,
    String youTube,
    String instagram,
    String pinterest,
    String tikTok,
    String twitter,
  }) {
    final List<ContactModel> _newContacts = <ContactModel>[];
    // ---------------
    addContactIfPossibleToANewContactsList(existingContacts, phone, ContactType.phone, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, email, ContactType.email, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, webSite, ContactType.website, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, facebook, ContactType.facebook, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, linkedIn, ContactType.linkedIn, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, youTube, ContactType.youtube, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, instagram, ContactType.instagram, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, pinterest, ContactType.pinterest, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, tikTok, ContactType.tiktok, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, twitter, ContactType.twitter, _newContacts);
    // ---------------
    return _newContacts;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String initializePhoneValue({
    @required ZoneModel zone,
    @required List<ContactModel> contacts,
  }){
    return TextMod.initializePhoneNumber(
      countryID : zone?.countryID,
      number : ContactModel.getAContactValueFromContacts(
          contacts: contacts,
          contactType: ContactType.phone
      ),
    );
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String initializeWebLinkValue({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }){
    return TextMod.initializeWebLink(
        url: ContactModel.getAContactValueFromContacts(
          contacts: contacts,
          contactType: contactType,
        )
    );
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<TextEditingController> initializeContactsControllers({
    @required List<ContactModel> existingContacts,
    @required String countryID,
  }){

    final List<TextEditingController> _controllers = <TextEditingController>[];

    for (final ContactType contactType in contactTypesList){

      String _initialValue;

      /// GET EXISTING CONTACT
      final ContactModel _existingContact = existingContacts.firstWhere(
            (contact) => contact.contactType == contactType, orElse: () => null,
      );

      /// CONTACT NOT FOUND => DEFINE INITIAL VALUE
      if (_existingContact == null){

        /// IF PHONE
        if (contactType == ContactType.phone){
          _initialValue = TextMod.initializePhoneNumber(
            countryID : countryID,
            number : null,
          );
        }
        /// IF WEB LINK
        else if (checkContactTypeIsWebLink(contactType) == true){
          _initialValue = ContactModel.initializeWebLinkValue(
            contacts: [],
            contactType: contactType,
          );
        }
        /// OTHERWISE
        else {
          _initialValue = '';
        }

      }

      /// CONTACT FOUND
      else {
        _initialValue = _existingContact.value;
      }

      /// ASSIGN THE CONTROLLER WITH INITIAL VALUE
      final TextEditingController _controller = TextEditingController(
        text: _initialValue,
      );
      _controllers.add(_controller);

    }

    return _controllers;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> createContactsListByGeneratedControllers({
    @required List<TextEditingController> generatedControllers,
    @required String countryID,
  }){

    /// NOTE : CONTROLLERS SHOULD BE AUTO GENERATED BY [generateContactsControllers] method

    final List<ContactModel> _models = <ContactModel>[];

    for (int i = 0; i < generatedControllers.length; i++){

      final TextEditingController _controller = generatedControllers[i];
      final ContactType _contactType = contactTypesList[i];

      String _endValue;

      /// IF PHONE
      if (_contactType == ContactType.phone){
        _endValue = TextMod.nullifyNumberIfOnlyCountryCode(
          number: _controller.text,
          countryID: countryID,
        );
      }
      /// IF WEB LINK
      else if (checkContactTypeIsWebLink(_contactType) == true){
        _endValue = TextMod.nullifyUrlLinkIfOnlyHTTPS(url: _controller.text);
      }
      /// OTHERWISE
      else {
        _endValue = _controller.text;
      }

      final ContactModel _model = ContactModel(
        contactType: _contactType,
        value: _endValue,
      );

      if (TextChecker.textControllerIsEmpty(_controller) == false){
        _models.add(_model);
      }

    }

    return _models;
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap() {
    return <String, Object>{
      'value': value,
      'contactType': cipherContactType(contactType),
    };
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Map<String, Object> cipherContacts(List<ContactModel> contacts) {
    Map<String, Object> _map = <String, Object>{};

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel contact in contacts) {
        if (contact.value != null && contact.value != '') {
          _map = Mapper.insertPairInMap(
            map: _map,
            key: cipherContactType(contact.contactType),
            value: contact.value,
          );
        }
      }
    }

    return _map;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> decipherContacts(Map<String, dynamic> maps) {
    final List<ContactModel> _contacts = <ContactModel>[];

    if (maps != null) {
      final List<String> _keys = maps.keys.toList();

      if (Mapper.checkCanLoopList(_keys)) {
        for (final String key in _keys) {

          final ContactModel _contact = ContactModel(
              value: maps[key],
              contactType: decipherContactType(key)
          );

          _contacts.add(_contact);

        }
      }
    }

    return _contacts;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static ContactType decipherContactType(String contactType) {
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
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String cipherContactType(ContactType contactType) {
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

  /// TRANSLATION

// ----------------------------------
  static String translateContactType({
    @required BuildContext context,
    @required ContactType contactType,
  }){

    switch (contactType){
      case ContactType.phone:      return 'phone'; break;
      case ContactType.email:      return 'email'; break;
      case ContactType.website:    return 'website'; break;
      case ContactType.facebook:   return 'facebook'; break;
      case ContactType.linkedIn:   return 'linkedIn'; break;
      case ContactType.youtube:    return 'youtube'; break;
      case ContactType.instagram:  return 'instagram'; break;
      case ContactType.pinterest:  return 'pinterest'; break;
      case ContactType.tiktok:     return 'tiktok'; break;
      case ContactType.twitter:    return 'twitter'; break;
      default: return null;

    }

  }
// -----------------------------------------------------------------------------

  /// GETTERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static ContactModel getAContactModelFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }) {
    final ContactModel contact = contacts?.singleWhere(
        (ContactModel x) => x.contactType == contactType,
        orElse: () => null);
    return contact;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String getAContactValueFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }) {

    String _contactValue;

    if (Mapper.checkCanLoopList(contacts) == true){

      _contactValue = getAContactModelFromContacts(
        contacts: contacts,
        contactType: contactType,
      )?.value;

    }

    return _contactValue;
  }
// ----------------------------------
  static List<ContactModel> getContactsWithStringsFromContacts(List<ContactModel> contacts) {
  /// contacts with strings
  /// are Phone, Email, WhatsApp, website
  /// which are presented by both string of value and an icon

    final List<ContactModel> _contactsList = <ContactModel>[];

    final ContactModel _phone = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.phone,
    );

    final ContactModel _email = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.email,
    );

    final ContactModel _website = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.website,
    );

    if (ContactModel.checkContactIsEmpty(_phone) == false) {
      _contactsList.add(_phone);
    }

    if (ContactModel.checkContactIsEmpty(_email) == false) {
      _contactsList.add(_email);
    }

    if (ContactModel.checkContactIsEmpty(_website) == false) {
      _contactsList.add(_website);
    }

    return _contactsList;
  }
// ----------------------------------
  static List<ContactModel> getSocialMediaContactsFromContacts(List<ContactModel> contacts) {
  /// contacts without strings
  /// are Facebook LinkedIn YouTube Instagram Pinterest TikTok Twitter
    final List<ContactModel> _contactsList = <ContactModel>[];

    final ContactModel _facebook = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.facebook,
    );
    final ContactModel _linkedin = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.linkedIn,
    );
    final ContactModel _youtube = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.youtube,
    );
    final ContactModel _instagram = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.instagram,
    );
    final ContactModel _pinterest = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.pinterest,
    );
    final ContactModel _tiktok = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.tiktok,
    );
    final ContactModel _twitter = getAContactModelFromContacts(
        contacts: contacts,
        contactType: ContactType.twitter,
    );

    if (ContactModel.checkContactIsEmpty(_facebook) == false) {
      _contactsList.add(_facebook);
    }

    if (ContactModel.checkContactIsEmpty(_linkedin) == false) {
      _contactsList.add(_linkedin);
    }

    if (ContactModel.checkContactIsEmpty(_youtube) == false) {
      _contactsList.add(_youtube);
    }

    if (ContactModel.checkContactIsEmpty(_instagram) == false) {
      _contactsList.add(_instagram);
    }

    if (ContactModel.checkContactIsEmpty(_pinterest) == false) {
      _contactsList.add(_pinterest);
    }

    if (ContactModel.checkContactIsEmpty(_tiktok) == false) {
      _contactsList.add(_tiktok);
    }

    if (ContactModel.checkContactIsEmpty(_twitter) == false) {
      _contactsList.add(_twitter);
    }

    return _contactsList;
  }
// ----------------------------------
  static String getFirstPhoneFromContacts(List<ContactModel> contacts) {
  /// will let user to only have one phone contact
    // String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
    final List<String> phones = <String>[];

    for (final ContactModel co in contacts) {
      if (co.contactType == ContactType.phone) {
        phones.add(co.value);
      }
    }

    return phones.isEmpty ? null : phones[0];
  }
// ----------------------------------
  static List<String> getListOfValuesFromContactsModelsList(List<ContactModel> contacts) {
    final List<String> values = <String>[];

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel co in contacts) {
        values.add(co.value);
      }
    }

    return values;
  }
// ----------------------------------
  static List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts) {
    final List<String> icons = <String>[];

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel co in contacts) {
        icons.add(ContactModel.getContactIcon(co.contactType));
      }
    }

    return icons;
  }
// ----------------------------------
  static List<ContactModel> getContactsFromFirebaseUser(User user) {
    final List<ContactModel> _userContacts = <ContactModel>[];
    final String _userEmail = user.email;
    final String _userPhone = user.phoneNumber;

    if (_userEmail != null) {
      _userContacts.add(
          ContactModel(value: _userEmail, contactType: ContactType.email));
    }

    if (_userPhone != null) {
      _userContacts.add(
          ContactModel(value: _userPhone, contactType: ContactType.phone));
    }

    return _userContacts;
  }
// ----------------------------------
  static TextInputType getContactTextInputType({
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

  /// CONTACT TYPE GETTERS

// ----------------------------------
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
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static String getContactIcon(ContactType contactType) {
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
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ----------------------------------
  static void addContactIfPossibleToANewContactsList(
    List<ContactModel> existingContacts,
    String value,
    ContactType type,
    List<ContactModel> newContacts,
  ) {

    final String _existingContactValue = getAContactValueFromContacts(
        contacts: existingContacts,
        contactType: type,
    );

    bool _contactExistsInExistingContacts;

    if (_existingContactValue == null || _existingContactValue == '') {
      _contactExistsInExistingContacts = false;
    }

    else {
      _contactExistsInExistingContacts = true;
    }

    bool _userChangedValue;

    if (value == null) {
      _userChangedValue = false;
    }

    else {
      _userChangedValue = true;
    }

    /// when contact already exists in existingContacts
    if (_contactExistsInExistingContacts == true) {

      /// if value have changed add this new value otherwise add the existing value
      if (_userChangedValue == true) {
        newContacts.add(ContactModel(value: value, contactType: type));
      }

      else {
        newContacts.add(
            ContactModel(value: _existingContactValue, contactType: type));
      }

    }

    /// when contact is new to existingContacts
    else {
      /// add new ContactModel to the new list only if a new value is assigned ( value != null )
      if (_userChangedValue == true) {
        newContacts.add(ContactModel(value: value, contactType: type));
      }
    }
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> replaceContact({
    @required List<ContactModel> contacts,
    @required ContactModel contactToReplace,
  }){
    List<ContactModel> _output = <ContactModel>[];

    if (Mapper.checkCanLoopList(contacts) == true && contactToReplace != null){

      _output = <ContactModel>[...contacts];

      final int _index = contacts.indexWhere((element) => element.contactType == contactToReplace.contactType);

      if (_index != -1){
        _output.removeAt(_index);
        _output.insert(_index, contactToReplace);
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> dummyContacts(){

    return const <ContactModel>[

      ContactModel(
          value: 'rageh@bldrs.net',
          contactType: ContactType.email
      ),

      ContactModel(
          value: '0123456789',
          contactType: ContactType.phone
      ),

    ];

  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// ----------------------------------
  /// TESTED : WORKS PERFECT
  void blogContact({
    String methodName = 'ContactModel',
  }){
    blog('$methodName : $contactType : $value');
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static void blogContacts({
    @required List<ContactModel> contacts,
    String methodName = 'Contacts Models',
  }){

    if (Mapper.checkCanLoopList(contacts) == true){
      for (final ContactModel contact in contacts){

        contact.blogContact(
          methodName: methodName,
        );

      }
    }

  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsEmpty(ContactModel contact){
    bool _isEmpty = true;

    if (contact != null){

      if (contact.contactType != null){

        if (Stringer.checkStringIsEmpty(contact.value) == false){
          _isEmpty = false;
        }

      }

    }

    return _isEmpty;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsSocialMedia(ContactModel contact){
    bool _isSocialMedia = false;

    if (
    contact.contactType == ContactType.facebook
    ||
    contact.contactType == ContactType.instagram
    ||
    contact.contactType == ContactType.linkedIn
    ||
    contact.contactType == ContactType.instagram
    ||
    contact.contactType == ContactType.pinterest
    ||
    contact.contactType == ContactType.tiktok
    ||
    contact.contactType == ContactType.twitter
    ||
    contact.contactType == ContactType.youtube
    ){
      _isSocialMedia = true;
    }

    return _isSocialMedia;
  }
// ----------------------------------
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
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactsAreIdentical({
    @required ContactModel contact1,
    @required ContactModel contact2,
  }){
    bool _areIdentical = false;

    if (contact1 != null && contact2 != null){

      if (
      contact1.value == contact2.value &&
      contact1.contactType == contact2.contactType
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// ----------------------------------
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
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsWebLink(ContactModel contact){
    bool _isWebLink = false;

    if (contact != null){

      if (ObjectChecker.objectIsURL(contact.value) == true){
        _isWebLink = true;
      }
      else if (contact.contactType == ContactType.website){
        _isWebLink = true;
      }
      else {
        _isWebLink = checkContactIsSocialMedia(contact);
      }

    }

    return _isWebLink;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkEmailChanged({
    @required List<ContactModel> oldContacts,
    @required List<ContactModel> newContacts,
  }){
    bool _changed = false;

    final ContactModel _oldModel = getAContactModelFromContacts(
        contacts: oldContacts,
        contactType: ContactType.email,
    );

    final ContactModel _newModel = getAContactModelFromContacts(
      contacts: newContacts,
      contactType: ContactType.email,
    );

    blog('checkEmailChanged : ${_oldModel.value} == ${_newModel.value} ?');

    if (_oldModel?.value != _newModel?.value){
      _changed = true;
    }

    return _changed;
  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactTypeIsWebLink(ContactType contactType){
    switch (contactType) {

      case ContactType.phone: return false; break;
      case ContactType.email: return false; break;

      case ContactType.website: return true; break;
      case ContactType.facebook: return true; break;
      case ContactType.linkedIn: return true; break;
      case ContactType.youtube: return true; break;
      case ContactType.instagram: return true; break;
      case ContactType.pinterest: return true; break;
      case ContactType.tiktok: return true; break;
      case ContactType.twitter: return true; break;

      default: return false;
    }
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
