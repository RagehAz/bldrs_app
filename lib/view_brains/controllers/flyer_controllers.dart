import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
// ----------------------------------------------------------------------------
void shareFlyer (BuildContext context, FlyerLink flyerLink) {
  final RenderBox box = context.findRenderObject();
  final String text = '${flyerLink.flyerLink} & ${flyerLink.description}';

  Share.share(
    text,
    subject: flyerLink.description,
    sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
  );
}
// ----------------------------------------------------------------------------
String feinPhoneFromContacts(List<ContactModel> contacts){
  String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
return phone;
}
// ----------------------------------------------------------------------------

