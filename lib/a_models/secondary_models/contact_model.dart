import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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

// ----------------------------------------
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
// -----------------------------------------------------------------------------

  /// CYPHERS

// ----------------------------------------
  Map<String, Object> toMap() {
    return <String, Object>{
      'value': value,
      'contactType': cipherContactType(contactType),
    };
  }
// ----------------------------------------
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
// ----------------------------------------
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
// ----------------------------------------
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
// ----------------------------------------
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

  /// GETTERS

// ----------------------------------------
  static ContactModel getAContactModelFromContacts({
    @required List<ContactModel> contacts,
    @required ContactType contactType,
  }) {
    final ContactModel contact = contacts?.singleWhere(
        (ContactModel x) => x.contactType == contactType,
        orElse: () => null);
    return contact;
  }
// ----------------------------------------
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
// ----------------------------------------
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
// ----------------------------------------
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
// ----------------------------------------
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
// ----------------------------------------
  static List<String> getListOfValuesFromContactsModelsList(List<ContactModel> contacts) {
    final List<String> values = <String>[];

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel co in contacts) {
        values.add(co.value);
      }
    }

    return values;
  }
// ----------------------------------------
  static List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts) {
    final List<String> icons = <String>[];

    if (Mapper.checkCanLoopList(contacts)) {
      for (final ContactModel co in contacts) {
        icons.add(ContactModel.getContactIcon(co.contactType));
      }
    }

    return icons;
  }
// ----------------------------------------
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
// -----------------------------------------------------------------------------

  /// CONTACT TYPE GETTERS

// ----------------------------------------
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
// ----------------------------------------
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

// ----------------------------------------
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
// -----------------------------------------------------------------------------

  /// DUMMIES

// ----------------------------------------
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

// ----------------------------------------
  void blogContact({
    String methodName = 'ContactModel',
  }){
    blog('$methodName : $contactType : $value');
  }
// -----------------------------------------------------------------------------
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

// ----------------------------------------
  static bool checkContactIsEmpty(ContactModel contact){
    bool _isEmpty = true;

    if (contact != null){

      if (contact.contactType != null){

        if (stringIsEmpty(contact.value) == false){
          _isEmpty = false;
        }

      }

    }

    return _isEmpty;
  }
// ----------------------------------------
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
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
