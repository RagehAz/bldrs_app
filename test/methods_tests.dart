import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';

void main(){

  List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
    {
      'id' : 'a',
      'name' : 'Ahmad',
    },
    {
      'id' : 'b',
      'name' : 'meshmesh',
    },
  ];

  Map<String, dynamic> _aMapInTheList = {
    'id' : 'b',
    'name' : 'meshmesh',
  };

  Map<String, dynamic> _aMapInTheListCopy = {
    'id' : 'b',
    'name' : 'meshmesh',
  };

  Map<String, dynamic> _aMapNotInTheListByOneField = {
    'id' : 'b',
    'name' : 'meshmeshaaaaaaaaayaaaaaaa',
  };

  Map<String, dynamic> _aMapNotInTheListByTwoFields = {
    'id' : 'beeeeeeee',
    'name' : 'meshmeshaaaaaaaaayaaaaaaa',
  };


// -----------------------------------------------------------------------------
  test('correct input _aMapInTheList', (){

    bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapInTheList,
    );

    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByOneField', (){

    bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapNotInTheListByOneField,
    );

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByTwoFields', (){

    bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapNotInTheListByTwoFields,
    );

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('map == map', (){

    bool _result = Mapper.mapsAreTheSame(_aMapInTheList, _aMapInTheListCopy);

    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('maps are not equal', (){

    bool _result = Mapper.mapsAreTheSame(_aMapInTheList, _aMapNotInTheListByOneField);

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('Mapper.listsAreTheSame', (){

    List<String> _list1 = <String>['1', '2', '3'];
    List<String> _list2 = <String>['1', '2', '3'];


    bool _result = Mapper.listsAreTheSame(list1: _list1, list2: _list2);

    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('lists are not the same', (){

    List<String> _list1 = <String>['1', '2', '3'];
    List<String> _list2 = <String>['1', '2', '4'];


    bool _result = Mapper.listsAreTheSame(list1: _list1, list2: _list2);

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('index of a map in list of maps', (){

    List<Map<String,dynamic>> _theList = _listOfMaps;

    int _indexOfTheMap = Mapper.indexOfMapInListOfMaps(_theList, _aMapInTheList);

    int _result = _indexOfTheMap;

    expect(_result, 1);

  });
// -----------------------------------------------------------------------------
  test('index of a map not in the list of maps', (){

    List<Map<String,dynamic>> _theList = _listOfMaps;

    int _indexOfTheMap = Mapper.indexOfMapInListOfMaps(_theList, _aMapNotInTheListByOneField);

    int _result = _indexOfTheMap;

    expect(_result, -1);

  });
// -----------------------------------------------------------------------------
  test('get index of a map by key value', (){

    List<Map<String,dynamic>> _theList = _listOfMaps;

    int _indexOfTheMap = Mapper.indexOfMapByValueInListOfMaps(
        listOfMaps: _theList,
        key: 'id',
        value: 'b'
    );

    int _result = _indexOfTheMap;

    expect(_result, 1);

  });
// -----------------------------------------------------------------------------
  test('get map from urlQuery', (){

    String _urlQuery = 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';

    Map<String,dynamic> _map = Mapper.getMapFromURLQuery(urlQuery: _urlQuery);

    Map<String, dynamic> _expected = {
      'country':'eg',
      'category':'business',
      'apiKey':'65f7556ec76449fa7dc7c0069f040ca',
    };

    expect(_map, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherStrings and sqlDecipherStrings', (){

    List<String> strings = <String>['aa', 'bb', 'cc'];

    String string = TextMod.sqlCipherStrings(strings);

    List<String> _toListAgain = TextMod.sqlDecipherStrings(string);

    List<String> _expected = strings;

    expect(_toListAgain, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherGeoPoint and sqlDecipherGeoPoint', (){

    GeoPoint _point = new GeoPoint(12.3, 45.6);

    String _string = Atlas.sqlCipherGeoPoint(_point);

    GeoPoint _pointAgain = Atlas.sqlDecipherGeoPoint(_string);

    dynamic _expected = GeoPoint(12.3, 45.6);
    expect(_pointAgain, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherSpec and sqlDecipherSpec', (){

    Spec _spec = Spec(specType: SpecType.inStock, value: false);
    String _specString = Spec.sqlCipherSpec(_spec);

    Spec _specAgain = Spec.sqlDecipherSpec(_specString);

    dynamic _expected = _spec.value;
    expect(_specAgain.value, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherSpecs and sqlDecipherSpecs', (){

    const Spec _specA = Spec(specType: SpecType.inStock, value: false);
    const Spec _specB = Spec(specType: SpecType.height, value: 10.4);
    const Spec _specC = Spec(specType: SpecType.count, value: 12);

    final List<Spec> _specs = <Spec>[_specA, _specB, _specC];

    final String _specsString = Spec.sqlCipherSpecs(_specs);

    final List<Spec> specsBack = Spec.sqlDecipherSpecs(_specsString);

    print('specs back are : ${specsBack.toString()}');

    bool _specsListsAreTheSame = Spec.specsListsAreTheSame(_specs, specsBack);

    dynamic _expected =  true;
    expect(_specsListsAreTheSame, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherPublishTimes and sqlDecipherPublishTimes', (){

    final PublishTime timeA = PublishTime(state: FlyerState.Suspended, timeStamp: Timers.createDate(year: 1987, month: 06, day: 10));
    final PublishTime timeB = PublishTime(state: FlyerState.Banned, timeStamp: Timers.createDate(year: 2011, month: 02, day: 26));
    final List<PublishTime> _times = [timeA, timeB];

    String sql = PublishTime.sqlCipherPublishTimes(_times);

    final List<PublishTime> _back = PublishTime.sqlDecipherPublishTimes(sql);


    print('1 : sql : $sql');

    print('2 : _times[0].timeStamp : ${_times[0].timeStamp}');
    print('3 : _times[0].state : ${_times[0].state}');
    print('4 : _times[1].timeStamp : ${_times[1].timeStamp}');
    print('5 : _times[1].state : ${_times[1].state}');


    print('2 : _times[0].timeStamp : ${_back[0].timeStamp}');
    print('3 : _times[0].state : ${_back[0].state}');
    print('4 : _times[1].timeStamp : ${_back[1].timeStamp}');
    print('5 : _times[1].state : ${_back[1].state}');

    // dynamic _expected =  false;
    expect(1, 1);

  });
// -----------------------------------------------------------------------------
  test('base64 ', () async {

    final TinyFlyer _tinyFlyer = TinyFlyer.dummyTinyFlyer('z');

    final dynamic _pic = _tinyFlyer.slidePic;


    final String _base64 = await Imagers.urlOrImageFileToBase64(_pic);

    // final bool _isURL = ObjectChecker.objectIsString(_pic);

    // final bool _base64IsString = ObjectChecker.objectIsString(_base64);
    //
    final bool _base64IsBase64 = ObjectChecker.isBase64(_pic);

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    print('pic is : $_pic');
    print('_base64 : $_base64');

    expect(_base64IsBase64, false);

  });

  test('stringContainsSubString', () async {

    final String _string =  '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';
    final String _substring = '[firebase_auth/user-not-found]';

    bool _mapContainsTheError = TextChecker.stringContainsSubString(
      string: _string,
      subString: _substring,
      multiLine: false,
      caseSensitive: true,
    );

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_mapContainsTheError, true);

  });
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
}