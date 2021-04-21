import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// -----------------------------------------------------------------------------
class UserModel {
  final String userID;
  final DateTime joinedAt;
  final UserStatus userStatus;
  // -------------------------
  final String name;
  final dynamic pic;
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
  final List<dynamic> myBzzIDs;
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
    this.myBzzIDs,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'joinedAt' : cipherDateTimeToString(joinedAt),
      'userStatus' : cipherUserStatus(userStatus),
// -------------------------
      'name' : name,
      'pic' : pic,
      'title' : title,
      'company' : company,
      'gender' : cipherGender(gender),
      'country' : country,
      'province' : province,
      'area' : area,
      'language' : language,
      'position' : position,
      'contacts' : ContactModel.cipherContactsModels(contacts),
// -------------------------
      'myBzzIDs' : myBzzIDs,
    };
  }
// -----------------------------------------------------------------------------
  static UserModel decipherUserMap(Map<String, dynamic> map){

    // List<dynamic> _myBzzIDs = map['myBzzIDs'] ?? [];

    return UserModel(
      userID : map['userID'] ?? '',
      joinedAt : decipherDateTimeString(map['joinedAt'] ?? ''),
      userStatus : decipherUserStatus(map['userStatus']?? 1),
      // -------------------------
      name : map['name'] ?? '',
      pic : map['pic'] ?? '',
      title : map['title'] ?? '',
      company : map['company'] ?? '',
      gender : decipherGender(map['gender'] ?? 2),
      country : map['country'] ?? '',
      province : map['province'] ?? '',
      area : map['area'] ?? '',
      language : map['language'] ?? 'en',
      position : map['position'] ?? GeoPoint(0, 0),
      contacts : ContactModel.decipherContactsMaps(map['contacts'] ?? []),
      // -------------------------
      myBzzIDs: map['myBzzIDs'],
    );

  }
// -----------------------------------------------------------------------------
  static UserStatus decipherUserStatus (int userStatus){
    switch (userStatus){
      case 1:   return   UserStatus.Normal;                 break;
      case 2:   return   UserStatus.SearchingThinking;      break;
      case 3:   return   UserStatus.Finishing;              break;
      case 4:   return   UserStatus.PlanningTalking;        break;
      case 5:   return   UserStatus.Building;               break;
      case 6:   return   UserStatus.Selling;                break;
      case 7:   return   UserStatus.BzAuthor;               break;
      case 8:   return   UserStatus.Deactivated;            break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherUserStatus (UserStatus userStatus){
    switch (userStatus){
      case UserStatus.Normal              :  return 1; break ;
      case UserStatus.SearchingThinking   :  return 2; break ;
      case UserStatus.Finishing           :  return 3; break ;
      case UserStatus.PlanningTalking     :  return 4; break ;
      case UserStatus.Building            :  return 5; break ;
      case UserStatus.Selling             :  return 6; break ;
      case UserStatus.BzAuthor            :  return 7; break ;
      case UserStatus.Deactivated         :  return 8; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Gender decipherGender (int gender){
    switch (gender){
      case 0:   return   Gender.female; break;
      case 1:   return   Gender.male; break;
      case 2:   return   Gender.any; break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherGender(Gender gender){
    switch (gender){
      case Gender.female : return 0; break ;
      case Gender.male : return 1; break ;
      case Gender.any : return 2; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static bool userIsAuthor(UserModel userModel){
    bool _userIsAuthor = userModel.myBzzIDs.length > 0 ? true : false;
    return
      _userIsAuthor;
  }
// -----------------------------------------------------------------------------
  static List<UserStatus> userTypesList = <UserStatus>[
    UserStatus.Normal,
    UserStatus.SearchingThinking,
    UserStatus.Finishing,
    UserStatus.PlanningTalking,
    UserStatus.Building,
    UserStatus.Selling,
    UserStatus.BzAuthor,
    UserStatus.Deactivated,
  ];
// -----------------------------------------------------------------------------
  static List<dynamic> removeBzIDFromMyBzzIDs(List<dynamic> myBzzIDs, String bzID){
    int _bzIndex = myBzzIDs.indexWhere((id) => id == bzID,);

    if (_bzIndex != null){
      myBzzIDs.removeAt(_bzIndex);
      return myBzzIDs;
    } else {
      return null;
    }

  }
}
// -----------------------------------------------------------------------------
enum UserStatus {
  Normal,
  SearchingThinking,
  Finishing,
  PlanningTalking,
  Building,
  Selling,
  BzAuthor,
  Deactivated,
}
// -----------------------------------------------------------------------------
enum Gender {
  male,
  female,
  any,
}
// -----------------------------------------------------------------------------
