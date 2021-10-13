import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
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
enum BzType {
  developer, // dv -> pp (property flyer - property source flyer)
  broker, // br -> pp (property flyer)

  designer, // dr - ds (design flyer)
  contractor, // cn - pj (project flyer)
  artisan, // ar - cr (craft flyer)

  manufacturer, // mn - pd (product flyer - product source flyer)
  supplier, // sp - pd (product flyer)
}
// -----------------------------------------------------------------------------
enum BzForm {
  individual,
  company,
}
// -----------------------------------------------------------------------------
enum BzAccountType{
  normal,
  premium,
  sphinx,
}
// -----------------------------------------------------------------------------
class BzModel with ChangeNotifier{
  final String bzID;
  // -------------------------
  final BzType bzType;
  final BzForm bzForm;
  final DateTime createdAt;
  final BzAccountType accountType;
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
  final List<String> flyersIDs;
  final List<String> authorsIDs;

// ###############################
  BzModel({
    this.bzID,
    // -------------------------
    this.bzType,
    this.bzForm,
    this.createdAt,
    this.accountType,
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
    this.flyersIDs,
    @required this.bzTotalFlyers,
    @required this.authorsIDs,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

  return {
    'bzID' : bzID,
    // -------------------------
    'bzType' : cipherBzType(bzType),
    'bzForm' : cipherBzForm(bzForm),
    'createdAt' : Timers.cipherTime(time: createdAt, toJSON: toJSON),
    'accountType' : cipherBzAccountType(accountType),
    // -------------------------
    'bzName' : bzName,
    'bzLogo' : bzLogo,
    'bzScope' : bzScope,
    'bzZone' : bzZone.toMap(),
    'bzAbout' : bzAbout,
    'bzPosition' : Atlas.cipherGeoPoint(point: bzPosition, toJSON: toJSON),
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
    'flyersIDs' : flyersIDs,
    'bzTotalFlyers' : flyersIDs.length,
    'authorsIDs' : authorsIDs,
    };
}
// -----------------------------------------------------------------------------
  static BzModel decipherBzMap({@required dynamic map, @required bool fromJSON}){
    BzModel _bzModel;

    if (map != null){

      _bzModel = BzModel(
        bzID : map['bzID'],
        // -------------------------
        bzType : decipherBzType(map['bzType']),
        bzForm : decipherBzForm(map['bzForm']),
        createdAt : Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        accountType : decipherBzAccountType(map['accountType']),
        // -------------------------
        bzName : map['bzName'],
        bzLogo : map['bzLogo'],
        bzScope : map['bzScope'],
        bzZone : Zone.decipherZoneMap(map['bzZone']),
        bzAbout : map['bzAbout'],
        bzPosition : Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
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
        flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
        bzTotalFlyers: map['bzTotalFlyers'],
        authorsIDs: Mapper.getStringsFromDynamics(dynamics: map['authorsIDs']),
      );
    }

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  static List<BzModel> decipherBzzMaps({@required List<dynamic> maps,@required bool fromJSON}) {
    final List<BzModel> _bzList = <BzModel>[];

    maps?.forEach((map) {
      _bzList.add(decipherBzMap(
        map: map,
        fromJSON: fromJSON,
      ));
    });

    return _bzList;
  }
// -----------------------------------------------------------------------------
  static BzAccountType decipherBzAccountType (String bzAccountType){
    switch (bzAccountType){
      case 'normal'  :   return  BzAccountType.normal;     break; // 1
      case 'premium' :   return  BzAccountType.premium;     break; // 2
      case 'sphinx'  :   return  BzAccountType.sphinx;       break; // 3
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzAccountType (BzAccountType bzAccountType){
    switch (bzAccountType){
      case BzAccountType.normal         :    return 'normal' ;  break;
      case BzAccountType.premium        :    return 'premium';  break;
      case BzAccountType.sphinx         :    return 'sphinx' ;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzModel createInitialBzModelFromUserData(UserModel userModel){
    return BzModel(
      bzID: null,
      bzName: userModel.company,
      bzZone: userModel.zone,
      bzContacts: <ContactModel>[
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.email),
            contactType: ContactType.email
        ),
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.phone),
            contactType: ContactType.phone
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
      flyersIDs: <String>[],
      bzTotalFlyers: 0,
      authorsIDs: <String>[userModel.userID],
      createdAt: DateTime.now(),
      accountType: BzAccountType.normal,
      bzAbout: '',
      bzForm: BzForm.individual,
      bzLogo: userModel.pic,
      bzPosition: null,
      bzScope: null,
      bzType: null,

    );
  }
// -----------------------------------------------------------------------------

  static BzType decipherBzType (String x){
    switch (x){
      case 'developer'    :   return  BzType.developer;     break; // 1
      case 'broker'       :   return  BzType.broker;        break; // 2
      case 'designer'     :   return  BzType.designer;      break; // 3
      case 'contractor'   :   return  BzType.contractor;    break; // 4
      case 'artisan'      :   return  BzType.artisan;       break; // 5
      case 'manufacturer' :   return  BzType.manufacturer;  break; // 6
      case 'supplier'     :   return  BzType.supplier;      break; // 7
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzType (BzType x){
    switch (x){
      case BzType.developer:      return  'developer'   ;  break;
      case BzType.broker:         return  'broker'      ;  break;
      case BzType.designer:       return  'designer'    ;  break;
      case BzType.contractor:     return  'contractor'  ;  break;
      case BzType.artisan:        return  'artisan'     ;  break;
      case BzType.manufacturer:   return  'manufacturer';  break;
      case BzType.supplier:       return  'supplier'    ;  break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzForm decipherBzForm (String x){
    switch (x){
      case 'individual' :   return   BzForm.individual;   break; // 1
      case 'company'    :   return   BzForm.company;      break; // 2
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzForm (BzForm x){
    switch (x){
      case BzForm.individual:   return 'individual'; break;
      case BzForm.company:      return 'company'   ; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static const List<BzForm> bzFormsList = const <BzForm>[
    BzForm.individual,
    BzForm.company,
  ];
// -----------------------------------------------------------------------------
  static const List<BzAccountType> bzAccountTypesList = const <BzAccountType>[
    BzAccountType.normal,
    BzAccountType.premium,
    BzAccountType.sphinx,
  ];
// -----------------------------------------------------------------------------
  static const List<BzType> bzTypesList = const <BzType>[
    BzType.developer,
    BzType.broker,

    BzType.designer,
    BzType.contractor,
    BzType.artisan,

    BzType.manufacturer,
    BzType.supplier,
  ];
// -----------------------------------------------------------------------------
  static List<String> getBzTeamIDs(BzModel bzModel){
    final List<AuthorModel> _authors = bzModel.bzAuthors;
    final List<String> _bzTeamIDs = <String>[];

    if (_authors != null){
      _authors.forEach((au) {
        _bzTeamIDs.add(au.userID);
      });

    }

  return _bzTeamIDs;
}
// -----------------------------------------------------------------------------
  static BzModel getBzFromBzzByBzID(List<BzModel> bzz, String bzID){
    final BzModel _bz = bzz.singleWhere((_b) => _b.bzID == bzID, orElse: ()=> null);
    return _bz;
  }
// -----------------------------------------------------------------------------
  static BzModel getBzModelFromSnapshot(DocumentSnapshot doc){
    final DocumentSnapshot _map = doc.data();
    final BzModel _bzModel = BzModel.decipherBzMap(
      map: _map,
      fromJSON: false,
    );

    print(' map the bz Model is $_bzModel');

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  void printBzModel({String methodName = 'printBzModel'}){

    print('$methodName : PRINTING BZ MODEL ---------------- START -- ');

    print('bzID : $bzID');
    print('bzType : $bzType');
    print('bzForm : $bzForm');
    print('createdAt : $createdAt');
    print('accountType : $accountType');
    print('bzName : $bzName');
    print('bzLogo : $bzLogo');
    print('bzScope : $bzScope');
    print('bzZone : $bzZone');
    print('bzAbout : $bzAbout');
    print('bzPosition : $bzPosition');
    print('bzContacts : $bzContacts');
    print('bzAuthors : $bzAuthors');
    print('bzShowsTeam : $bzShowsTeam');
    print('bzIsVerified : $bzIsVerified');
    print('bzAccountIsDeactivated : $bzAccountIsDeactivated');
    print('bzAccountIsBanned : $bzAccountIsBanned');
    print('bzTotalFollowers : $bzTotalFollowers');
    print('bzTotalSaves : $bzTotalSaves');
    print('bzTotalShares : $bzTotalShares');
    print('bzTotalSlides : $bzTotalSlides');
    print('bzTotalViews : $bzTotalViews');
    print('bzTotalCalls : $bzTotalCalls');
    print('flyersIDs : $flyersIDs');
    print('bzTotalFlyers : $bzTotalFlyers');
    print('authorsIDs : $authorsIDs');

    print('$methodName : PRINTING BZ MODEL ---------------- END -- ');

  }
// -----------------------------------------------------------------------------
  static const List<String> bzPagesTabsTitles = <String>['Flyers', 'About', 'Targets', 'Powers'];
// -----------------------------------------------------------------------------
  static bool BzzContainThisBz({List<BzModel> bzz, BzModel bzModel}){
    bool _contains = false;


    if (Mapper.canLoopList(bzz) && bzModel != null){

      for (BzModel bz in bzz){

        if (bz.bzID == bzModel.bzID){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static List<String> getBzzIDsFromBzz(List<BzModel> bzzModels){
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(bzzModels)){

      if (bzzModels != null){
        bzzModels.forEach((bz) {
          _ids.add(bz.bzID);
        });
      }


    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static BzModel dummyBz(String bzID){

    final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';

    return
        BzModel(
            bzID: _bzID,
            bzLogo: Iconz.DumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
            bzName: 'Business Name',
            bzType: BzType.designer,
            bzZone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
            bzTotalFollowers: 1000,
            bzTotalFlyers: 10,
          authorsIDs: ['x'],
        );
  }

}

/*

ZEBALA


  static String fixBzAccountTypeFromIntToString(int bzAccountType){
    switch (bzAccountType){
      case 1 :   return  'normal' ;     break; // 1
      case 2 :   return  'premium';     break; // 2
      case 3 :   return  'sphinx' ;       break; // 3
      default : return   null;
    }
  }

  static String fixBzTypeFromIntToString(int x){
    switch (x){
      case  1:   return  'developer'   ;  break; // 1
      case  2:   return  'broker'      ;  break; // 2
      case  3:   return  'designer'    ;  break; // 3
      case  4:   return  'contractor'  ;  break; // 4
      case  5:   return  'artisan'     ;  break; // 5
      case  6:   return  'manufacturer';  break; // 6
      case  7:   return  'supplier'    ;  break; // 7
      default : return   null;
    }
  }

  static String fixBzFormFromIntToString(int x){
    switch (x){
      case 1    :   return  'individual' ;  break; // 1
      case 2    :   return  'company'    ;  break; // 2
      default : return   null;
    }
  }

 */
