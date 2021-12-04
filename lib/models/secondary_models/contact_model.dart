import 'package:bldrs/controllers/drafters/iconizers.dart' as Iconizer;
import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class ContactModel{
  final String contact;
  final ContactType contactType;

  const ContactModel({
    @required this.contact,
    @required this.contactType,
  });
// -----------------------------------------------------------------------------
  Map<String, Object> toMap(){
    return <String, Object>{
      'contact' : contact,
      'contactType' : cipherContactType(contactType),
    };
  }
// -----------------------------------------------------------------------------
  static Map<String, Object> cipherContacts(List<ContactModel> contacts){
    Map<String, Object> _map = <String, Object>{};

    if (Mapper.canLoopList(contacts)){

      for (ContactModel contact in contacts){

        if (contact.contact != null && contact.contact != ''){

          _map = Mapper.insertPairInMap(
            map: _map,
            key: cipherContactType(contact.contactType),
            value: contact.contact,
          );

        }

      }

    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static List<ContactModel> decipherContacts(Map<String, dynamic> maps){
    final List<ContactModel> _contacts = <ContactModel>[];

    if (maps != null){

      final List<String> _keys = maps.keys.toList();

      if (Mapper.canLoopList(_keys)){

        for (String key in _keys){

          final ContactModel _contact = ContactModel(contact: maps[key], contactType: decipherContactType(key));
          _contacts.add(_contact);

        }

      }

    }

    return _contacts;
  }
// -----------------------------------------------------------------------------
  static ContactType decipherContactType (String contactType){
    switch (contactType){
      case 'phone'      :   return  ContactType.phone;      break;
      case 'email'      :   return  ContactType.email;      break;
      case 'website'    :   return  ContactType.website;    break;
      case 'facebook'   :   return  ContactType.facebook;   break;
      case 'linkedIn'   :   return  ContactType.linkedIn;   break;
      case 'youtube'    :   return  ContactType.youtube;    break;
      case 'instagram'  :   return  ContactType.instagram;  break;
      case 'pinterest'  :   return  ContactType.pinterest;  break;
      case 'tiktok'     :   return  ContactType.tiktok;     break;
      case 'twitter'    :   return  ContactType.twitter;    break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherContactType (ContactType contactType){
    switch (contactType){
      case ContactType.phone      :    return  'phone';       break;
      case ContactType.email      :    return  'email';       break;
      case ContactType.website    :    return  'website';     break;
      case ContactType.facebook   :    return  'facebook';    break;
      case ContactType.linkedIn   :    return  'linkedIn';    break;
      case ContactType.youtube    :    return  'youtube';     break;
      case ContactType.instagram  :    return  'instagram';   break;
      case ContactType.pinterest  :    return  'pinterest';   break;
      case ContactType.tiktok     :    return  'tiktok';      break;
      case ContactType.twitter    :    return  'twitter';     break;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------
  static ContactModel getAContactModelFromContacts(List<ContactModel> contacts, ContactType contactType){
    final ContactModel contactValue = contacts?.singleWhere((ContactModel x) => x.contactType == contactType,
        orElse: ()=>null);
    return contactValue;
  }
// -----------------------------------------------------------------------------
  static String getAContactValueFromContacts(List<ContactModel> contacts, ContactType contactType){
    final String contactValue = getAContactModelFromContacts(contacts, contactType)?.contact;
    return contactValue;
  }
// -----------------------------------------------------------------------------
  /// contacts with strings
  /// are Phone, Email, WhatsApp, website
  /// which are presented by both string of value and an icon
  static List<ContactModel> getContactsWithStringsFromContacts(List<ContactModel> contacts){
    final List<ContactModel> _contactsList = <ContactModel>[];

    final ContactModel _phone = getAContactModelFromContacts(contacts, ContactType.phone);
    final ContactModel _email = getAContactModelFromContacts(contacts, ContactType.email);
    final ContactModel _website = getAContactModelFromContacts(contacts, ContactType.website);

    if(_phone   != null || _phone?.contact?.isNotEmpty  == true){
      _contactsList.add(_phone);
    }

    if(_email   != null || _email?.contact?.isNotEmpty  == true){
      _contactsList.add(_email);
    }

    if(_website != null || _website?.contact?.isNotEmpty  == true){
      _contactsList.add(_website);
    }

    return _contactsList;
  }
// -----------------------------------------------------------------------------
  /// contacts without strings
  /// are Facebook LinkedIn YouTube Instagram Pinterest TikTok Twitter
  static List<ContactModel> getSocialMediaContactsFromContacts(List<ContactModel> contacts){
    final List<ContactModel> _contactsList = <ContactModel>[];

    final ContactModel _facebook = getAContactModelFromContacts(contacts, ContactType.facebook);
    final ContactModel _linkedin = getAContactModelFromContacts(contacts, ContactType.linkedIn);
    final ContactModel _youtube = getAContactModelFromContacts(contacts, ContactType.youtube);
    final ContactModel _instagram = getAContactModelFromContacts(contacts, ContactType.instagram);
    final ContactModel _pinterest = getAContactModelFromContacts(contacts, ContactType.pinterest);
    final ContactModel _tiktok = getAContactModelFromContacts(contacts, ContactType.tiktok);
    final ContactModel _twitter = getAContactModelFromContacts(contacts, ContactType.twitter);

    if(_facebook  != null && _facebook?.contact?.isNotEmpty  == true ){
      _contactsList.add(_facebook);
    }

    if(_linkedin  != null && _linkedin?.contact?.isNotEmpty  == true ){
      _contactsList.add(_linkedin);
    }

    if(_youtube   != null && _youtube?.contact?.isNotEmpty   == true ){
      _contactsList.add(_youtube);
    }

    if(_instagram != null && _instagram?.contact?.isNotEmpty == true ){
      _contactsList.add(_instagram);
    }

    if(_pinterest != null && _pinterest?.contact?.isNotEmpty == true ){
      _contactsList.add(_pinterest);
    }

    if(_tiktok    != null && _tiktok?.contact?.isNotEmpty    == true ){
      _contactsList.add(_tiktok);
    }

    if(_twitter   != null && _twitter?.contact?.isNotEmpty   == true ){
      _contactsList.add(_twitter);
    }

    return _contactsList;
  }
// -----------------------------------------------------------------------------
  /// will let user to only have one phone contact
  static String getFirstPhoneFromContacts(List<ContactModel> contacts){
    // String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
    final List<String> phones = <String>[];
    contacts?.forEach((ContactModel co) {

      if(co.contactType == ContactType.phone){
        phones.add(co.contact);
      }

    });
    return phones.length == 0 ? null : phones[0];
  }
// -----------------------------------------------------------------------------
  static void addContactIfPossibleToANewContactsList(
      List<ContactModel> existingContacts,
      String value,
      ContactType type,
      List<ContactModel> newContacts,
      ){

    final String _existingContactValue = getAContactValueFromContacts(existingContacts, type);

    bool _contactExistsInExistingContacts;
    if (_existingContactValue == null || _existingContactValue == ''){
      _contactExistsInExistingContacts = false;
    }
    else {
      _contactExistsInExistingContacts = true;
    }

    bool _userChangedValue;
    if (value == null){
      _userChangedValue = false;
    }
    else {
      _userChangedValue = true;
    }

    /// when contact already exists in existingContacts
    if (_contactExistsInExistingContacts == true){

      /// if value have changed add this new value otherwise add the existing value
      if (_userChangedValue == true){
        newContacts.add(ContactModel(contact: value, contactType: type));
      }

      else {
        newContacts.add(ContactModel(contact: _existingContactValue, contactType: type));
      }

    }

    /// when contact is new to existingContacts
    else {

      /// add new ContactModel to the new list only if a new value is assigned ( value != null )
      if (_userChangedValue == true){
        newContacts.add(ContactModel(contact: value, contactType: type));
      }

    }
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfValuesFromContactsModelsList(List<ContactModel> contacts){
    final List<String> values = <String>[];
    contacts.forEach((ContactModel co) {values.add(co.contact); });
    return values;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts){
    final List<String> icons = <String>[];
    contacts.forEach((ContactModel co) {icons.add(Iconizer.superContactIcon(co.contactType));});
    return icons;
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static const List<ContactType> contactTypesList = const <ContactType>[
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
  static List<ContactModel> createContactsList ({
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
  }){
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
  static List<ContactModel> getContactsFromFirebaseUser(User user){
    final List<ContactModel> _userContacts = <ContactModel>[];
    final String _userEmail = user.email;
    final String _userPhone = user.phoneNumber;

    if (_userEmail != null){
      _userContacts.add(
          ContactModel(contact: _userEmail, contactType: ContactType.email)
      );
    }

    if (_userPhone != null){
      _userContacts.add(
          ContactModel(contact: _userPhone, contactType: ContactType.phone)
      );
    }

    return _userContacts;
  }
// -----------------------------------------------------------------------------

}
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

/*

OLD SHIT TO DELETE WHEN TAMAM

// -----------------------------------------------------------------------------
  static ContactModel oldDecipherContactMap(Map<String,dynamic> map){
    return ContactModel(
      contact: map['contact'],
      contactType: oldDecipherContactType(map['contactType']),
    );
  }
// -----------------------------------------------------------------------------
  static List<ContactModel> oldDecipherContactsMaps(List<dynamic> maps){
    final List<ContactModel> contacts = <ContactModel>[];
    maps?.forEach((map) {
      contacts.add(oldDecipherContactMap(map));
    });
    // print('contacts are $contacts');
    return contacts;
  }
// -----------------------------------------------------------------------------
  static ContactType oldDecipherContactType (int contactType){
    switch (contactType){
      case 1:   return  ContactType.phone;      break;
      case 2:   return  ContactType.email;      break;
      case 3:   return  ContactType.website;    break;
      case 4:   return  ContactType.facebook;   break;
      case 5:   return  ContactType.linkedIn;   break;
      case 6:   return  ContactType.youtube;    break;
      case 7:   return  ContactType.instagram;  break;
      case 8:   return  ContactType.pinterest;  break;
      case 9:   return  ContactType.tiktok;     break;
      case 10:  return  ContactType.twitter;    break;
      default : return   null;
    }
  }
 */