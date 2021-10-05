import 'package:bldrs/controllers/drafters/iconizers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
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
  Map<String,Object> toMap(){
    return {
      'contact' : contact,
      'contactType' : cipherContactType(contactType),
    };
  }
// -----------------------------------------------------------------------------
  static List<Map<String, Object>> cipherContactsModels(List<ContactModel> contactsList){
    final List<Map<String, Object>> listOfMaps = <Map<String,Object>>[];
    contactsList?.forEach((contact) {
      listOfMaps.add(contact.toMap());
    });
    return listOfMaps;
  }
// -----------------------------------------------------------------------------
  static ContactModel decipherContactMap(Map<String,dynamic> map){
    return ContactModel(
      contact: map['contact'],
      contactType: decipherContactType(map['contactType']),
    );
  }
// -----------------------------------------------------------------
  static List<ContactModel> decipherContactsMaps(List<dynamic> maps){
    final List<ContactModel> contacts = <ContactModel>[];
    maps?.forEach((map) {
      contacts.add(decipherContactMap(map));
    });
    // print('contacts are $contacts');
    return contacts;
  }
// -----------------------------------------------------------------------------
  static ContactType decipherContactType (int contactType){
    switch (contactType){
      case 1:   return  ContactType.Phone;      break;
      case 2:   return  ContactType.Email;      break;
      case 3:   return  ContactType.WebSite;    break;
      case 4:   return  ContactType.Facebook;   break;
      case 5:   return  ContactType.LinkedIn;   break;
      case 6:   return  ContactType.YouTube;    break;
      case 7:   return  ContactType.Instagram;  break;
      case 8:   return  ContactType.Pinterest;  break;
      case 9:   return  ContactType.TikTok;     break;
      case 10:  return  ContactType.Twitter;    break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherContactType (ContactType contactType){
    switch (contactType){
      case ContactType.Phone      :    return  1;  break;
      case ContactType.Email      :    return  2;  break;
      case ContactType.WebSite    :    return  3;  break;
      case ContactType.Facebook   :    return  4;  break;
      case ContactType.LinkedIn   :    return  5;  break;
      case ContactType.YouTube    :    return  6;  break;
      case ContactType.Instagram  :    return  7;  break;
      case ContactType.Pinterest  :    return  8;  break;
      case ContactType.TikTok     :    return  9;  break;
      case ContactType.Twitter    :    return  10; break;
      default : return null;
    }
  }
  // -----------------------------------------------------------------------------
  static ContactModel getAContactModelFromContacts(List<ContactModel> contacts, ContactType contactType){
    final ContactModel contactValue = contacts?.singleWhere((x) => x.contactType == contactType,
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

    final ContactModel _phone = getAContactModelFromContacts(contacts, ContactType.Phone);
    final ContactModel _email = getAContactModelFromContacts(contacts, ContactType.Email);
    final ContactModel _website = getAContactModelFromContacts(contacts, ContactType.WebSite);

    if(_phone   != null || _phone?.contact?.isNotEmpty  == true){_contactsList.add(_phone);}
    if(_email   != null || _email?.contact?.isNotEmpty  == true){_contactsList.add(_email);}
    if(_website != null || _website?.contact?.isNotEmpty  == true){_contactsList.add(_website);}

    return _contactsList;
  }
// -----------------------------------------------------------------------------
  /// contacts without strings
  /// are Facebook LinkedIn YouTube Instagram Pinterest TikTok Twitter
  static List<ContactModel> getSocialMediaContactsFromContacts(List<ContactModel> contacts){
    final List<ContactModel> _contactsList = <ContactModel>[];

    final ContactModel _facebook = getAContactModelFromContacts(contacts, ContactType.Facebook);
    final ContactModel _linkedin = getAContactModelFromContacts(contacts, ContactType.LinkedIn);
    final ContactModel _youtube = getAContactModelFromContacts(contacts, ContactType.YouTube);
    final ContactModel _instagram = getAContactModelFromContacts(contacts, ContactType.Instagram);
    final ContactModel _pinterest = getAContactModelFromContacts(contacts, ContactType.Pinterest);
    final ContactModel _tiktok = getAContactModelFromContacts(contacts, ContactType.TikTok);
    final ContactModel _twitter = getAContactModelFromContacts(contacts, ContactType.Twitter);

    if(_facebook  != null && _facebook?.contact?.isNotEmpty  == true ){_contactsList.add(_facebook);}else{}
    if(_linkedin  != null && _linkedin?.contact?.isNotEmpty  == true ){_contactsList.add(_linkedin);}else{}
    if(_youtube   != null && _youtube?.contact?.isNotEmpty   == true ){_contactsList.add(_youtube);}else{}
    if(_instagram != null && _instagram?.contact?.isNotEmpty == true ){_contactsList.add(_instagram);}else{}
    if(_pinterest != null && _pinterest?.contact?.isNotEmpty == true ){_contactsList.add(_pinterest);}else{}
    if(_tiktok    != null && _tiktok?.contact?.isNotEmpty    == true ){_contactsList.add(_tiktok);}else{}
    if(_twitter   != null && _twitter?.contact?.isNotEmpty   == true ){_contactsList.add(_twitter);}else{}

    return _contactsList;
  }
// -----------------------------------------------------------------------------
  /// will let user to only have one phone contact
  static String getFirstPhoneFromContacts(List<ContactModel> contacts){
    // String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
    final List<String> phones = <String>[];
    contacts?.forEach((co) {
      if(co.contactType == ContactType.Phone){phones.add(co.contact);}
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

    final bool _contactExistsInExistingContacts =
    _existingContactValue == null || _existingContactValue == ''? false : true;

    final bool _userChangedValue = value == null ? false : true;

    /// when contact already exists in existingContacts
    if (_contactExistsInExistingContacts == true){
      /// if value have changed add this new value otherwise add the existing value
      if (_userChangedValue == true){
        newContacts.add(ContactModel(contact: value, contactType: type));
      } else { newContacts.add(ContactModel(contact: _existingContactValue, contactType: type)); }
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
    contacts.forEach((co) {values.add(co.contact); });
    return values;
  }
// -----------------------------------------------------------------------------
  static List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts){
    final List<String> icons = <String>[];
    contacts.forEach((co) {icons.add(Iconizer.superContactIcon(co.contactType));});
    return icons;
  }
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
  static const List<ContactType> contactTypesList = const <ContactType>[
    ContactType.Phone,
    ContactType.Email,
    ContactType.WebSite,
    ContactType.Facebook,
    ContactType.LinkedIn,
    ContactType.YouTube,
    ContactType.Instagram,
    ContactType.Pinterest,
    ContactType.TikTok,
    ContactType.Twitter,
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
    addContactIfPossibleToANewContactsList(existingContacts, phone, ContactType.Phone, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, email, ContactType.Email, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, webSite, ContactType.WebSite, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, facebook, ContactType.Facebook, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, linkedIn, ContactType.LinkedIn, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, youTube, ContactType.YouTube, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, instagram, ContactType.Instagram, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, pinterest, ContactType.Pinterest, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, tikTok, ContactType.TikTok, _newContacts);
    addContactIfPossibleToANewContactsList(existingContacts, twitter, ContactType.Twitter, _newContacts);
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
          ContactModel(contact: _userEmail, contactType: ContactType.Email)
      );
    }

    if (_userPhone != null){
      _userContacts.add(
          ContactModel(contact: _userPhone, contactType: ContactType.Phone)
      );
    }

    return _userContacts;
  }
// -----------------------------------------------------------------------------
  static String _sqlCipherContact({ContactModel contact}){
    final String _string = '${cipherContactType(contact.contactType)}#${contact.contact}';
    return _string;
  }
// -----------------------------------------------------------------------------
  static String sqlCipherContacts(List<ContactModel> contacts){
    final List<String> _strings = <String>[];

    for (ContactModel contact in contacts){
      _strings.add(_sqlCipherContact(contact: contact));
    }

    final String _sqlString = TextMod.sqlCipherStrings(_strings);

    return _sqlString;
  }
// -----------------------------------------------------------------------------
  static ContactModel _sqlDecipherContact({String sqlString}){
    final String _contactTypeString = TextMod.trimTextAfterFirstSpecialCharacter(sqlString, '#');
    final int _contactTypeInt = Numeric.stringToInt(_contactTypeString);
    final ContactType _contactType = decipherContactType(_contactTypeInt);

    final String _contactString = TextMod.trimTextBeforeFirstSpecialCharacter(sqlString, '#');

    final ContactModel _contact = ContactModel(
      contact: _contactString,
      contactType: _contactType,
    );

    return _contact;
  }
// -----------------------------------------------------------------------------
  static List<ContactModel> sqlDecipherContacts(String sqlContactsStrings){
    final List<ContactModel> _contacts = <ContactModel>[];

    if (sqlContactsStrings != null){

      List<String> _sqlContactsStrings = TextMod.sqlDecipherStrings(sqlContactsStrings);

      if (_sqlContactsStrings != null && _sqlContactsStrings.isNotEmpty){

        for (String sqlString in _sqlContactsStrings){

          final ContactModel _contact = _sqlDecipherContact(sqlString: sqlString);
          _contacts.add(_contact);

        }

      }

    }

    return _contacts;
  }
// -----------------------------------------------------------------------------

}
// -----------------------------------------------------------------------------
enum ContactType {
  Phone,
  Email,
  WebSite,
  Facebook,
  LinkedIn,
  YouTube,
  Instagram,
  Pinterest,
  TikTok,
  Twitter,
}
