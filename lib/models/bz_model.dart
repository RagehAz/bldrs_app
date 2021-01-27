import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'sub_models/author_model.dart';
import 'sub_models/contact_model.dart';
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
  final String bzCity; // cityID
  final String bzAbout;
  final GeoPoint bzPosition;
  final List<ContactModel> bzContacts;
  final List<AuthorModel> authors;
  final bool bzShowsTeam;
  // -------------------------
  final bool bzIsVerified;
  final bool bzAccountIsDeactivated;
  final bool bzAccountIsBanned;
  // -------------------------
  int bzTotalFollowers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;
  int bzTotalConnects;
  // -------------------------
  List<String> jointsBzzIDs;
  // -------------------------
  bool followIsOn;
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
    this.bzCity,
    this.bzAbout,
    this.bzPosition,
    this.bzContacts,
    this.authors,
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
    this.bzTotalConnects,
    // -------------------------
    this.jointsBzzIDs,
    // -------------------------
    this.followIsOn,
    // -------------------------
  });
// ###############################
  void toggleFollow(){
    followIsOn = !followIsOn;
    notifyListeners();
  }
// ###############################
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum BzType {
  Developer, // dv -> pp (property flyer - property source flyer)
  Broker, // br -> pp (property flyer)

  Designer, // dr - ds (design flyer)
  Contractor, // cn - pj (project flyer)
  Artisan, // ar - cr (craft flyer)

  Manufacturer, // mn - pd (product flyer - product source flyer)
  Supplier, // sp - pd (product flyer)
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<BzType> bzTypesList = [
  BzType.Developer,
  BzType.Broker,

  BzType.Designer,
  BzType.Contractor,
  BzType.Artisan,

  BzType.Manufacturer,
  BzType.Supplier,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
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
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum BzForm {
  Individual,
  Company,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<BzForm> bzFormsList = [
  BzForm.Individual,
  BzForm.Company,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BzForm decipherBzForm (int x){
  switch (x){
    case 1:   return   BzForm.Individual;   break;
    case 2:   return   BzForm.Company;      break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBzForm (BzForm x){
  switch (x){
    case BzForm.Individual:   return 1; break;
    case BzForm.Company:      return 2; break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
enum BzAccountType{
  Default,
  Premium,
  Super,
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
List<BzAccountType> bzAccountTypesList = [
  BzAccountType.Default,
  BzAccountType.Premium,
  BzAccountType.Super,
];
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
BzAccountType decipherBzAccountType (int bzAccountType){
  switch (bzAccountType){
    case 1:   return  BzAccountType.Default;     break;
    case 2:   return  BzAccountType.Premium;     break;
    case 3:   return  BzAccountType.Super;       break;
    default : return   null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
int cipherBzAccountType (BzAccountType bzAccountType){
  switch (bzAccountType){
    case BzAccountType.Default      :    return  1;  break;
    case BzAccountType.Premium      :    return  2;  break;
    case BzAccountType.Super        :    return  3;  break;
    default : return null;
  }
}
// x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x
