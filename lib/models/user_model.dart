import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
/// any changes in this model should reflect on this [UserProvider]
class UserModel {
  final String userID;
  final DateTime joinedAt;
  final UserStatus userStatus;
  // -------------------------
  final String name;
  final String pic;
  final String title;
  final String company;
  final Gender gender; // should be both gender and name tittle Mr, Mrs, Ms, Dr, Eng, Arch, ...
  final String country;
  final String province;
  final String area;
  final String language;
  final GeoPoint position;
  final List<ContactModel> contacts;
  // -------------------------
  List<dynamic> savedFlyersIDs;
  List<dynamic> followedBzzIDs;
// ###############################
  UserModel({
    this.userID,
    this.joinedAt,
    this.userStatus,
    // -------------------------
    this.name,
    this.pic,
    this.title,
    this.company,
    this.gender,
    this.country,
    this.province,
    this.area,
    this.language,
    this.position,
    this.contacts,
    // -------------------------
    this.savedFlyersIDs,
    this.followedBzzIDs,
  });
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum UserStatus {
  Normal,
  SearchingThinking,
  Finishing,
  PlanningTalking,
  Building,
  Selling,
  BzAuthor,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<UserStatus> userTypesList = [
  UserStatus.Normal,
  UserStatus.SearchingThinking,
  UserStatus.Finishing,
  UserStatus.PlanningTalking,
  UserStatus.Building,
  UserStatus.Selling,
  UserStatus.BzAuthor,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
UserStatus decipherUserStatus (int userStatus){
  switch (userStatus){
    case 1:   return   UserStatus.Normal;                 break;
    case 2:   return   UserStatus.SearchingThinking;      break;
    case 3:   return   UserStatus.Finishing;              break;
    case 4:   return   UserStatus.PlanningTalking;        break;
    case 5:   return   UserStatus.Building;               break;
    case 6:   return   UserStatus.Selling;                break;
    case 7:   return   UserStatus.BzAuthor;               break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherUserStatus (UserStatus userStatus){
  switch (userStatus){
    case UserStatus.Normal              :  return 1; break ;
    case UserStatus.SearchingThinking   :  return 2; break ;
    case UserStatus.Finishing           :  return 3; break ;
    case UserStatus.PlanningTalking     :  return 4; break ;
    case UserStatus.Building            :  return 5; break ;
    case UserStatus.Selling             :  return 6; break ;
    case UserStatus.BzAuthor            :  return 7; break ;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum Gender {
  male,
  female,
  any,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
Gender decipherGender (int gender){
  switch (gender){
    case 0:   return   Gender.female; break;
    case 1:   return   Gender.male; break;
    case 2:   return   Gender.any; break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherGender(Gender gender){
  switch (gender){
    case Gender.female : return 0; break ;
    case Gender.male : return 1; break ;
    case Gender.any : return 2; break ;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
bool userIsAuthor(UserStatus userStatus){
  return
      userStatus == UserStatus.BzAuthor ? true : false ;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
String superUserID(){
  String userID = (FirebaseAuth.instance.currentUser).uid;
  return userID;
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
