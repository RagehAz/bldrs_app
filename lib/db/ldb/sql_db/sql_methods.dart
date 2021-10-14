

import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/ldb/sql_db/sql_column.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';

class SQLMethods{
// -----------------------------------------------------------------------------
  static String sqlCipherPublishTime(PublishTime time){
    String _output;

    if (time != null){
      final String _state = '${FlyerModel.cipherFlyerState(time.state)}';
      final String _timeString = Timers.cipherTime(time: time.time, toJSON: true);

      _output = '${_state}#${_timeString}';
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static PublishTime sqlDecipherPublishTime(String sqkTimeString){
    PublishTime time;

    if (sqkTimeString != null){
      final String _stateString = TextMod.trimTextAfterFirstSpecialCharacter(sqkTimeString, '#');
      // final int _stateInt = Numeric.stringToInt(_stateString);
      final FlyerState _state = FlyerModel.decipherFlyerState(_stateString);
      final String _timeString = TextMod.trimTextBeforeFirstSpecialCharacter(sqkTimeString, '#');
      final DateTime _time = Timers.decipherTime(time: _timeString, fromJSON: true);

      time = PublishTime(
        state: _state,
        time: _time,
      );

    }

    return time;
  }
// -----------------------------------------------------------------------------
  static String sqlCipherPublishTimes(List<PublishTime> times){
    String _output;

    if (Mapper.canLoopList(times)){

      final List<String> _sqlTimesStrings = <String>[];

      for (PublishTime time in times){
        final _sqlString = sqlCipherPublishTime(time);
        _sqlTimesStrings.add(_sqlString);
      }

      _output = TextMod.sqlCipherStrings(_sqlTimesStrings);

    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static List<PublishTime> sqlDecipherPublishTimes(String timesString){
    final List<PublishTime> _times = <PublishTime>[];

    if (timesString != null){

      List<String> _sqlStrings = TextMod.sqlDecipherStrings(timesString);

      for (String sqlString in _sqlStrings){
        final PublishTime _time = sqlDecipherPublishTime(sqlString);
        _times.add(_time);
      }

    }

    return _times;
  }
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
      SQLColumn(key: 'zone_countryID', type: 'TEXT'),
      SQLColumn(key: 'zone_cityID', type: 'TEXT'),
      SQLColumn(key: 'zone_districtID', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'about', type: 'TEXT'),
      SQLColumn(key: 'position', type: 'TEXT'),
      SQLColumn(key: 'contacts', type: 'TEXT'),
      // LDBColumn(key: 'bzAuthors', type: 'TEXT'), // separated in separate LDB
      SQLColumn(key: 'showsTeam', type: 'INTEGER'),
      // -------------------------
      SQLColumn(key: 'isVerified', type: 'INTEGER'),
      SQLColumn(key: 'bzState', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'totalFollowers', type: 'INTEGER'),
      SQLColumn(key: 'totalSaves', type: 'INTEGER'),
      SQLColumn(key: 'totalShares', type: 'INTEGER'),
      SQLColumn(key: 'totalSlides', type: 'INTEGER'),
      SQLColumn(key: 'totalViews', type: 'INTEGER'),
      SQLColumn(key: 'totalCalls', type: 'INTEGER'),
      SQLColumn(key: 'totalFlyers', type: 'INTEGER'),
      // -------------------------
      SQLColumn(key: 'flyersIDs', type: 'TEXT'),
    ];

    return _columns;


  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> sqlCipherBz(BzModel bz) async {
    Map<String, Object> _map;

    if (bz != null) {
      _map = {
        'bzID': bz.bzID,
        'bzType' : BzModel.cipherBzType(bz.bzType),
        'bzForm' : BzModel.cipherBzForm(bz.bzForm),
        'createdAt' : Timers.cipherTime(time: bz.createdAt, toJSON: true),
        'accountType' : BzModel.cipherBzAccountType(bz.accountType),
        'name' : bz.name,
        'logo' : await Imagers.urlOrImageFileToBase64(bz.logo),
        'scope' : bz.scope,
        'zone_countryID' : bz.zone.countryID,
        'zone_cityID' : bz.zone.cityID,
        'zone_districtID' : bz.zone.districtID,
        'about' : bz.about,
        'position' : Atlas.cipherGeoPoint(point: bz.position, toJSON: true),
        'contacts' : ContactModel.sqlCipherContacts(bz.contacts),
        'showsTeam' : Numeric.sqlCipherBool(bz.showsTeam),
        'isVerified' : Numeric.sqlCipherBool(bz.isVerified),
        'bzState' : BzModel.cipherBzState(bz.bzState),
        'totalFollowers' : bz.totalFollowers,
        'totalSaves' : bz.totalSaves,
        'totalShares' : bz.totalShares,
        'totalSlides' : bz.totalSlides,
        'totalViews' : bz.totalViews,
        'totalCalls' : bz.totalCalls,
        'totalFlyers' : bz.totalFlyers,
        'flyersIDs' : TextMod.sqlCipherStrings(bz.flyersIDs),

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
        bzType : BzModel.decipherBzType(map['bzType']),
        bzForm : BzModel.decipherBzForm(map['bzForm']),
        createdAt : Timers.decipherTime(time: map['createdAt'], fromJSON: true),
        accountType : BzModel.decipherBzAccountType(map['accountType']),
        // -------------------------
        name : map['name'],
        logo : await Imagers.base64ToFile(map['logo']),
        scope : map['scope'],
        zone : Zone(
          countryID: map['zone_countryID'],
          cityID: map['zone_cityID'],
          districtID: map['zone_districtID'],
        ),
        about : map['about'],
        position : Atlas.decipherGeoPoint(point: map['position'], fromJSON: true),
        contacts : ContactModel.sqlDecipherContacts(map['contacts']),
        authors : authors,
        showsTeam : Numeric.sqlDecipherBool(map['showsTeam']),
        // -------------------------
        isVerified : Numeric.sqlDecipherBool(map['isVerified']),
        bzState : BzModel.decipherBzState(map['bzState']),
        // -------------------------
        totalFollowers : map['totalFollowers'],
        totalSaves : map['totalSaves'],
        totalShares : map['totalShares'],
        totalSlides : map['totalSlides'],
        totalViews : map['totalViews'],
        totalCalls : map['totalCalls'],
        totalFlyers: map['totalFlyers'],
        // -------------------------
        flyersIDs: TextMod.sqlDecipherStrings(map['flyersIDs']),
      );

    }

    return _bz;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> sqlCipherBzz(List<BzModel> bzz) async {
    List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (Mapper.canLoopList(bzz)){

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

    if (Mapper.canLoopList(maps)){

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
  static List<SQLColumn> createFlyersLDBColumns(){

    const List<SQLColumn> _columns = const <SQLColumn>[
      // -------------------------
      SQLColumn(key: 'flyerID', type: 'TEXT', isPrimary: true),
      SQLColumn(key: 'numberOfSlides', type: 'INTEGER'),
      SQLColumn(key: 'flyerType', type: 'INTEGER'),
      SQLColumn(key: 'flyerState', type: 'INTEGER'),
      SQLColumn(key: 'keywords', type: 'TEXT'),
      SQLColumn(key: 'flyerShowsAuthor', type: 'INTEGER'),
      // -------------------------
      SQLColumn(key: 'zone_countryID', type: 'TEXT'),
      SQLColumn(key: 'zone_cityID', type: 'TEXT'),
      SQLColumn(key: 'zone_districtID', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'authorID', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'bzID', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'createdAt', type: 'TEXT'),
      SQLColumn(key: 'flyerPosition', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'ankhIsOn', type: 'INTEGER'),
      // -------------------------
      SQLColumn(key: 'flyerIsBanned', type: 'INTEGER'),
      SQLColumn(key: 'deletionTime', type: 'TEXT'),
      SQLColumn(key: 'specs', type: 'TEXT'),
      SQLColumn(key: 'info', type: 'TEXT'),
      SQLColumn(key: 'times', type: 'TEXT'),
      SQLColumn(key: 'priceTagIsOn', type: 'INTEGER'),

    ];

    return _columns;
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> sqlCipherFlyer(FlyerModel flyer) async {

    final Map<String, Object> _flyerSQLMap = {

      'flyerID' : flyer.flyerID,
      'numberOfSlides' : flyer.slides.length,

      'flyerType' : FlyerTypeClass.cipherFlyerType(flyer.flyerType),
      'flyerState' : FlyerModel.cipherFlyerState(flyer.flyerState),
      'keywords' : TextMod.sqlCipherStrings(flyer.keywordsIDs),
      'flyerShowsAuthor' : Numeric.sqlCipherBool(flyer.showsAuthor),

      'zone_countryID' : flyer.zone.countryID,
      'zone_cityID' : flyer.zone.cityID,
      'zone_districtID' : flyer.zone.districtID,

      'authorID' : flyer.authorID,

      'bzID' : flyer.bzID,

      'flyerPosition' : Atlas.cipherGeoPoint(point : flyer.position, toJSON: true),
      // 'numberOfSlides' : flyer.slides.length,
      'flyerIsBanned' : Numeric.sqlCipherBool(flyer.isBanned),
      'specs' : Spec.sqlCipherSpecs(flyer.specs),
      'info' : flyer.info,
      'times' : PublishTime.cipherPublishTimesToMap(times: flyer.times, toJSON: true),
      'priceTagIsOn' : Numeric.sqlCipherBool(flyer.priceTagIsOn),
    };

    return _flyerSQLMap;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> sqlCipherFlyers(List<FlyerModel> flyers) async {
    final List<Map<String, Object>> _maps = <Map<String, Object>>[];

    if (Mapper.canLoopList(flyers)){

      for (FlyerModel flyer in flyers){

        final Map<String, Object> _map = await sqlCipherFlyer(flyer);
        _maps.add(_map);
      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<FlyerModel> sqlDecipherFlyer({Map<String, Object> flyerMap, List<SlideModel> slides}) async {
    FlyerModel _flyer;

    if (flyerMap != null && Mapper.canLoopList(slides)){

      _flyer = FlyerModel(
        flyerID: flyerMap['flyerID'],
        flyerType: FlyerTypeClass.decipherFlyerType(flyerMap['flyerType']),
        flyerState: FlyerModel.decipherFlyerState(flyerMap['flyerState']),
        keywordsIDs: TextMod.sqlDecipherStrings(flyerMap['keywordsIDs']),
        showsAuthor: Numeric.sqlDecipherBool(flyerMap['flyerShowsAuthor']),

        zone: Zone(
          countryID: flyerMap['zone_countryID'],
          cityID: flyerMap['zone_cityID'],
          districtID: flyerMap['zone_districtID'],
        ),

        authorID: flyerMap['authorID'],

        bzID: flyerMap['bzID'],

        position: Atlas.decipherGeoPoint(point: flyerMap['flyerPosition'], fromJSON: true),
        slides: slides,
        isBanned: Numeric.sqlDecipherBool(flyerMap['flyerIsBanned']),
        specs: Spec.sqlDecipherSpecs(flyerMap['specs']),
        info: flyerMap['info'],
        times: PublishTime.decipherPublishTimesFromMap(map: flyerMap['times'], fromJSON: true),
        priceTagIsOn: Numeric.sqlDecipherBool(flyerMap['priceTagIsOn']),
      );

    }

    return _flyer;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> sqlDecipherFlyers({List<dynamic> sqlFlyersMaps, List<SlideModel> allSlides}) async {
    final List<FlyerModel> _allFlyers = <FlyerModel>[];

    if (Mapper.canLoopList(sqlFlyersMaps) && Mapper.canLoopList(allSlides)){

      for (var sqlFlyerMap in sqlFlyersMaps){

        final String _flyerID =  sqlFlyerMap['flyerID'];
        final List<SlideModel> _slides = SlideModel.getSlidesFromSlidesByFlyerID(allSlides, _flyerID);

        final FlyerModel _flyer = await sqlDecipherFlyer(
          flyerMap: sqlFlyerMap,
          slides: _slides,
        );

        _allFlyers.add(_flyer);

      }

    }

    return _allFlyers;
  }
// -----------------------------------------------------------------------------
  static List<SQLColumn> createAuthorsLDBColumns(){

    const List<SQLColumn> _authorsColumns = const <SQLColumn>[
      SQLColumn(key: 'userID', type: 'TEXT', isPrimary: true),
      SQLColumn(key: 'authorName', type: 'TEXT'),
      SQLColumn(key: 'authorPic', type: 'TEXT'),
      SQLColumn(key: 'authorTitle', type: 'TEXT'),
      SQLColumn(key: 'authorIsMaster', type: 'INTEGER'),
      SQLColumn(key: 'authorContacts', type: 'TEXT'),
    ];

    return _authorsColumns;
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> sqlCipherAuthor({AuthorModel author}) async {

    final Map<String, Object> _authorSQLMap = {
      'userID' : author.userID,
      'authorName' : author.name,
      'authorPic' : await Imagers.urlOrImageFileToBase64(author.pic),
      'authorTitle' : author.title,
      'authorIsMaster' : Numeric.sqlCipherBool(author.isMaster),
      'authorContacts' : ContactModel.sqlCipherContacts(author.contacts),
    };

    return _authorSQLMap;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> sqlCipherAuthors({List<AuthorModel> authors}) async {
    List<Map<String, Object>> _authorsMaps = <Map<String, Object>>[];

    if (Mapper.canLoopList(authors)){

      for (AuthorModel author in authors){

        final Map<String, Object> _sqlAuthorMap = await sqlCipherAuthor(
          author: author,
        );

        _authorsMaps.add(_sqlAuthorMap);

      }

    }

    return _authorsMaps;
  }
// -----------------------------------------------------------------------------
  static Future<AuthorModel> sqlDecipherAuthor({Map<String, Object> map}) async {
    AuthorModel _author;

    if (map != null){

      _author = AuthorModel(
        userID : map['userID'],
        name : map['authorName'],
        pic : await Imagers.base64ToFile(map['authorPic']),
        title : map['authorTitle'],
        isMaster : Numeric.sqlDecipherBool(map['authorIsMaster']),
        contacts : ContactModel.sqlDecipherContacts(map['authorContacts']),
      );

    }

    return _author;
  }
// -----------------------------------------------------------------------------
  static Future<List<AuthorModel>> sqlDecipherAuthors({List<Map<String, Object>> maps}) async {
    List<AuthorModel> _authors = <AuthorModel>[];

    if (Mapper.canLoopList(maps)){

      for (var map in maps){

        final AuthorModel _author = await sqlDecipherAuthor(map: map);

        _authors.add(_author);

      }

    }

    return _authors;
  }
// -----------------------------------------------------------------------------
}