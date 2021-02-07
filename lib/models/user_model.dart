import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
/// any changes in this model should reflect on this [DatabaseService]
class UserModel {
  final String userID;
  final DateTime joinedAt;
  final UserStatus userStatus;
  // -------------------------
  final String name;
  final String pic;
  final String title;
  final Gender gender;
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
  NormalUser,
  SearchingUser,
  ConstructingUser,
  PlanningUser,
  BuildingUser,
  SellingUser,
  BzAuthor,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<UserStatus> userTypesList = [
  UserStatus.NormalUser,
  UserStatus.SearchingUser,
  UserStatus.ConstructingUser,
  UserStatus.PlanningUser,
  UserStatus.BuildingUser,
  UserStatus.SellingUser,
  UserStatus.BzAuthor,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
UserStatus decipherUserStatus (int userStatus){
  switch (userStatus){
    case 1:   return   UserStatus.NormalUser;         break;
    case 2:   return   UserStatus.SearchingUser;      break;
    case 3:   return   UserStatus.ConstructingUser;   break;
    case 4:   return   UserStatus.PlanningUser;       break;
    case 5:   return   UserStatus.BuildingUser;       break;
    case 6:   return   UserStatus.SellingUser;        break;
    case 7:   return   UserStatus.BzAuthor;           break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherUserStatus (UserStatus userStatus){
  switch (userStatus){
    case UserStatus.NormalUser       :  return 1; break ;
    case UserStatus.SearchingUser    :  return 2; break ;
    case UserStatus.ConstructingUser :  return 3; break ;
    case UserStatus.PlanningUser     :  return 4; break ;
    case UserStatus.BuildingUser     :  return 5; break ;
    case UserStatus.SellingUser      :  return 6; break ;
    case UserStatus.BzAuthor         :  return 7; break ;
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
