import 'package:flutter/foundation.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ContactModel{
  final String contact;
  final ContactType contactType;
// ###############################
  ContactModel({
    @required this.contact,
    @required this.contactType,
  });
// ###############################
  Map<String,Object> toMap(){
    return {
      'contact' : contact,
      'contactType' : cipherContactType(contactType),
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

ContactModel decipherContactMap(Map<String,dynamic> map){
  return ContactModel(
      contact: map['contact'],
      contactType: decipherContactType(map['contactType']),
  );
}

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
String getAContactFromContacts(List<ContactModel> contacts, ContactType contactType){
  String contactValue = contacts?.singleWhere((x) => x.contactType == contactType,
      orElse: ()=>null)?.contact;
  return contactValue;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
