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
enum BzState {
  online,
  offline,
  deactivated,
  deleted,
  banned,
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
  final String name;
  final dynamic logo;
  final String scope;

  final Zone zone;
  final String about;
  final GeoPoint position;
  final List<ContactModel> contacts;
  final List<AuthorModel> authors;
  final bool showsTeam;
  // -------------------------
  final bool isVerified;

  final BzState bzState;
  // -------------------------
  int totalFollowers;
  int totalSaves;
  int totalShares;
  int totalSlides;
  int totalViews;
  int totalCalls;
  int totalFlyers;
  // -------------------------
  final List<String> flyersIDs;

// ###############################
  BzModel({
    this.bzID,
    // -------------------------
    this.bzType,
    this.bzForm,
    this.createdAt,
    this.accountType,
    // -------------------------
    this.name,
    this.logo,
    this.scope,
    this.zone,
    this.about,
    this.position,
    this.contacts,
    this.authors,
    this.showsTeam,
    // -------------------------
    this.isVerified,
    @required this.bzState,
    // -------------------------
    this.totalFollowers,
    this.totalSaves,
    this.totalShares,
    this.totalSlides,
    this.totalViews,
    this.totalCalls,
    // -------------------------
    this.flyersIDs,
    @required this.totalFlyers,
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
      'name' : name,
      'logo' : logo,
      'scope' : scope,
      'zone' : zone.toMap(),
      'about' : about,
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts' : ContactModel.cipherContactsModels(contacts),
      'authors' : AuthorModel.cipherAuthorsModels(authors),
      'showsTeam' : showsTeam,
      // -------------------------
      'isVerified' : isVerified,
      'bzState' : cipherBzState(bzState),
      // -------------------------
      'totalFollowers' : totalFollowers,
      'totalSaves' : totalSaves,
      'totalShares' : totalShares,
      'totalSlides' : totalSlides,
      'totalViews' : totalViews,
      'totalCalls' : totalCalls,
      'totalFlyers' : totalFlyers,
      // -------------------------
      'flyersIDs' : flyersIDs,
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
        name : map['name'],
        logo : map['logo'],
        scope : map['scope'],
        zone : Zone.decipherZoneMap(map['zone :']),
        about : map['about'],
        position : Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts : ContactModel.decipherContactsMaps(map['contacts']),
        authors : AuthorModel.decipherBzAuthorsMaps(map['authors']),
        showsTeam : map['showsTeam'],
        // -------------------------
        isVerified : map['isVerified'],
        bzState : decipherBzState(map['bzState']),
        // -------------------------
        totalFollowers : map['totalFollowers'],
        totalSaves : map['totalSaves'],
        totalShares : map['totalShares'],
        totalSlides : map['totalSlides'],
        totalViews : map['totalViews'],
        totalCalls : map['totalCalls'],
        // -------------------------
        flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
        totalFlyers: map['totalFlyers'],
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
      name: userModel.company,
      zone: userModel.zone,
      contacts: <ContactModel>[
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.email),
            contactType: ContactType.email
        ),
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(userModel.contacts, ContactType.phone),
            contactType: ContactType.phone
        ),
      ],
      authors: <AuthorModel>[AuthorModel.createMasterAuthorModelFromUserModel(userModel)],
      showsTeam: true,
      // -------------------------
      isVerified: false,
      bzState: BzState.offline,
      // -------------------------
      totalFollowers: 0,
      totalSaves: 0,
      totalShares: 0,
      totalSlides: 0,
      totalViews: 0,
      totalCalls: 0,
      // -------------------------
      flyersIDs: <String>[],
      totalFlyers: 0,
      createdAt: DateTime.now(),
      accountType: BzAccountType.normal,
      about: '',
      bzForm: BzForm.individual,
      logo: userModel.pic,
      position: null,
      scope: null,
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
  static String cipherBzState(BzState state){
    switch(state){
      case BzState.online : return 'online'; break;
      case BzState.offline : return 'offline'; break;
      case BzState.deactivated : return 'deactivated'; break;
      case BzState.deleted : return 'deleted'; break;
      case BzState.banned : return 'banned'; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzState decipherBzState(String state){
    switch(state){
      case 'online' : return BzState.online; break;
      case 'offline' : return BzState.offline; break;
      case 'deactivated' : return BzState.deactivated; break;
      case 'deleted' : return BzState.deleted; break;
      case 'banned' : return BzState.banned; break;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static const List<BzState> bzStatesList = const <BzState>[
    BzState.online,
    BzState.offline,
    BzState.deactivated,
    BzState.deleted,
    BzState.banned,
  ];
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
    final List<AuthorModel> _authors = bzModel.authors;
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

    String _methodName = methodName ?? 'BZ';

    print('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    print('bzID : $bzID');
    print('bzType : $bzType');
    print('bzForm : $bzForm');
    print('createdAt : $createdAt');
    print('accountType : $accountType');
    print('mame : $name');
    print('logo : $logo');
    print('scope : $scope');
    print('zone : $zone');
    print('about : $about');
    print('position : $position');
    print('contacts : $contacts');
    print('authors : $authors');
    print('showsTeam : $showsTeam');
    print('isVerified : $isVerified');
    print('bzState : $bzState');
    print('totalFollowers : $totalFollowers');
    print('totalSaves : $totalSaves');
    print('totalShares : $totalShares');
    print('totalSlides : $totalSlides');
    print('totalViews : $totalViews');
    print('totalCalls : $totalCalls');
    print('flyersIDs : $flyersIDs');
    print('totalFlyers : $totalFlyers');

    print('$_methodName : PRINTING BZ MODEL ---------------- END -- ');

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
        logo: Iconz.DumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
        name: 'Business Name',
        bzType: BzType.designer,
        zone: Zone(countryID: 'egy', cityID: 'cairo', districtID: 'heliopolis'),
        totalFollowers: 1000,
        totalFlyers: 10,
        bzState: BzState.online,
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
