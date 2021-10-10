import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/ldb/sql_db/sql_column.dart';
import 'package:bldrs/models/zone/zone_model.dart';
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
    'createdAt' : createdAt,
    'accountType' : cipherBzAccountType(accountType),
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
    'flyersIDs' : flyersIDs,
    'bzTotalFlyers' : flyersIDs.length,
    'authorsIDs' : authorsIDs,
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
  static BzModel decipherBzMap(dynamic map){
  BzModel _bzModel;

  if (map != null){
    _bzModel = BzModel(
      bzID : map['bzID'],
      // -------------------------
      bzType : decipherBzType(map['bzType']),
      bzForm : decipherBzForm(map['bzForm']),
      createdAt : map['createdAt'].toDate(),
      accountType : decipherBzAccountType(map['accountType']),
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
      flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
      bzTotalFlyers: map['bzTotalFlyers'],
      authorsIDs: Mapper.getStringsFromDynamics(dynamics: map['authorsIDs']),
    );
  }

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  static List<BzModel> decipherBzzMapsFromFireStore(List<dynamic> maps) {
    final List<BzModel> _bzList = <BzModel>[];

    maps?.forEach((map) {
      _bzList.add(decipherBzMap(map));
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
      flyersIDs: <String>[],
      bzTotalFlyers: 0,
      authorsIDs: <String>[userModel.userID],
      createdAt: DateTime.now(),
      accountType: BzAccountType.Default,
      bzAbout: '',
      bzForm: BzForm.Individual,
      bzLogo: userModel.pic,
      bzPosition: null,
      bzScope: null,
      bzType: null,

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
  static const List<BzForm> bzFormsList = const <BzForm>[
    BzForm.Individual,
    BzForm.Company,
  ];
// -----------------------------------------------------------------------------
  static const List<BzAccountType> bzAccountTypesList = const <BzAccountType>[
    BzAccountType.Default,
    BzAccountType.Premium,
    BzAccountType.Super,
  ];
// -----------------------------------------------------------------------------
  static const List<BzType> bzTypesList = const <BzType>[
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
  static BzModel getTempBzModelFromTinyBz(TinyBz tinyBz){
    BzModel _bz;
    if (tinyBz != null){
      _bz = BzModel(
        bzID : tinyBz.bzID,
        // -------------------------
        bzType : tinyBz.bzType,
        bzForm : null,
        createdAt : null,
        accountType : null,
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
        flyersIDs: <String>[],
        bzTotalFlyers: null,
        authorsIDs: <String>[],
      );
    }
    return _bz;
  }
// -----------------------------------------------------------------------------
  static BzModel getBzModelFromSnapshot(DocumentSnapshot doc){
    final DocumentSnapshot _map = doc.data();
    final BzModel _bzModel = BzModel.decipherBzMap(_map);
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
  static List<SQLColumn> createBzzLDBColumns(){

  const List<SQLColumn> _columns = const <SQLColumn>[
    // -------------------------
    SQLColumn(key: 'bzID', type: 'TEXT', isPrimary: true),
    // -------------------------
    SQLColumn(key: 'bzType', type: 'INTEGER'),
    SQLColumn(key: 'bzForm', type: 'INTEGER'),
    SQLColumn(key: 'createdAt', type: 'TEXT'),
    SQLColumn(key: 'accountType', type: 'INTEGER'),
    // -------------------------
    SQLColumn(key: 'bzName', type: 'TEXT'),
    SQLColumn(key: 'bzLogo', type: 'TEXT'),
    SQLColumn(key: 'bzScope', type: 'TEXT'),
    // -------------------------
    SQLColumn(key: 'bzZone_countryID', type: 'TEXT'),
    SQLColumn(key: 'bzZone_cityID', type: 'TEXT'),
    SQLColumn(key: 'bzZone_districtID', type: 'TEXT'),
    // -------------------------
    SQLColumn(key: 'bzAbout', type: 'TEXT'),
    SQLColumn(key: 'bzPosition', type: 'TEXT'),
    SQLColumn(key: 'bzContacts', type: 'TEXT'),
    // LDBColumn(key: 'bzAuthors', type: 'TEXT'), // separated in separate LDB
    SQLColumn(key: 'bzShowsTeam', type: 'INTEGER'),
    // -------------------------
    SQLColumn(key: 'bzIsVerified', type: 'INTEGER'),
    SQLColumn(key: 'bzAccountIsDeactivated', type: 'INTEGER'),
    SQLColumn(key: 'bzAccountIsBanned', type: 'INTEGER'),
    // -------------------------
    SQLColumn(key: 'bzTotalFollowers', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalSaves', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalShares', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalSlides', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalViews', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalCalls', type: 'INTEGER'),
    SQLColumn(key: 'bzTotalFlyers', type: 'INTEGER'),
    // -------------------------
    SQLColumn(key: 'flyersIDs', type: 'TEXT'),
    SQLColumn(key: 'authorsIDs', type: 'TEXT'),
  ];

  return _columns;


  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> sqlCipherBz(BzModel bz) async {
    Map<String, Object> _map;

    if (bz != null) {
      _map = {
        'bzID': bz.bzID,
        'bzType' : cipherBzType(bz.bzType),
        'bzForm' : cipherBzForm(bz.bzForm),
        'createdAt' : Timers.cipherDateTimeIso8601(bz.createdAt),
        'accountType' : cipherBzAccountType(bz.accountType),
        'bzName' : bz.bzName,
        'bzLogo' : await Imagers.urlOrImageFileToBase64(bz.bzLogo),
        'bzScope' : bz.bzScope,
        'bzZone_countryID' : bz.bzZone.countryID,
        'bzZone_cityID' : bz.bzZone.cityID,
        'bzZone_districtID' : bz.bzZone.districtID,
        'bzAbout' : bz.bzAbout,
        'bzPosition' : Atlas.sqlCipherGeoPoint(bz.bzPosition),
        'bzContacts' : ContactModel.sqlCipherContacts(bz.bzContacts),
        'bzShowsTeam' : Numeric.sqlCipherBool(bz.bzShowsTeam),
        'bzIsVerified' : Numeric.sqlCipherBool(bz.bzIsVerified),
        'bzAccountIsDeactivated' : Numeric.sqlCipherBool(bz.bzAccountIsDeactivated),
        'bzAccountIsBanned' : Numeric.sqlCipherBool(bz.bzAccountIsBanned),
        'bzTotalFollowers' : bz.bzTotalFollowers,
        'bzTotalSaves' : bz.bzTotalSaves,
        'bzTotalShares' : bz.bzTotalShares,
        'bzTotalSlides' : bz.bzTotalSlides,
        'bzTotalViews' : bz.bzTotalViews,
        'bzTotalCalls' : bz.bzTotalCalls,
        'bzTotalFlyers' : bz.bzTotalFlyers,
        'flyersIDs' : TextMod.sqlCipherStrings(bz.flyersIDs),
        'authorsIDs' : TextMod.sqlCipherStrings(bz.authorsIDs),

        // 'bzAuthors' // separated in separate LDB

      };

      return _map;
    }

    return _map;
  }
// -----------------------------------------------------------------------------
  static Future<BzModel> sqlDecipherBz(Map<String, Object> map, List<AuthorModel> authors) async {
    BzModel _bz;

    if (map != null){

      _bz = BzModel(
        bzID : map['bzID'],
        // -------------------------
        bzType : decipherBzType(map['bzType']),
        bzForm : decipherBzForm(map['bzForm']),
        createdAt : Timers.decipherDateTimeIso8601(map['createdAt']),
        accountType : decipherBzAccountType(map['accountType']),
        // -------------------------
        bzName : map['bzName'],
        bzLogo : await Imagers.base64ToFile(map['bzLogo']),
        bzScope : map['bzScope'],
        bzZone : Zone(
          countryID: map['bzZone_countryID'],
          cityID: map['bzZone_cityID'],
          districtID: map['bzZone_districtID'],
        ),
        bzAbout : map['bzAbout'],
        bzPosition : Atlas.sqlDecipherGeoPoint(map['bzPosition']),
        bzContacts : ContactModel.sqlDecipherContacts(map['bzContacts']),
        bzAuthors : authors,
        bzShowsTeam : Numeric.sqlDecipherBool(map['bzShowsTeam']),
        // -------------------------
        bzIsVerified : Numeric.sqlDecipherBool(map['bzIsVerified']),
        bzAccountIsDeactivated : Numeric.sqlDecipherBool(map['bzAccountIsDeactivated']),
        bzAccountIsBanned : Numeric.sqlDecipherBool(map['bzAccountIsBanned']),
        // -------------------------
        bzTotalFollowers : map['bzTotalFollowers'],
        bzTotalSaves : map['bzTotalSaves'],
        bzTotalShares : map['bzTotalShares'],
        bzTotalSlides : map['bzTotalSlides'],
        bzTotalViews : map['bzTotalViews'],
        bzTotalCalls : map['bzTotalCalls'],
        bzTotalFlyers: map['bzTotalFlyers'],
        // -------------------------
        flyersIDs: TextMod.sqlDecipherStrings(map['flyersIDs']),
        authorsIDs: TextMod.sqlDecipherStrings(map['authorsIDs']),
      );

    }

    return _bz;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> sqlCipherBzz(List<BzModel> bzz) async {
    List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (bzz != null && bzz.isNotEmpty){

      for (BzModel bz in bzz){

        final Map<String, Object> _map = await sqlCipherBz(bz);

        _maps.add(_map);

      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> sqlDecipherBzz({List<Map<String, Object>> maps, List<AuthorModel> allAuthors}) async {
    List<BzModel> _bzz = <BzModel>[];

    if (maps != null && maps.isNotEmpty){

      for (var map in maps){

        final List<String> _bzAuthorsIDs = TextMod.sqlDecipherStrings(map['authorsIDs']);

        final List<AuthorModel> _bzAuthors = AuthorModel.getAuthorsFromAuthorsByAuthorsIDs(allAuthors, _bzAuthorsIDs);

        final BzModel _bz = await sqlDecipherBz(map, _bzAuthors);

        _bzz.add(_bz);

      }

    }

    return _bzz;
  }
// -----------------------------------------------------------------------------
}


