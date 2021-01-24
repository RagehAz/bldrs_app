import 'package:bldrs/models/enums/enum_contact_type.dart';
import 'package:flutter/foundation.dart';

enum ContactOwnerType {
  user,
  bz,
}

class ContactModel{
  final String contactID;
  final String ownerID;
  final String contact;
  final ContactOwnerType ownerType;
  final ContactType contactType;

  ContactModel({
    @required this.contactID,
    @required this.ownerID,
    @required this.contact,
    @required this.ownerType,
    @required this.contactType,
  });
}