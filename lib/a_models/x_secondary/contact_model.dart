import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/object_check.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:collection/collection.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

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
    required this.value,
    required this.type,
  });
  /// --------------------------------------------------------------------------
  final String? value;
  final ContactType? type;
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
  // --------------------
  static const List<ContactType> socialTypes = <ContactType>[
    ContactType.facebook,
    ContactType.linkedIn,
    ContactType.youtube,
    ContactType.instagram,
    ContactType.pinterest,
    ContactType.tiktok,
    ContactType.twitter,
  ];
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ContactModel copyWith({
    String? value,
    ContactType? type,
  }){
    return ContactModel(
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> generateContactsFromFirebaseUser(User? user) {
    return generateBasicContacts(
      email: user?.email,
      phone: user?.phoneNumber,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> generateBasicContacts({
    required String? email,
    required String? phone,
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
  static Map<String, dynamic> cipherContacts(List<ContactModel>? contacts) {
    Map<String, dynamic> _map = <String, dynamic>{};

    if (Mapper.checkCanLoopList(contacts) == true) {
      for (final ContactModel contact in contacts!) {
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
  static List<ContactModel> decipherContacts(Map<String, dynamic>? map) {
    final List<ContactModel> _contacts = <ContactModel>[];

    if (map != null) {
      final List<String> _keys = map.keys.toList();

      if (Mapper.checkCanLoopList(_keys) == true) {

        for (final String key in _keys) {

          final ContactModel _contact = ContactModel(
              value: map[key],
              type: _decipherContactType(key)!,
          );

          _contacts.add(_contact);

        }
      }
    }

    return _contacts;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ContactType? _decipherContactType(String? contactType) {
    switch (contactType) {
      case 'phone':     return ContactType.phone;
      case 'email':     return ContactType.email;
      case 'website':   return ContactType.website;
      case 'facebook':  return ContactType.facebook;
      case 'linkedIn':  return ContactType.linkedIn;
      case 'youtube':   return ContactType.youtube;
      case 'instagram': return ContactType.instagram;
      case 'pinterest': return ContactType.pinterest;
      case 'tiktok':    return ContactType.tiktok;
      case 'twitter':   return ContactType.twitter;
      default:          return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _cipherContactType(ContactType? contactType) {
    switch (contactType) {
      case ContactType.phone:     return 'phone';
      case ContactType.email:     return 'email';
      case ContactType.website:   return 'website';
      case ContactType.facebook:  return 'facebook';
      case ContactType.linkedIn:  return 'linkedIn';
      case ContactType.youtube:   return 'youtube';
      case ContactType.instagram: return 'instagram';
      case ContactType.pinterest: return 'pinterest';
      case ContactType.tiktok:    return 'tiktok';
      case ContactType.twitter:   return 'twitter';
      default:  return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// EDITING INITIALIZERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> prepareContactsForEditing({
    required List<ContactModel>? contacts,
    required String? countryID,
  }){
    final List<ContactModel> _output = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final ContactModel? _existingContact = getContactFromContacts(
        contacts: contacts,
        type: type,
      );

      final String? _initialValue = _initializeContactValue(
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
  static String? getInitialContactValue({
    required List<ContactModel>? existingContacts,
    required ContactType type,
    required String? countryID,
  }){

    final ContactModel? _existingContact = getContactFromContacts(
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
  static String? _initializeContactValue({
    required ContactModel? existingContact,
    required ContactType type,
    required String? countryID,
  }){
    String? _output = '';


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
  // -----------------------------------------------------------------------------

  /// EDITING FINISHING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> bakeContactsAfterEditing({
    required List<ContactModel>? contacts,
    required String? countryID,
  }){

    final List<ContactModel> _output = <ContactModel>[];

    if (Mapper.checkCanLoopList(contacts) == true){

      for (int i = 0; i < contacts!.length; i++){

        final ContactModel _contact = contacts[i];
        final ContactType? _contactType = _contact.type;
        final String? _value = _contact.value;

        String? _endValue;

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
  static String? getContactTypePhid({
    required ContactType? contactType,
  }){

    switch (contactType){
      case ContactType.phone:      return 'phid_phone';
      case ContactType.email:      return 'phid_emailAddress';
      case ContactType.website:    return 'phid_website';
      case ContactType.facebook:   return 'phid_facebook';
      case ContactType.linkedIn:   return 'phid_linkedIn';
      case ContactType.youtube:    return 'phid_youtube';
      case ContactType.instagram:  return 'phid_instagram';
      case ContactType.pinterest:  return 'phid_pinterest';
      case ContactType.tiktok:     return 'phid_tiktok';
      case ContactType.twitter:    return 'phid_twitter';
      default: return null;

    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ContactModel? getContactFromContacts({
    required List<ContactModel>? contacts,
    required ContactType? type,
  }) {
    final ContactModel? contact = contacts?.firstWhereOrNull((ContactModel x) => x.type == type);
    return contact;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getValueFromContacts({
    required List<ContactModel>? contacts,
    required ContactType? contactType,
  }) {

    String? _contactValue;

    if (Mapper.checkCanLoopList(contacts) == true){

      _contactValue = getContactFromContacts(
        contacts: contacts,
        type: contactType,
      )?.value;

    }

    return _contactValue;
  }
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> filterContactsWhichShouldViewValue(List<ContactModel>? contacts) {

    final List<ContactModel> _contacts = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final bool _shouldViewString = checkShouldViewValue(type);

      if (_shouldViewString == true){

        final ContactModel? _contact = getContactFromContacts(
          contacts: contacts,
          type: type,
        );

        if (ContactModel.checkContactIsEmpty(_contact) == false) {
          _contacts.add(_contact!);
        }

      }

    }

    return _contacts;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> filterSocialMediaContacts(List<ContactModel>? contacts) {

    final List<ContactModel> _contacts = <ContactModel>[];

    for (final ContactType type in contactTypesList){

      final bool _isSocialMedia = checkContactIsSocialMedia(type);

      if (_isSocialMedia == true){

        final ContactModel? _contact = getContactFromContacts(
          contacts: contacts,
          type: type,
        );

        if (ContactModel.checkContactIsEmpty(_contact) == false) {
          _contacts.add(_contact!);
        }

      }

    }

    return _contacts;
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? concludeContactIcon({
    required ContactType? contactType,
    required bool isPublic,
  }) {

    if (isPublic == false){
      return Iconz.hidden;
    }

    else {
      switch (contactType) {
        case ContactType.phone: return Iconz.comPhone;
        case ContactType.email: return Iconz.comEmail;
        case ContactType.website: return Iconz.comWebsite;
        case ContactType.facebook: return Iconz.comFacebook;
        case ContactType.linkedIn: return Iconz.comLinkedin;
        case ContactType.youtube: return Iconz.comYoutube;
        case ContactType.instagram: return Iconz.comInstagram;
        case ContactType.pinterest: return Iconz.comPinterest;
        case ContactType.tiktok: return Iconz.comTikTok;
        case ContactType.twitter: return Iconz.comTwitter;
        default: return null;
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double concludeContactIconSizeFactor({
    required ContactType? contactType,
    required bool isPublic,
  }) {

    const double _small = 0.6;

    if (isPublic == false){
      return _small; //Iconz.hidden;
    }

    else {
      switch (contactType) {
        case ContactType.phone:     return _small; // Iconz.comPhone;
        case ContactType.email:     return _small; // Iconz.comEmail;
        case ContactType.website:   return _small; // Iconz.comWebsite;
        case ContactType.facebook:  return 1; // Iconz.comFacebook;
        case ContactType.linkedIn:  return 1; // Iconz.comLinkedin;
        case ContactType.youtube:   return 1; // Iconz.comYoutube;
        case ContactType.instagram: return 1; // Iconz.comInstagram;
        case ContactType.pinterest: return 1; // Iconz.comPinterest;
        case ContactType.tiktok:    return 1; // Iconz.comTikTok;
        case ContactType.twitter:   return 1; // Iconz.comTwitter;
        default: return 1;
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType concludeContactTextInputType({
    required ContactType? contactType,
  }){

    switch (contactType){
      case ContactType.phone:      return TextInputType.phone  ;
      case ContactType.email:      return TextInputType.emailAddress  ;
      case ContactType.website:    return TextInputType.url  ;
      case ContactType.facebook:   return TextInputType.url  ;
      case ContactType.linkedIn:   return TextInputType.url  ;
      case ContactType.youtube:    return TextInputType.url  ;
      case ContactType.instagram:  return TextInputType.url  ;
      case ContactType.pinterest:  return TextInputType.url  ;
      case ContactType.tiktok:     return TextInputType.url  ;
      case ContactType.twitter:    return TextInputType.url  ;
      default: return TextInputType.text;
    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ContactModel> insertOrReplaceContact({
    required List<ContactModel>? contacts,
    required ContactModel? contactToReplace,
  }){
    final List<ContactModel> _output = <ContactModel>[...?contacts];

    /// NOTE : REPLACES CONTACT OF THAT TYPE OR INSERTS NEW ONE

    if (contactToReplace != null){

      final int _index = _output.indexWhere((element) => element.type == contactToReplace.type);

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
    blog('$invoker : $type : $value');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogContacts({
    required List<ContactModel>? contacts,
    String invoker = 'Contacts Models',
  }){

    if (Mapper.checkCanLoopList(contacts) == true){
      for (final ContactModel contact in contacts!){

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
    required ContactType? contactType,
    required ContactsOwnerType? ownerType,
  }){

    /// USER CONTACTS
    if (ownerType == ContactsOwnerType.user){
      switch (contactType){
        case ContactType.phone:      return false   ;
        case ContactType.email:      return true   ;
        case ContactType.website:    return false   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return false   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return false   ;
        case ContactType.tiktok:     return false   ;
        case ContactType.twitter:    return false   ;
        default: return false;
      }
    }

    /// BZ CONTACTS
    else if (ownerType == ContactsOwnerType.bz){
      switch (contactType){
        case ContactType.phone:      return true   ;
        case ContactType.email:      return true   ;
        case ContactType.website:    return false   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return false   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return false   ;
        case ContactType.tiktok:     return false   ;
        case ContactType.twitter:    return false   ;
        default: return false;
      }
    }

    /// AUTHOR CONTACTS
    else {
      switch (contactType){
        case ContactType.phone:      return true   ;
        case ContactType.email:      return true   ;
        case ContactType.website:    return false   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return false   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return false   ;
        case ContactType.tiktok:     return false   ;
        case ContactType.twitter:    return false   ;
        default: return false;
      }
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsBlocked({
    required ContactType? contactType,
    required ContactsOwnerType ?ownerType,
  }){

    /// USER CONTACTS
    if (ownerType == ContactsOwnerType.user){
      switch (contactType){
        case ContactType.phone:      return false   ;
        case ContactType.email:      return false   ;
        case ContactType.website:    return true   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return true   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return true   ;
        case ContactType.tiktok:     return true   ;
        case ContactType.twitter:    return false   ;
        default: return true;
      }
    }

    /// BZ CONTACTS
    else if (ownerType == ContactsOwnerType.bz){
      switch (contactType){
        case ContactType.phone:      return false   ;
        case ContactType.email:      return false   ;
        case ContactType.website:    return false   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return false   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return true   ;
        case ContactType.tiktok:     return false   ;
        case ContactType.twitter:    return false   ;
        default: return true;
      }
    }

    /// AUTHOR CONTACTS
    else {
      switch (contactType){
        case ContactType.phone:      return false   ;
        case ContactType.email:      return false   ;
        case ContactType.website:    return false   ;
        case ContactType.facebook:   return false   ;
        case ContactType.linkedIn:   return false   ;
        case ContactType.youtube:    return false   ;
        case ContactType.instagram:  return false   ;
        case ContactType.pinterest:  return true   ;
        case ContactType.tiktok:     return false   ;
        case ContactType.twitter:    return false   ;
        default: return true;
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// changes CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactsListsAreIdentical({
    required List<ContactModel>? contacts1,
    required List<ContactModel>? contacts2,
  }){
    bool _identical = false;

    if (contacts1 == null && contacts2 == null){
      _identical = true;
    }
    else if (contacts1 != null && contacts1.isEmpty == true && contacts2 != null && contacts2.isEmpty == true){
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
    required ContactModel? contact1,
    required ContactModel? contact2,
  }){
    bool _areIdentical = false;

    if (contact1 != null && contact2 != null){

      if (
          contact1.value  == contact2.value &&
          contact1.type == contact2.type
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkEmailChanged({
    required List<ContactModel>? oldContacts,
    required List<ContactModel>? newContacts,
  }){
    bool _changed = false;

    final ContactModel? _oldModel = getContactFromContacts(
      contacts: oldContacts,
      type: ContactType.email,
    );

    final ContactModel? _newModel = getContactFromContacts(
      contacts: newContacts,
      type: ContactType.email,
    );

    // blog('checkEmailChanged : ${_oldModel?.value} == ${_newModel?.value} ?');

    if (_oldModel?.value != _newModel?.value){
      _changed = true;
    }

    return _changed;
  }
  // -----------------------------------------------------------------------------

  /// TYPE CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkContactIsEmpty(ContactModel? contact){
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
  static bool checkContactIsSocialMedia(ContactType? type){

    switch (type) {

      case ContactType.phone:     return false;
      case ContactType.email:     return false;
      case ContactType.website:   return false;
      case ContactType.facebook:  return true;
      case ContactType.linkedIn:  return true;
      case ContactType.youtube:   return true;
      case ContactType.instagram: return true;
      case ContactType.pinterest: return true;
      case ContactType.tiktok:    return true;
      case ContactType.twitter:   return true;

      default: return false;

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsWebLink(ContactType? type){
    switch (type) {

      case ContactType.phone:     return false;
      case ContactType.email:     return false;
      case ContactType.website:   return true;
      case ContactType.facebook:  return true;
      case ContactType.linkedIn:  return true;
      case ContactType.youtube:   return true;
      case ContactType.instagram: return true;
      case ContactType.pinterest: return true;
      case ContactType.tiktok:    return true;
      case ContactType.twitter:   return true;

      default: return false;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldViewValue(ContactType? type){
    switch (type) {

      case ContactType.phone:     return true;
      case ContactType.email:     return true;
      case ContactType.website:   return true;
      case ContactType.facebook:  return false;
      case ContactType.linkedIn:  return false;
      case ContactType.youtube:   return false;
      case ContactType.instagram: return false;
      case ContactType.pinterest: return false;
      case ContactType.tiktok:    return false;
      case ContactType.twitter:   return false;

      default: return false;
    }
  }
  // -----------------------------------------------------------------------------

  /// URL CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSocialLinkIsValid({
    required String? url,
    required ContactType? type,
  }) {

    if (TextCheck.isEmpty(url) == true || ObjectCheck.isURLFormat(url) == false) {
      return false;
    }

    else {

      String? _domain;
      switch (type){
        case ContactType.phone:      _domain = null; break;
        case ContactType.email:      _domain = null; break;
        case ContactType.website:    _domain = null; break;
        case ContactType.facebook:   _domain = 'facebook.com'; break;
        case ContactType.linkedIn:   _domain = 'linkedin.com'; break;
        case ContactType.youtube:    _domain = 'youtube.com'; break; // youtu.be
        case ContactType.instagram:  _domain = 'instagram.com'; break;
        case ContactType.pinterest:  _domain = 'pinterest.com'; break;
        case ContactType.tiktok:     _domain = 'tiktok.com'; break;
        case ContactType.twitter:    _domain = 'twitter.com'; break;
        default:                     _domain = null;
      }

      if (_domain != null){
        return TextCheck.stringContainsSubString(
          string: url,
          subString: _domain,
        );
      }
      else {
        return false;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ContactType? concludeContactTypeByURLDomain({
    required String? url,
  }){
    ContactType? _output;

    if (ObjectCheck.isURLFormat(url) == true){
      switch(url){
        case 'facebook.com':   _output = ContactType.facebook; break;
        case 'linkedin.com':   _output = ContactType.linkedIn; break;
        case 'youtube.com':    _output = ContactType.youtube; break;
        case 'youtu.be':       _output = ContactType.youtube; break;
        case 'instagram.com':  _output = ContactType.instagram; break;
        case 'pinterest.com':  _output = ContactType.pinterest; break;
        case 'tiktok.com':     _output = ContactType.tiktok; break;
        case 'twitter.com':    _output = ContactType.twitter; break;
        default:               _output = null;
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getSocialContactIsNotValidPhid({
    required ContactType? type,
  }){
    String? _phid;

    switch (type){
      case ContactType.phone:      _phid = null; break;
      case ContactType.email:      _phid = null; break;
      case ContactType.website:    _phid = null; break;
      case ContactType.facebook:   _phid = 'phid_facebook_link_is_invalid'; break;
      case ContactType.linkedIn:   _phid = 'phid_linkedin_link_is_invalid'; break;
      case ContactType.youtube:    _phid = 'phid_youtube_link_is_invalid'; break;
      case ContactType.instagram:  _phid = 'phid_instagram_link_is_invalid'; break;
      case ContactType.pinterest:  _phid = 'phid_pinterest_link_is_invalid'; break;
      case ContactType.tiktok:     _phid = 'phid_tiktok_link_is_invalid'; break;
      case ContactType.twitter:    _phid = 'phid_twitter_link_is_invalid'; break;
      default:                     _phid = null;
    }

    return _phid;
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
      type.hashCode;
  // -----------------------------------------------------------------------------
}
