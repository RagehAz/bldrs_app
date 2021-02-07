import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
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
AuthorModel getAuthorFromBzByAuthorID(BzModel bz, String authorID){
  AuthorModel author = bz?.authors?.singleWhere((au) => au.userID == authorID, orElse: ()=>null);
  return author;
}
// ----------------------------------------------------------------------------
/// temp
AuthorModel getAuthorModelFromUserModelAndBzModel(UserModel user, BzModel bz){
  String authorID = user?.userID;
  AuthorModel authorFromBz = getAuthorFromBzByAuthorID(bz, authorID);
  AuthorModel author = AuthorModel(
    userID: user?.userID,
    bzID: bz?.bzID,
    authorName: user?.name,
    authorPic: user?.pic,
    authorTitle: user?.title,
    authorContacts: user?.contacts,
    publishedFlyersIDs: authorFromBz?.publishedFlyersIDs,
  );
  return author;
}
