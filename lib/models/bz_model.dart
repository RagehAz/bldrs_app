import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sub_models/author_model.dart';
import 'sub_models/contact_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'user_model.dart';
// -----------------------------------------------------------------------------
/// Bz account has limited amount of available slides, with each published slide,
/// credit decreases,
/// slides can be purchased or rewarded
/// int credit; <------
/// List<Map<String,Object>> bzProgressMaps = [
///   {'challenge' : 'completeAccount',     'progress' : 100 , 'claimed' : true},
///   {'challenge' : 'verifyAccount',       'progress' : 0   , 'claimed' : false},
///   {'challenge' : 'publish 10 flyers',   'progress' : 90  , 'claimed' : false},
///   {'challenge' : 'publish 100 flyers',  'progress' : 9   , 'claimed' : false},
/// ];
/// List<Map<String,Object>> progress; <------
class BzModel with ChangeNotifier{
  final String bzID;
  // -------------------------
  final BzType bzType;
  final BzForm bzForm;
  final DateTime bldrBirth;
  final BzAccountType accountType;
  final String bzURL;
  // -------------------------
  final String bzName;
  final dynamic bzLogo;
  final String bzScope;
  final String bzCountry; // countryID
  final String bzProvince;
  final String bzArea;// cityID
  final String bzAbout;
  final GeoPoint bzPosition;
  final List<ContactModel> bzContacts;
  final List<AuthorModel> bzAuthors;
  final bool bzShowsTeam;
  // -------------------------
  final bool bzIsVerified;
  final bool bzAccountIsDeactivated;
  final bool bzAccountIsBanned; // should use the word suspended instead
  // -------------------------
  int bzTotalFollowers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;
  // -------------------------
  final List<TinyFlyer> bzFlyers;
// ###############################
  BzModel({
    this.bzID,
    // -------------------------
    this.bzType,
    this.bzForm,
    this.bldrBirth,
    this.accountType,
    this.bzURL,
    // -------------------------
    this.bzName,
    this.bzLogo,
    this.bzScope,
    this.bzCountry,
    this.bzProvince,
    this.bzArea,
    this.bzAbout,
    this.bzPosition,
    this.bzContacts,
    this.bzAuthors,
    this.bzShowsTeam,
    // -------------------------
    this.bzIsVerified,
    this.bzAccountIsDeactivated,
    this.bzAccountIsBanned,
    // -------------------------
    this.bzTotalFollowers,
    this.bzTotalSaves,
    this.bzTotalShares,
    this.bzTotalSlides,
    this.bzTotalViews,
    this.bzTotalCalls,
    // -------------------------
    this.bzFlyers,
  });
// ###############################
  // TASK : this technique to revert back the status if firestore operation fails needs to be adapted elsewhere
//   void _setFollowValue(bool newValue){
//     followIsOn = newValue;
//     notifyListeners();
//   }

  // Future<void> toggleFollow() async {
  //   final oldStatus = followIsOn;
  //   print('oldStatus is : $oldStatus');
  //   _setFollowValue(!followIsOn);
  //   print('new followIsOn is : $followIsOn');
  //   final url = 'https://bldrsnet.firebaseio.com/bzz/$bzID.json';
  //   print('url is : $url');
  //   try {
  //     final response = await http.patch(url,
  //         body: json.encode({
  //           'followIsOn' : followIsOn,
  //         }));
  //     if (response.statusCode >= 400){
  //       _setFollowValue(oldStatus);
  //       print('response.statusCode is : ${response.body}');
  //     } else {
  //     print('followIsOn changed on server to : $followIsOn');
  //     // add the id in user's firebase document in  followedBzzIDs
  //     }
  //   } catch (error){
  //     _setFollowValue(oldStatus);
  //     print('error is : $error');
  //
  //   }
  // }
// ###############################
Map<String, dynamic> toMap(){
  return {
    'bzID' : bzID,
    // -------------------------
    'bzType' : cipherBzType(bzType),
    'bzForm' : cipherBzForm(bzForm),
    'bldrBirth' : cipherDateTimeToString(bldrBirth),
    'accountType' : cipherBzAccountType(accountType),
    'bzURL' : bzURL,
    // -------------------------
    'bzName' : bzName,
    'bzLogo' : bzLogo,
    'bzScope' : bzScope,
    'bzCountry' : bzCountry,
    'bzProvince' : bzProvince,
    'bzArea' : bzArea,
    'bzAbout' : bzAbout,
    'bzPosition' : bzPosition,
    'bzContacts' : cipherContactsModels(bzContacts),
    'bzAuthors' : cipherAuthorsModels(bzAuthors),
    'bzShowsTeam' : bzShowsTeam,
    // -------------------------
    'bzIsVerified' : bzIsVerified,
    'bzAccountIsDeactivated' : bzAccountIsDeactivated,
    'bzAccountIsBanned' : bzAccountIsBanned,
    // -------------------------
    'bzTotalFollowers' : bzTotalFollowers,
    'bzTotalSaves' : bzTotalSaves,
    'bzTotalShares' : bzTotalShares,
    'bzTotalSlides' : bzTotalSlides,
    'bzTotalViews' : bzTotalViews,
    'bzTotalCalls' : bzTotalCalls,
    // -------------------------
    'bzFlyers' : cipherTinyFlyers(bzFlyers),
    };
}
}
// -----------------------------------------------------------------------------
class TinyBz {
  final String bzID;
  final String bzLogo;
  final String bzName;
  final BzType bzType;

  TinyBz({
    @required this.bzID,
    @required this.bzLogo,
    @required this.bzName,
    @required this.bzType,
});

  Map<String,dynamic> toMap(){
    return {
      'bzID' : bzID,
      'bzLogo' : bzLogo,
      'bzName' : bzName,
      'bzType' : cipherBzType(bzType),
    };
  }

}

TinyBz getTinyBzFromBzModel(BzModel bzModel){
  return
      TinyBz(
          bzID: bzModel.bzID,
          bzLogo: bzModel.bzLogo,
          bzName: bzModel.bzName,
          bzType: bzModel.bzType,
      );
}
// -----------------------------------------------------------------------------
List<dynamic> cipherTinyBzzModels(List<TinyBz> tinyBzz){
  List<dynamic> _tinyBzzMaps = new List();
  tinyBzz.forEach((b) {
    _tinyBzzMaps.add(b.toMap());
  });
  return _tinyBzzMaps;
}
// -----------------------------------------------------------------------------
TinyBz decipherTinyBzMap(Map<String, dynamic> map){
  return TinyBz(
      bzID: map['bzID'],
      bzLogo: map['bzLogo'],
      bzName: map['bzName'],
      bzType: decipherBzType(map['bzType']),
  );
}
// -----------------------------------------------------------------------------
List<TinyBz> decipherTinyBzzMaps(List<dynamic> maps){
  List<TinyBz> _tinyBzz = new List();
  maps.forEach((map){
    _tinyBzz.add(decipherTinyBzMap(map));
  });
  return _tinyBzz;
}
// -----------------------------------------------------------------------------
enum BzType {
  Developer, // dv -> pp (property flyer - property source flyer)
  Broker, // br -> pp (property flyer)

  Designer, // dr - ds (design flyer)
  Contractor, // cn - pj (project flyer)
  Artisan, // ar - cr (craft flyer)

  Manufacturer, // mn - pd (product flyer - product source flyer)
  Supplier, // sp - pd (product flyer)
}
// -----------------------------------------------------------------------------
List<BzType> bzTypesList = <BzType>[
  BzType.Developer,
  BzType.Broker,

  BzType.Designer,
  BzType.Contractor,
  BzType.Artisan,

  BzType.Manufacturer,
  BzType.Supplier,
];
// -----------------------------------------------------------------------------
BzType decipherBzType (int x){
  switch (x){
    case 1:   return  BzType.Developer;        break;
    case 2:   return  BzType.Broker;        break;
    case 3:   return  BzType.Designer;      break;
    case 4:   return  BzType.Contractor;    break;
    case 5:   return  BzType.Artisan;       break;
    case 6:   return  BzType.Manufacturer;  break;
    case 7:   return  BzType.Supplier;      break;
    default : return   null;
  }
}
// -----------------------------------------------------------------------------
int cipherBzType (BzType x){
  switch (x){
    case BzType.Developer:      return  1;  break;
    case BzType.Broker:         return  2;  break;
    case BzType.Designer:       return  3;  break;
    case BzType.Contractor:     return  4;  break;
    case BzType.Artisan:        return  5;  break;
    case BzType.Manufacturer:   return  6;  break;
    case BzType.Supplier:       return  7;  break;
    default : return null;
  }
}
// -----------------------------------------------------------------------------
enum BzForm {
  Individual,
  Company,
}
// -----------------------------------------------------------------------------
List<BzForm> bzFormsList = <BzForm>[
  BzForm.Individual,
  BzForm.Company,
];
// -----------------------------------------------------------------------------
BzForm decipherBzForm (int x){
  switch (x){
    case 1:   return   BzForm.Individual;   break;
    case 2:   return   BzForm.Company;      break;
    default : return   null;
  }
}
// -----------------------------------------------------------------------------
int cipherBzForm (BzForm x){
  switch (x){
    case BzForm.Individual:   return 1; break;
    case BzForm.Company:      return 2; break;
    default : return null;
  }
}
// -----------------------------------------------------------------------------
enum BzAccountType{
  Default,
  Premium,
  Super,
}
// -----------------------------------------------------------------------------
List<BzAccountType> bzAccountTypesList = <BzAccountType>[
  BzAccountType.Default,
  BzAccountType.Premium,
  BzAccountType.Super,
];
// -----------------------------------------------------------------------------
BzAccountType decipherBzAccountType (int bzAccountType){
  switch (bzAccountType){
    case 1:   return  BzAccountType.Default;     break;
    case 2:   return  BzAccountType.Premium;     break;
    case 3:   return  BzAccountType.Super;       break;
    default : return   null;
  }
}
// -----------------------------------------------------------------------------
int cipherBzAccountType (BzAccountType bzAccountType){
  switch (bzAccountType){
    case BzAccountType.Default      :    return  1;  break;
    case BzAccountType.Premium      :    return  2;  break;
    case BzAccountType.Super        :    return  3;  break;
    default : return null;
  }
}
// -----------------------------------------------------------------------------
BzModel decipherBzMap(String bzID, dynamic map){
  return BzModel(
    bzID : bzID,
    // -------------------------
    bzType : decipherBzType(map['bzType']),
    bzForm : decipherBzForm(map['bzForm']),
    bldrBirth : decipherDateTimeString(map['bldrBirth']),
    accountType : decipherBzAccountType(map['accountType']),
    bzURL : map['bzURL'],
    // -------------------------
    bzName : map['bzName'],
    bzLogo : map['bzLogo'],
    bzScope : map['bzScope'],
    bzCountry : map['bzCountry'],
    bzProvince : map['bzProvince'],
    bzArea : map['bzArea'],
    bzAbout : map['bzAbout'],
    bzPosition : map['bzPosition'],
    bzContacts : decipherContactsMaps(map['bzContacts']),
    bzAuthors : decipherBzAuthorsMaps(map['bzAuthors']),
    bzShowsTeam : map['bzShowsTeam'],
    // -------------------------
    bzIsVerified : map['bzIsVerified'],
    bzAccountIsDeactivated : map['bzAccountIsDeactivated'],
    bzAccountIsBanned : map['bzAccountIsBanned'],
    // -------------------------
    bzTotalFollowers : map['bzTotalFollowers'],
    bzTotalSaves : map['bzTotalSaves'],
    bzTotalShares : map['bzTotalShares'],
    bzTotalSlides : map['bzTotalSlides'],
    bzTotalViews : map['bzTotalViews'],
    bzTotalCalls : map['bzTotalCalls'],
    // -------------------------
    bzFlyers: decipherTinyFlyers(map['bzFlyers']),
  );
}
// -----------------------------------------------------------------------------
List<BzModel> decipherBzMapsFromRealTimeDatabase(Map<String, dynamic> bigMap){
  List<BzModel> _bzList = new List();

  bigMap?.forEach((bzID, bzMap) {
    _bzList.add(decipherBzMap(bzID, bzMap));
  });

  return _bzList;
}
// -----------------------------------------------------------------------------
List<BzModel> decipherBzMapsFromFireStore(List<dynamic> maps) {
  List<BzModel> _bzList = new List();

  maps?.forEach((map) {
    _bzList.add(decipherBzMap(map['bzID'], map));
  });

  return _bzList;
}
// -----------------------------------------------------------------------------
BzModel createInitialBzModelFromUserData(UserModel userModel){
  return BzModel(
    bzID: null,
    bzName: userModel.company,
    bzCountry: userModel.country,
    bzProvince: userModel.province,
    bzArea: userModel.area,
    bzContacts: <ContactModel>[
      ContactModel(
          contact: getAContactValueFromContacts(userModel.contacts, ContactType.Email),
          contactType: ContactType.Email
      ),
      ContactModel(
          contact: getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
          contactType: ContactType.Phone
      ),
    ],
    bzAuthors: <AuthorModel>[createMasterAuthorModelFromUserModel(userModel)],
    bzShowsTeam: true,
    // -------------------------
    bzIsVerified: false,
    bzAccountIsDeactivated: false,
    bzAccountIsBanned: false,
    // -------------------------
    bzTotalFollowers: 0,
    bzTotalSaves: 0,
    bzTotalShares: 0,
    bzTotalSlides: 0,
    bzTotalViews: 0,
    bzTotalCalls: 0,
    // -------------------------
    bzFlyers: [],
  );
}
// -----------------------------------------------------------------------------
