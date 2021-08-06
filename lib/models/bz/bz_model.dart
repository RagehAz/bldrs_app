import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/nano_flyer.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final Zone bzZone;
  final String bzAbout;
  final GeoPoint bzPosition;
  final List<ContactModel> bzContacts;
  final List<AuthorModel> bzAuthors;
  final bool bzShowsTeam;
  // -------------------------
  final bool bzIsVerified;

  /// TASK : create bzState : online - offline - deactivated - deleted - banned
  final bool bzAccountIsDeactivated;
  final bool bzAccountIsBanned;
  // -------------------------
  int bzTotalFollowers;
  int bzTotalSaves;
  int bzTotalShares;
  int bzTotalSlides;
  int bzTotalViews;
  int bzTotalCalls;
  int bzTotalFlyers;
  // -------------------------
  final List<NanoFlyer> nanoFlyers;
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
    this.bzZone,
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
    this.nanoFlyers,
    @required this.bzTotalFlyers,
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

  List<NanoFlyer> _nanoFlyers = NanoFlyer.cipherNanoFlyers(nanoFlyers);

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
    'bzZone' : bzZone.toMap(),
    'bzAbout' : bzAbout,
    'bzPosition' : bzPosition,
    'bzContacts' : ContactModel.cipherContactsModels(bzContacts),
    'bzAuthors' : AuthorModel.cipherAuthorsModels(bzAuthors),
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
    'nanoFlyers' : _nanoFlyers,
    'bzTotalFlyers' : _nanoFlyers.length,
    };
}
// -----------------------------------------------------------------------------
  static BzAccountType decipherBzAccountType (int bzAccountType){
    switch (bzAccountType){
      case 1:   return  BzAccountType.Default;     break;
      case 2:   return  BzAccountType.Premium;     break;
      case 3:   return  BzAccountType.Super;       break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherBzAccountType (BzAccountType bzAccountType){
    switch (bzAccountType){
      case BzAccountType.Default      :    return  1;  break;
      case BzAccountType.Premium      :    return  2;  break;
      case BzAccountType.Super        :    return  3;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzModel decipherBzMap(String bzID, dynamic map){
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
      bzZone : Zone.decipherZoneMap(map['bzZone']),
      bzAbout : map['bzAbout'],
      bzPosition : map['bzPosition'],
      bzContacts : ContactModel.decipherContactsMaps(map['bzContacts']),
      bzAuthors : AuthorModel.decipherBzAuthorsMaps(map['bzAuthors']),
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
      nanoFlyers: NanoFlyer.decipherNanoFlyersMaps(map['nanoFlyers']),
      bzTotalFlyers: map['bzTotalFlyers'],
    );
  }
// -----------------------------------------------------------------------------
  static List<BzModel> decipherBzMapsFromRealTimeDatabase(Map<String, dynamic> bigMap){
    List<BzModel> _bzList = new List();

    bigMap?.forEach((bzID, bzMap) {
      _bzList.add(decipherBzMap(bzID, bzMap));
    });

    return _bzList;
  }
// -----------------------------------------------------------------------------
  static List<BzModel> decipherBzzMapsFromFireStore(List<dynamic> maps) {
    List<BzModel> _bzList = new List();

    maps?.forEach((map) {
      _bzList.add(decipherBzMap(map['bzID'], map));
    });

    return _bzList;
  }
// -----------------------------------------------------------------------------
  static BzModel createInitialBzModelFromUserData(UserModel userModel){
    return BzModel(
      bzID: null,
      bzName: userModel.company,
      bzZone: userModel.zone,
      bzContacts: <ContactModel>[
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Email),
            contactType: ContactType.Email
        ),
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.Phone),
            contactType: ContactType.Phone
        ),
      ],
      bzAuthors: <AuthorModel>[AuthorModel.createMasterAuthorModelFromUserModel(userModel)],
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
      nanoFlyers: [],
      bzTotalFlyers: 0,

    );
  }
// -----------------------------------------------------------------------------
  static BzType decipherBzType (int x){
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
  static int cipherBzType (BzType x){
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
  static BzForm decipherBzForm (int x){
    switch (x){
      case 1:   return   BzForm.Individual;   break;
      case 2:   return   BzForm.Company;      break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherBzForm (BzForm x){
    switch (x){
      case BzForm.Individual:   return 1; break;
      case BzForm.Company:      return 2; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static List<BzForm> bzFormsList = <BzForm>[
    BzForm.Individual,
    BzForm.Company,
  ];
// -----------------------------------------------------------------------------
  static List<BzAccountType> bzAccountTypesList = <BzAccountType>[
    BzAccountType.Default,
    BzAccountType.Premium,
    BzAccountType.Super,
  ];
// -----------------------------------------------------------------------------
  static List<BzType> bzTypesList = <BzType>[
    BzType.Developer,
    BzType.Broker,

    BzType.Designer,
    BzType.Contractor,
    BzType.Artisan,

    BzType.Manufacturer,
    BzType.Supplier,
  ];
// -----------------------------------------------------------------------------
  static List<String> getBzTeamIDs(BzModel bzModel){
  List<AuthorModel> _authors = bzModel.bzAuthors;
  List<String> _bzTeamIDs = new List();

  if (_authors != null){
    _authors.forEach((au) {
      _bzTeamIDs.add(au.userID);
    });

  }

  return _bzTeamIDs;
}
// -----------------------------------------------------------------------------
  static BzModel getBzFromBzzByBzID(List<BzModel> bzz, String bzID){
    BzModel _bz = bzz.singleWhere((_b) => _b.bzID == bzID, orElse: ()=> null);
    return _bz;
  }
// -----------------------------------------------------------------------------
  static List<String> getBzFlyersIDs(BzModel bzModel){
    List<String> _flyersIDs = new List();
    List<NanoFlyer> _nanoFlyers = bzModel.nanoFlyers;

    for (var nano in _nanoFlyers){
      _flyersIDs.add(nano.flyerID);
    }

    return   _flyersIDs;
  }
// -----------------------------------------------------------------------------
  static BzModel getTempBzModelFromTinyBz(TinyBz tinyBz){
    BzModel _bz;
    if (tinyBz != null){
      _bz = BzModel(
        bzID : tinyBz.bzID,
        // -------------------------
        bzType : tinyBz.bzType,
        bzForm : null,
        bldrBirth : null,
        accountType : null,
        bzURL : null,
        // -------------------------
        bzName :tinyBz.bzName,
        bzLogo : tinyBz.bzLogo,
        bzScope : null,
        bzZone : tinyBz.bzZone,
        bzAbout : null,
        bzPosition : null,
        bzContacts : null,
        bzAuthors : null,
        bzShowsTeam : null,
        // -------------------------
        bzIsVerified : null,
        bzAccountIsDeactivated : null,
        bzAccountIsBanned : null,
        // -------------------------
        bzTotalFollowers : tinyBz.bzTotalFollowers,
        bzTotalSaves : null,
        bzTotalShares : null,
        bzTotalSlides : null,
        bzTotalViews : null,
        bzTotalCalls : null,
        // -------------------------
        nanoFlyers: null,
        bzTotalFlyers: null,
      );
    }

    return _bz;
  }
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
enum BzForm {
  Individual,
  Company,
}
// -----------------------------------------------------------------------------
enum BzAccountType{
  Default,
  Premium,
  Super,
}
// -----------------------------------------------------------------------------
