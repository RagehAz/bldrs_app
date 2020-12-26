import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/enums/enum_contact_type.dart';

final List<ContactModel> dbEmails = [
  ContactModel(contactID: 'c001', contactType: ContactType.Email, ownerID: 'pp1', contact: 'businessEmail@hotmail.com', ownerType: ContactOwnerType.bz),
  ContactModel(contactID: 'c00r', contactType: ContactType.Email, ownerID: 'u21', contact: 'fuckyou@hotmail.com', ownerType: ContactOwnerType.user),
];