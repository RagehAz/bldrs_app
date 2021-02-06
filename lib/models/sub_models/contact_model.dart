import 'package:flutter/foundation.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
class ContactModel{
  final String contactID; // can delete later
  final String ownerID; // can delete later
  final String contact;
  final ContactType contactType;
// ###############################
  ContactModel({
    this.contactID,
    this.ownerID,
    @required this.contact,
    @required this.contactType,
  });
// ###############################
  Map<String,Object> toMap(){
    return {
      'contactID' : contactID,
      'ownerID' : ownerID,
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

List<ContactModel> decipherContactsMaps(List<Map<String,dynamic>> maps){
  List<ContactModel> contacts = new List();
  maps?.forEach((map) {
    contacts.add(decipherContactMap(map));
  });
  return contacts;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum ContactType {
  Email,
  Facebook,
  Instagram,
  LinkedIn,
  Phone,
  Pinterest,
  TikTok,
  Twitter,
  WebSite,
  YouTube,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
ContactType decipherContactType (int contactType){
  switch (contactType){
    case 1:   return  ContactType.Email;      break;
    case 2:   return  ContactType.Facebook;   break;
    case 3:   return  ContactType.Instagram;  break;
    case 4:   return  ContactType.LinkedIn;   break;
    case 5:   return  ContactType.Phone;      break;
    case 6:   return  ContactType.Pinterest;  break;
    case 7:   return  ContactType.TikTok;     break;
    case 8:   return  ContactType.Twitter;    break;
    case 9:   return  ContactType.WebSite;    break;
    case 10:  return  ContactType.YouTube;    break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherContactType (ContactType contactType){
  switch (contactType){
    case ContactType.Email      :    return  1;  break;
    case ContactType.Facebook   :    return  2;  break;
    case ContactType.Instagram  :    return  3;  break;
    case ContactType.LinkedIn   :    return  4;  break;
    case ContactType.Phone      :    return  5;  break;
    case ContactType.Pinterest  :    return  6;  break;
    case ContactType.TikTok     :    return  7;  break;
    case ContactType.Twitter    :    return  8;  break;
    case ContactType.WebSite    :    return  9;  break;
    case ContactType.YouTube    :    return  10; break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<ContactType> contactTypesList = [
  ContactType.Email,
  ContactType.Facebook,
  ContactType.Instagram,
  ContactType.LinkedIn,
  ContactType.Phone,
  ContactType.Pinterest,
  ContactType.TikTok,
  ContactType.Twitter,
  ContactType.WebSite,
  ContactType.YouTube,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x