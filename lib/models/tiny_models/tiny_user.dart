import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:flutter/foundation.dart';
import '../user_model.dart';
// -----------------------------------------------------------------------------
class TinyUser {
  final String userID;
  final String name;
  final String title;
  final dynamic pic;
  final UserStatus userStatus;
  final String contact;

  TinyUser({
    @required this.userID,
    @required this.name,
    @required this.title,
    @required this.pic,
    @required this.userStatus,
    @required this.contact,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'name' : name,
      'title' : title,
      'pic' : pic,
      'userStatus' : UserModel.cipherUserStatus(userStatus),
      'contact' : contact,
    };
  }
// -----------------------------------------------------------------------------
  TinyUser clone(){
    return TinyUser(
        userID: userID,
        name: name,
        title: title,
        pic: pic,
        userStatus: userStatus,
        contact: contact,
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser decipherTinyUserMap(Map<String, dynamic> map){
    return
      TinyUser(
        userID: map['userID'],
        name: map['name'],
        title: map['title'],
        pic: map['pic'],
        userStatus: UserModel.decipherUserStatus(map['userStatus']),
        contact: map['contact'],
      );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyUserFromUserModel(UserModel userModel){
    return TinyUser(
        userID: userModel.userID,

        name: userModel.name,
        title: userModel.title,
        pic: userModel.pic,
        userStatus: userModel.userStatus,
        contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Phone) ?? ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Email)
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromAuthorModel(AuthorModel author){
    return TinyUser(
      userID: author.userID,
      name: author.authorName,
      title: author.authorTitle,
      pic: author.authorPic,
      userStatus: UserStatus.BzAuthor,
      contact: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Phone),
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromBzModel({BzModel bzModel, String authorID}){
    AuthorModel _author = bzModel.bzAuthors.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    TinyUser _tinyAuthor = getTinyAuthorFromAuthorModel(_author);
    return _tinyAuthor;
  }
// -----------------------------------------------------------------------------
}
