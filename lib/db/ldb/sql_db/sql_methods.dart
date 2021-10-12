

import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/ldb/sql_db/sql_column.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/user/user_model.dart';
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
        'bzType' : BzModel.cipherBzType(bz.bzType),
        'bzForm' : BzModel.cipherBzForm(bz.bzForm),
        'createdAt' : Timers.cipherTime(time: bz.createdAt, toJSON: true),
        'accountType' : BzModel.cipherBzAccountType(bz.accountType),
        'bzName' : bz.bzName,
        'bzLogo' : await Imagers.urlOrImageFileToBase64(bz.bzLogo),
        'bzScope' : bz.bzScope,
        'bzZone_countryID' : bz.bzZone.countryID,
        'bzZone_cityID' : bz.bzZone.cityID,
        'bzZone_districtID' : bz.bzZone.districtID,
        'bzAbout' : bz.bzAbout,
        'bzPosition' : Atlas.cipherGeoPoint(point: bz.bzPosition, toJSON: true),
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
        bzType : BzModel.decipherBzType(map['bzType']),
        bzForm : BzModel.decipherBzForm(map['bzForm']),
        createdAt : Timers.decipherTime(time: map['createdAt'], fromJSON: true),
        accountType : BzModel.decipherBzAccountType(map['accountType']),
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
        bzPosition : Atlas.decipherGeoPoint(point: map['bzPosition'], fromJSON: true),
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
      SQLColumn(key: 'tinyAuthor_userID', type: 'TEXT'),
      SQLColumn(key: 'tinyAuthor_name', type: 'TEXT'),
      SQLColumn(key: 'tinyAuthor_title', type: 'TEXT'),
      SQLColumn(key: 'tinyAuthor_pic', type: 'TEXT'), // or BLOB if we use Uint8List
      SQLColumn(key: 'tinyAuthor_userStatus', type: 'INTEGER'),
      SQLColumn(key: 'tinyAuthor_email', type: 'TEXT'),
      SQLColumn(key: 'tinyAuthor_phone', type: 'TEXT'),
      // -------------------------
      SQLColumn(key: 'tinyBz_bzID', type: 'TEXT'),
      SQLColumn(key: 'tinyBz_bzLogo', type: 'TEXT'), // or BLOB if we use Uint8List
      SQLColumn(key: 'tinyBz_bzName', type: 'TEXT'),
      SQLColumn(key: 'tinyBz_bzType', type: 'INTEGER'),
      SQLColumn(key: 'tinyBz_bzZone_countryID', type: 'TEXT'),
      SQLColumn(key: 'tinyBz_bzZone_cityID', type: 'TEXT'),
      SQLColumn(key: 'tinyBz_bzZone_districtID', type: 'TEXT'),
      SQLColumn(key: 'tinyBz_bzTotalFollowers', type: 'INTEGER'),
      SQLColumn(key: 'tinyBz_bzTotalFlyers', type: 'INTEGER'),
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
      'flyerShowsAuthor' : Numeric.sqlCipherBool(flyer.flyerShowsAuthor),

      'zone_countryID' : flyer.flyerZone.countryID,
      'zone_cityID' : flyer.flyerZone.cityID,
      'zone_districtID' : flyer.flyerZone.districtID,

      'tinyAuthor_userID' : flyer.tinyAuthor.userID,
      'tinyAuthor_name' : flyer.tinyAuthor.name,
      'tinyAuthor_title' : flyer.tinyAuthor.title,
      'tinyAuthor_pic' : await Imagers.urlOrImageFileToBase64(flyer.tinyAuthor.pic),
      'tinyAuthor_userStatus' : UserModel.cipherUserStatus(flyer.tinyAuthor.userStatus),
      'tinyAuthor_email' : flyer.tinyAuthor.email,
      'tinyAuthor_phone' : flyer.tinyAuthor.phone,

      'tinyBz_bzID' : flyer.tinyBz.bzID,
      'tinyBz_bzLogo' : await Imagers.urlOrImageFileToBase64(flyer.tinyBz.bzLogo),
      'tinyBz_bzName' : flyer.tinyBz.bzName,
      'tinyBz_bzType' : BzModel.cipherBzType(flyer.tinyBz.bzType),
      'tinyBz_bzZone_countryID' : flyer.tinyBz.bzZone.countryID,
      'tinyBz_bzZone_cityID' : flyer.tinyBz.bzZone.cityID,
      'tinyBz_bzZone_districtID' : flyer.tinyBz.bzZone.districtID,
      'tinyBz_bzTotalFollowers' : flyer.tinyBz.bzTotalFollowers,
      'tinyBz_bzTotalFlyers' : flyer.tinyBz.bzTotalFlyers,

      'flyerPosition' : Atlas.cipherGeoPoint(point : flyer.flyerPosition, toJSON: true),
      // 'numberOfSlides' : flyer.slides.length,
      'flyerIsBanned' : Numeric.sqlCipherBool(flyer.flyerIsBanned),
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
        flyerShowsAuthor: Numeric.sqlDecipherBool(flyerMap['flyerShowsAuthor']),

        flyerZone: Zone(
          countryID: flyerMap['zone_countryID'],
          cityID: flyerMap['zone_cityID'],
          districtID: flyerMap['zone_districtID'],
        ),

        tinyAuthor: TinyUser(
          userID:  flyerMap['tinyAuthor_userID'],
          name: flyerMap['tinyAuthor_name'],
          title: flyerMap['tinyAuthor_title'],
          pic: await Imagers.base64ToFile(flyerMap['tinyAuthor_pic']),
          userStatus: UserModel.decipherUserStatus(flyerMap['tinyAuthor_userStatus']),
          email: flyerMap['tinyAuthor_email'],
          phone: flyerMap['tinyAuthor_phone'],
        ),

        tinyBz: TinyBz(
          bzID: flyerMap['tinyBz_bzID'],
          bzLogo: await Imagers.base64ToFile(flyerMap['tinyBz_bzLogo']),
          bzName: flyerMap['tinyBz_bzName'],
          bzType: BzModel.decipherBzType(flyerMap['tinyBz_bzType']),
          bzZone: Zone(
            countryID: flyerMap['tinyBz_bzZone_countryID'],
            cityID: flyerMap['tinyBz_bzZone_cityID'],
            districtID: flyerMap['tinyBz_bzZone_districtID'],
          ),
          bzTotalFollowers: flyerMap['tinyBz_bzTotalFollowers'],
          bzTotalFlyers: flyerMap['tinyBz_bzTotalFlyers'],
        ),

        flyerPosition: Atlas.decipherGeoPoint(point: flyerMap['flyerPosition'], fromJSON: true),
        slides: slides,
        flyerIsBanned: Numeric.sqlDecipherBool(flyerMap['flyerIsBanned']),
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

}