import 'package:bldrs/models/contact_model.dart';
import 'package:bldrs/models/enums/enum_contact_type.dart';
import 'package:bldrs/models/flyer_link_model.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/views/widgets/pro_flyer/flyer_screen.dart';
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
void openFlyerOldWay(BuildContext context, String flyerID){
  Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 750),
        pageBuilder: (_,__,___){
          return Hero(
            tag: flyerID, // galleryCoFlyers[index].flyer.flyerID,
            child: Material(
              type: MaterialType.transparency,
              child: new FlyerScreen(
                flyerID: flyerID, // galleryCoFlyers[index].flyer.flyerID,
              ),
            ),
          );
        },
      )
  );
}
// ----------------------------------------------------------------------------
void openFlyer(BuildContext context, String flyerID){
  Navigator.of(context).pushNamed(
    Routez.FlyerScreen,
    arguments: flyerID,
  );
}
// ----------------------------------------------------------------------------
String feinPhoneFromContacts(List<ContactModel> contacts){
  String phone = contacts?.singleWhere((co) => co.contactType == ContactType.Phone, orElse: ()=> null)?.contact;
return phone;
}
// ----------------------------------------------------------------------------

