import 'package:flutter/foundation.dart';
import '../user_model.dart';
// -----------------------------------------------------------------------------
class TinyUser {
  final String userID;
  final String name;
  final String title;
  final dynamic pic;
  final UserStatus userStatus;

  TinyUser({
    @required this.userID,
    @required this.name,
    @required this.title,
    @required this.pic,
    @required this.userStatus,
  });

  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'name' : name,
      'title' : title,
      'pic' : pic,
      'userStatus' : cipherUserStatus(userStatus),
    };
  }
}
// -----------------------------------------------------------------------------
TinyUser decipherTinyUserMap(Map<String, dynamic> map){
  return
    TinyUser(
      userID: map['userID'],
      name: map['name'],
      title: map['title'],
      pic: map['pic'],
      userStatus: decipherUserStatus(map['userStatus']),
    );
}
// -----------------------------------------------------------------------------
TinyUser getTinyUserFromUserModel(UserModel userModel){
  return TinyUser(
    userID: userModel.userID,
    name: userModel.name,
    title: userModel.title,
    pic: userModel.pic,
    userStatus: userModel.userStatus,
  );
}
// -----------------------------------------------------------------------------
