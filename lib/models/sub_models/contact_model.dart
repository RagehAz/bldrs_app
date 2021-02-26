import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:flutter/foundation.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ContactModel{
  final String value;
  final ContactType type;
// ###############################
  ContactModel({
    @required this.value,
    @required this.type,
  });
// ###############################
  Map<String,Object> toMap(){
    return {
      'value' : value,
      'type' : cipherContactType(type),
    };
  }
// ###############################
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<Map<String,Object>> cipherContactsModels(List<ContactModel> contactsList){
  List<Map<String,Object>> listOfMaps = new List();
  contactsList?.forEach((contact) {
    listOfMaps.add(contact.toMap());
  });
  return listOfMaps;
}
// -----------------------------------------------------------------
ContactModel decipherContactMap(Map<String,dynamic> map){
  return ContactModel(
      value: map['contact'],
      type: decipherContactType(map['contactType']),
  );
}
// -----------------------------------------------------------------
List<ContactModel> decipherContactsMaps(List<dynamic> maps){
  List<ContactModel> contacts = new List();
  maps?.forEach((map) {
    contacts.add(decipherContactMap(map));
  });
  // print('contacts are $contacts');
  return contacts;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
ContactType decipherContactType (int contactType){
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherContactType (ContactType contactType){
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<ContactType> contactTypesList = [
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
ContactModel getAContactModelFromContacts(List<ContactModel> contacts, ContactType contactType){
  ContactModel contactValue = contacts.singleWhere((x) => x.type == contactType,
      orElse: ()=>null);
  return contactValue;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
String getAContactValueFromContacts(List<ContactModel> contacts, ContactType contactType){
  String contactValue = getAContactModelFromContacts(contacts, contactType)?.value;
  return contactValue;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
/// contacts with strings
/// are Phone, Email, WhatsApp, website
/// which are presented by both string of value and an icon
List<ContactModel> getContactsWithStringsFromContacts(List<ContactModel> contacts){
  List<ContactModel> _contactsList = new List();

  ContactModel _phone = getAContactModelFromContacts(contacts, ContactType.Phone);
  ContactModel _email = getAContactModelFromContacts(contacts, ContactType.Email);
  ContactModel _website = getAContactModelFromContacts(contacts, ContactType.WebSite);

  if(_phone   != null || _phone?.value?.isNotEmpty  == true){_contactsList.add(_phone);}
  if(_email   != null || _email?.value?.isNotEmpty  == true){_contactsList.add(_email);}
  if(_website != null || _website?.value?.isNotEmpty  == true){_contactsList.add(_website);}

  return _contactsList;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
/// contacts without strings
/// are Facebook LinkedIn YouTube Instagram Pinterest TikTok Twitter
List<ContactModel> getSocialMediaContactsFromContacts(List<ContactModel> contacts){
  List<ContactModel> _contactsList = new List();

  ContactModel _facebook = getAContactModelFromContacts(contacts, ContactType.Facebook);
  ContactModel _linkedin = getAContactModelFromContacts(contacts, ContactType.LinkedIn);
  ContactModel _youtube = getAContactModelFromContacts(contacts, ContactType.YouTube);
  ContactModel _instagram = getAContactModelFromContacts(contacts, ContactType.Instagram);
  ContactModel _pinterest = getAContactModelFromContacts(contacts, ContactType.Pinterest);
  ContactModel _tiktok = getAContactModelFromContacts(contacts, ContactType.TikTok);
  ContactModel _twitter = getAContactModelFromContacts(contacts, ContactType.Twitter);

  if(_facebook  != null && _facebook?.value?.isNotEmpty  == true ){_contactsList.add(_facebook);}else{}
  if(_linkedin  != null && _linkedin?.value?.isNotEmpty  == true ){_contactsList.add(_linkedin);}else{}
  if(_youtube   != null && _youtube?.value?.isNotEmpty   == true ){_contactsList.add(_youtube);}else{}
  if(_instagram != null && _instagram?.value?.isNotEmpty == true ){_contactsList.add(_instagram);}else{}
  if(_pinterest != null && _pinterest?.value?.isNotEmpty == true ){_contactsList.add(_pinterest);}else{}
  if(_tiktok    != null && _tiktok?.value?.isNotEmpty    == true ){_contactsList.add(_tiktok);}else{}
  if(_twitter   != null && _twitter?.value?.isNotEmpty   == true ){_contactsList.add(_twitter);}else{}

  return _contactsList;
}
// ----------------------------------------------------------------------------
/// will let user to only have one phone contact
String getFirstPhoneFromContacts(List<ContactModel> contacts){
  // String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
  List<String> phones = new List();
  contacts?.forEach((co) {
    if(co.type == ContactType.Phone){phones.add(co.value);}
  });
  return phones.length == 0 ? null : phones[0];
}
// ----------------------------------------------------------------------------
List<ContactModel> createContactsList ({
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
  List<ContactModel> _newContacts = new List();
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
// ----------------------------------------------------------------------------
void addContactIfPossibleToANewContactsList(
    List<ContactModel> existingContacts,
    String value,
    ContactType type,
    List<ContactModel> newContacts,
    ){

  String _existingContactValue = getAContactValueFromContacts(existingContacts, type);

  bool _contactExistsInExistingContacts =
  _existingContactValue == null || _existingContactValue == ''? false : true;

  bool _userChangedValue = value == null ? false : true;

  /// when contact already exists in existingContacts
  if (_contactExistsInExistingContacts == true){
    /// if value have changed add this new value otherwise ass the existing value
    if (_userChangedValue == true){
      newContacts.add(ContactModel(value: value, type: type));
    } else { newContacts.add(ContactModel(value: _existingContactValue, type: type)); }
  }
  /// when contact is new to existingContacts
  else {
    /// add new ContactModel to the new list only if a new value is assigned ( value != null )
    if (_userChangedValue == true){
      newContacts.add(ContactModel(value: value, type: type));
    }
  }
}
// ----------------------------------------------------------------------------
List<String> getListOfValuesFromContactsModelsList(List<ContactModel> contacts){
  List<String> values = new List();
  contacts.forEach((co) {values.add(co.value); });
  return values;
}
// ----------------------------------------------------------------------------
List<String> getListOfIconzFromContactsModelsList(List<ContactModel> contacts){
  List<String> icons = new List();
  contacts.forEach((co) {icons.add(superContactIcon(co.type));});
  return icons;
}
// ----------------------------------------------------------------------------
