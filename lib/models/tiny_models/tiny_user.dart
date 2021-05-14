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
  final String email;
  final String phone;

  TinyUser({
    @required this.userID,
    @required this.name,
    @required this.title,
    @required this.pic,
    @required this.userStatus,
    @required this.email,
    @required this.phone,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'name' : name,
      'title' : title,
      'pic' : pic,
      'userStatus' : UserModel.cipherUserStatus(userStatus),
      'email' : email,
      'phone' : phone,
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
      email: email,
      phone: phone,
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
        email: map['email'],
        phone: map['phone'],
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
        email: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Email),
        phone: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
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
      email: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Email),
      phone: ContactModel.getAContactValueFromContacts(author.authorContacts, ContactType.Phone),
    );
  }
// -----------------------------------------------------------------------------
  static TinyUser getTinyAuthorFromBzModel({BzModel bzModel, String authorID}){
    AuthorModel _author = bzModel.bzAuthors.singleWhere((au) => au.userID == authorID, orElse: ()=> null);
    TinyUser _tinyAuthor = getTinyAuthorFromAuthorModel(_author);
    return _tinyAuthor;
  }
// -----------------------------------------------------------------------------
  static bool tinyUsersAreTheSame({UserModel finalUserModel, UserModel originalUserModel}){
    bool _tinyUsersAreTheSame;

    if (originalUserModel.name == finalUserModel.name
        &&
        originalUserModel.title == finalUserModel.title
        &&
        originalUserModel.pic == finalUserModel.pic
        &&
        originalUserModel.userStatus == finalUserModel.userStatus
    ){

      _tinyUsersAreTheSame = true;

    } else {

      _tinyUsersAreTheSame = false;

    }

    return _tinyUsersAreTheSame;
  }
// -----------------------------------------------------------------------------
}
