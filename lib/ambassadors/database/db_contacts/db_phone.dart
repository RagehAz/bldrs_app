import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/enums/enum_contact_type.dart';

final List<ContactModel> dbPhones = <ContactModel>[
  ContactModel(contactID: 'c005', contactType: ContactType.Phone, ownerID: 'pp1', contact: 'bz phone here bitch', ownerType: ContactOwnerType.bz),
  ContactModel(contactID: 'c010', contactType: ContactType.Phone, ownerID: 'u01', contact: 'user phone here bitch', ownerType: ContactOwnerType.user),
  ContactModel(contactID: 'c999', contactType: ContactType.Phone, ownerID: 'br1', contact: '999999999', ownerType: ContactOwnerType.bz),
];