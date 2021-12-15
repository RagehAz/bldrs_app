import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
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
enum BzAccountType {
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
class BzModel with ChangeNotifier {
  /// --------------------------------------------------------------------------
  BzModel({
    @required this.id,
    // -------------------------
    @required this.bzType,
    @required this.bzForm,
    @required this.createdAt,
    @required this.accountType,
    // -------------------------
    @required this.name,
    @required this.trigram,
    @required this.logo,
    @required this.scope,
    @required this.zone,
    @required this.about,
    @required this.position,
    @required this.contacts,
    @required this.authors,
    @required this.showsTeam,
    // -------------------------
    @required this.isVerified,
    @required this.bzState,
    // -------------------------
    @required this.totalFollowers,
    @required this.totalSaves,
    @required this.totalShares,
    @required this.totalSlides,
    @required this.totalViews,
    @required this.totalCalls,
    // -------------------------
    @required this.flyersIDs,
    @required this.totalFlyers,
  });
  /// --------------------------------------------------------------------------
  final String id;
  // -------------------------
  final BzType bzType;
  final BzForm bzForm;
  final DateTime createdAt;
  final BzAccountType accountType;
  // -------------------------
  final String name;
  final List<String> trigram;
  final dynamic logo;
  final String scope;

  final ZoneModel zone;
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
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}) {
    return <String, dynamic>{
      'id': id,
      // -------------------------
      'bzType': cipherBzType(bzType),
      'bzForm': cipherBzForm(bzForm),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'accountType': cipherBzAccountType(accountType),
      // -------------------------
      'name': name,
      'trigram': trigram,
      'logo': logo,
      'scope': scope,
      'zone': zone.toMap(),
      'about': about,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
      'authors': AuthorModel.cipherAuthors(authors),
      'showsTeam': showsTeam,
      // -------------------------
      'isVerified': isVerified,
      'bzState': cipherBzState(bzState),
      // -------------------------
      'totalFollowers': totalFollowers,
      'totalSaves': totalSaves,
      'totalShares': totalShares,
      'totalSlides': totalSlides,
      'totalViews': totalViews,
      'totalCalls': totalCalls,
      'totalFlyers': totalFlyers,
      // -------------------------
      'flyersIDs': flyersIDs,
    };
  }
// -----------------------------------------------------------------------------
  static BzModel decipherBz({
    @required dynamic map,
    @required bool fromJSON
  }) {
    BzModel _bzModel;

    if (map != null) {
      _bzModel = BzModel(
        id: map['id'],
        // -------------------------
        bzType: decipherBzType(map['bzType']),
        bzForm: decipherBzForm(map['bzForm']),
        createdAt:
            Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        accountType: decipherBzAccountType(map['accountType']),
        // -------------------------
        name: map['name'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
        logo: map['logo'],
        scope: map['scope'],
        zone: ZoneModel.decipherZoneMap(map['zone']),
        about: map['about'],
        position:
            Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts: ContactModel.decipherContacts(map['contacts']),
        authors: AuthorModel.decipherAuthors(map['authors']),
        showsTeam: map['showsTeam'],
        // -------------------------
        isVerified: map['isVerified'],
        bzState: decipherBzState(map['bzState']),
        // -------------------------
        totalFollowers: map['totalFollowers'],
        totalSaves: map['totalSaves'],
        totalShares: map['totalShares'],
        totalSlides: map['totalSlides'],
        totalViews: map['totalViews'],
        totalCalls: map['totalCalls'],
        // -------------------------
        flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
        totalFlyers: map['totalFlyers'],
      );
    }

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  static List<BzModel> decipherBzz({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON
  }) {
    final List<BzModel> _bzList = <BzModel>[];

    for (final Map<String, dynamic> map in maps) {
      _bzList.add(decipherBz(
        map: map,
        fromJSON: fromJSON,
      ));
    }

    return _bzList;
  }
// -----------------------------------------------------------------------------
  static BzAccountType decipherBzAccountType(String bzAccountType) {
    switch (bzAccountType) {
      case 'normal':
        return BzAccountType.normal;
        break; // 1
      case 'premium':
        return BzAccountType.premium;
        break; // 2
      case 'sphinx':
        return BzAccountType.sphinx;
        break; // 3
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzAccountType(BzAccountType bzAccountType) {
    switch (bzAccountType) {
      case BzAccountType.normal:
        return 'normal';
        break;
      case BzAccountType.premium:
        return 'premium';
        break;
      case BzAccountType.sphinx:
        return 'sphinx';
        break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzModel createInitialBzModelFromUserData(UserModel userModel) {
    return BzModel(
      id: null,
      name: userModel.company,
      trigram: TextGen.createTrigram(input: userModel.company),
      zone: userModel.zone,
      contacts: <ContactModel>[
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(
                userModel.contacts, ContactType.email),
            contactType: ContactType.email),
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(
                userModel.contacts, ContactType.phone),
            contactType: ContactType.phone),
      ],
      authors: <AuthorModel>[
        AuthorModel.createMasterAuthorModelFromUserModel(userModel)
      ],
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
  static BzType decipherBzType(String x) {
    switch (x) {
      case 'developer':
        return BzType.developer;
        break; // 1
      case 'broker':
        return BzType.broker;
        break; // 2
      case 'designer':
        return BzType.designer;
        break; // 3
      case 'contractor':
        return BzType.contractor;
        break; // 4
      case 'artisan':
        return BzType.artisan;
        break; // 5
      case 'manufacturer':
        return BzType.manufacturer;
        break; // 6
      case 'supplier':
        return BzType.supplier;
        break; // 7
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzType(BzType x) {
    switch (x) {
      case BzType.developer:
        return 'developer';
        break;
      case BzType.broker:
        return 'broker';
        break;
      case BzType.designer:
        return 'designer';
        break;
      case BzType.contractor:
        return 'contractor';
        break;
      case BzType.artisan:
        return 'artisan';
        break;
      case BzType.manufacturer:
        return 'manufacturer';
        break;
      case BzType.supplier:
        return 'supplier';
        break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzForm decipherBzForm(String x) {
    switch (x) {
      case 'individual':
        return BzForm.individual;
        break; // 1
      case 'company':
        return BzForm.company;
        break; // 2
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzForm(BzForm x) {
    switch (x) {
      case BzForm.individual:
        return 'individual';
        break;
      case BzForm.company:
        return 'company';
        break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherBzState(BzState state) {
    switch (state) {
      case BzState.online:
        return 'online';
        break;
      case BzState.offline:
        return 'offline';
        break;
      case BzState.deactivated:
        return 'deactivated';
        break;
      case BzState.deleted:
        return 'deleted';
        break;
      case BzState.banned:
        return 'banned';
        break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static BzState decipherBzState(String state) {
    switch (state) {
      case 'online':
        return BzState.online;
        break;
      case 'offline':
        return BzState.offline;
        break;
      case 'deactivated':
        return BzState.deactivated;
        break;
      case 'deleted':
        return BzState.deleted;
        break;
      case 'banned':
        return BzState.banned;
        break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static const List<BzState> bzStatesList = <BzState>[
    BzState.online,
    BzState.offline,
    BzState.deactivated,
    BzState.deleted,
    BzState.banned,
  ];
// -----------------------------------------------------------------------------
  static const List<BzForm> bzFormsList = <BzForm>[
    BzForm.individual,
    BzForm.company,
  ];
// -----------------------------------------------------------------------------
  static const List<BzAccountType> bzAccountTypesList = <BzAccountType>[
    BzAccountType.normal,
    BzAccountType.premium,
    BzAccountType.sphinx,
  ];
// -----------------------------------------------------------------------------
  static const List<BzType> bzTypesList = <BzType>[
    BzType.developer,
    BzType.broker,
    BzType.designer,
    BzType.contractor,
    BzType.artisan,
    BzType.manufacturer,
    BzType.supplier,
  ];
// -----------------------------------------------------------------------------
  static List<String> getBzTeamIDs(BzModel bzModel) {
    final List<AuthorModel> _authors = bzModel.authors;
    final List<String> _bzTeamIDs = <String>[];

    if (_authors != null) {
      for (final AuthorModel author in _authors) {
        _bzTeamIDs.add(author.userID);
      }
    }

    return _bzTeamIDs;
  }
// -----------------------------------------------------------------------------
  static BzModel getBzFromBzzByBzID(List<BzModel> bzz, String bzID) {
    final BzModel _bz =
        bzz.singleWhere((BzModel _b) => _b.id == bzID, orElse: () => null);
    return _bz;
  }
// -----------------------------------------------------------------------------
  static BzModel getBzModelFromSnapshot(DocumentSnapshot<Object> doc) {
    final DocumentSnapshot<Object> _map = doc.data();
    final BzModel _bzModel = BzModel.decipherBz(
      map: _map,
      fromJSON: false,
    );

    blog(' map the bz Model is $_bzModel');

    return _bzModel;
  }
// -----------------------------------------------------------------------------
  void blogBz({String methodName = 'printBzModel'}) {
    final String _methodName = methodName ?? 'BZ';

    blog('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    blog('id : $id');
    blog('bzType : $bzType');
    blog('bzForm : $bzForm');
    blog('createdAt : $createdAt');
    blog('accountType : $accountType');
    blog('mame : $name');
    blog('logo : $logo');
    blog('scope : $scope');
    blog('zone : $zone');
    blog('about : $about');
    blog('position : $position');
    blog('contacts : $contacts');
    blog('authors : $authors');
    blog('showsTeam : $showsTeam');
    blog('isVerified : $isVerified');
    blog('bzState : $bzState');
    blog('totalFollowers : $totalFollowers');
    blog('totalSaves : $totalSaves');
    blog('totalShares : $totalShares');
    blog('totalSlides : $totalSlides');
    blog('totalViews : $totalViews');
    blog('totalCalls : $totalCalls');
    blog('flyersIDs : $flyersIDs');
    blog('totalFlyers : $totalFlyers');

    blog('$_methodName : PRINTING BZ MODEL ---------------- END -- ');
  }
// -----------------------------------------------------------------------------
  static void blogBzz({
    @required List<BzModel> bzz,
    String methodName,
  }){

    if (Mapper.canLoopList(bzz)){

      for (final BzModel bz in bzz){
        bz.blogBz(methodName: methodName);
      }

    }

  }
// -----------------------------------------------------------------------------
  static const List<String> bzPagesTabsTitles = <String>[
    'Flyers',
    'About',
    'Targets',
    'Powers'
  ];
// -----------------------------------------------------------------------------
  static bool bzzContainThisBz({List<BzModel> bzz, BzModel bzModel}) {
    bool _contains = false;

    if (Mapper.canLoopList(bzz) && bzModel != null) {
      for (final BzModel bz in bzz) {
        if (bz.id == bzModel.id) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
// -----------------------------------------------------------------------------
  static List<String> getBzzIDsFromBzz(List<BzModel> bzzModels) {
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(bzzModels)) {
      for (final BzModel bz in bzzModels) {
        _ids.add(bz.id);
      }
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
  static BzModel dummyBz(String bzID) {
    final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';

    return BzModel(
      id: _bzID,
      logo: Iconz
          .dumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
      name: 'Business Name',
      trigram: TextGen.createTrigram(input: 'Business Name'),
      bzType: BzType.designer,
      zone: ZoneModel.dummyZone(),
      totalFollowers: 1000,
      totalFlyers: 10,
      bzState: BzState.online,
      position: Atlas.dummyPosition(),
      flyersIDs: <String>[],
      authors: <AuthorModel>[],
      contacts: <ContactModel>[],
      bzForm: BzForm.company,
      accountType: BzAccountType.normal,
      createdAt: Timers.createDate(year: 1987, month: 10, day: 06),
      about: 'About biz',
      isVerified: true,
      scope: 'Scope of Bz',
      showsTeam: true,
      totalCalls: 1,
      totalSaves: 2,
      totalShares: 3,
      totalSlides: 4,
      totalViews: 5,
    );
  }
// -----------------------------------------------------------------------------
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
