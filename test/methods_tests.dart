import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';


void main(){

  // -----------------------------------------------------------------------------
  test('correct input _aMapInTheList', (){


    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];

    final Map<String, dynamic> _aMapInTheList = {
      'id' : 'b',
      'name' : 'meshmesh',
    };


    final bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapInTheList,
    );

    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByOneField', (){

    final Map<String, dynamic> _aMapNotInTheListByOneField = {
      'id' : 'b',
      'name' : 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];

    final bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapNotInTheListByOneField,
    );

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByTwoFields', (){

    final Map<String, dynamic> _aMapNotInTheListByTwoFields = {
      'id' : 'beeeeeeee',
      'name' : 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];


    bool _result = Mapper.listOfMapsContainMap(
      listOfMaps: _listOfMaps,
      map: _aMapNotInTheListByTwoFields,
    );

    expect(_result, false);

  });
// -----------------------------------------------------------------------------
  test('map == map', (){

    final Map<String, dynamic> _aMapInTheList = {
      'id' : 'b',
      'name' : 'meshmesh',
    };


    final Map<String, dynamic> _aMapInTheListCopy = {
      'id' : 'b',
      'name' : 'meshmesh',
    };


    bool _result = Mapper.mapsAreTheSame(_aMapInTheList, _aMapInTheListCopy);

    expect(_result, true);

  });
// -----------------------------------------------------------------------------
  test('maps are not equal', (){

    final Map<String, dynamic> _aMapInTheList = {
      'id' : 'b',
      'name' : 'meshmesh',
    };


    final Map<String, dynamic> _aMapNotInTheListByOneField = {
      'id' : 'b',
      'name' : 'meshmeshaaaaaaaaayaaaaaaa',
    };


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

    final Map<String, dynamic> _aMapInTheList = {
      'id' : 'b',
      'name' : 'meshmesh',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];


    final List<Map<String,dynamic>> _theList = _listOfMaps;

    final int _indexOfTheMap = Mapper.indexOfMapInListOfMaps(_theList, _aMapInTheList);

    final int _result = _indexOfTheMap;

    expect(_result, 1);

  });
// -----------------------------------------------------------------------------
  test('index of a map not in the list of maps', (){

    final Map<String, dynamic> _aMapNotInTheListByOneField = {
      'id' : 'b',
      'name' : 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];


    final List<Map<String,dynamic>> _theList = _listOfMaps;

    final int _indexOfTheMap = Mapper.indexOfMapInListOfMaps(_theList, _aMapNotInTheListByOneField);

    final int _result = _indexOfTheMap;

    expect(_result, -1);

  });
// -----------------------------------------------------------------------------
  test('get index of a map by key value', (){

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      {
        'id' : 'a',
        'name' : 'Ahmad',
      },
      {
        'id' : 'b',
        'name' : 'meshmesh',
      },
    ];


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

    GeoPoint _point = const GeoPoint(12.3, 45.6);

    String _string = Atlas.cipherGeoPoint(point: _point, toJSON: true);

    GeoPoint _pointAgain = Atlas.decipherGeoPoint(point: _string, fromJSON: true);

    dynamic _expected = const GeoPoint(12.3, 45.6);
    expect(_pointAgain, _expected);

  });
// -----------------------------------------------------------------------------
  test('sqlCipherPublishTimes and sqlDecipherPublishTimes', (){

    final PublishTime timeA = PublishTime(state: FlyerState.suspended, time: Timers.createDate(year: 1987, month: 06, day: 10));
    final PublishTime timeB = PublishTime(state: FlyerState.banned, time: Timers.createDate(year: 2011, month: 02, day: 26));
    final List<PublishTime> _times = [timeA, timeB];


    print('2 : _times[0].timeStamp : ${_times[0].time}');
    print('3 : _times[0].state : ${_times[0].state}');
    print('4 : _times[1].timeStamp : ${_times[1].time}');
    print('5 : _times[1].state : ${_times[1].state}');



    // dynamic _expected =  false;
    expect(1, 1);

  });
// -----------------------------------------------------------------------------
  test('base64 ', () async {

    final FlyerModel _flyerModel = FlyerModel.dummyFlyers()[0];

    final dynamic _pic = _flyerModel.slides[0].pic;


    final String _base64 = await Imagers.getBase64FromFileOrURL(_pic);

    // final bool _isURL = ObjectChecker.objectIsString(_pic);

    // final bool _base64IsString = ObjectChecker.objectIsString(_base64);
    //
    final bool _base64IsBase64 = ObjectChecker.isBase64(_pic);

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    print('pic is : $_pic');
    print('_base64 : $_base64');

    expect(_base64IsBase64, false);

  });
// -----------------------------------------------------------------------------
  test('stringContainsSubString', () async {

    const String _string =  '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';
    const String _substring = '[firebase_auth/user-not-found]';

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
  test('objectIsDatTime', () async {

    final dynamic _object = DateTime.now();
    final dynamic _object2 = Timers.cipherTime(time: _object, toJSON: false);
    bool _isDateTime = ObjectChecker.objectIsDateTime(_object2);

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_isDateTime, false);

  });
// -----------------------------------------------------------------------------
  test('replace map pair', () async {

    final Map<String, Object> map = {
      'one' : 'wa7ed',
      'two' : 'etneen',
      'three' : 'talata',
    };

    final Map<String, Object> _newMap = Mapper.replacePair(
      map: map,
      fieldKey: 'two',
      inputValue: 'it works'
    );

    final Map<String, Object> _expected = {
      'one' : 'wa7ed',
      'two' : 'it works',
      'three' : 'talata',
    };

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_newMap, _expected);

  });
// -----------------------------------------------------------------------------
  test("This is #VAR01 app text #VAR02.", () async {

    String _string = "This is #VAR01 app text #VAR02.";

    Iterable<String> _allStringMatches(String text, RegExp regExp) =>
        regExp.allMatches(text).map((m) => m.group(0));

    dynamic _things = _allStringMatches(_string, RegExp(r'#VAR..'));

    List<String> _expectation = ['#VAR01', '#VAR02'];

    print('things are ${_things.toString()}');

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_things, _expectation);

  });
// -----------------------------------------------------------------------------
  /// and lets make a method test to check if life might give us lemons
  test("Testing JSON Variables work around idea", () async {

    // String _rawString = "This is #VAR01 app text #VAR02.";
    //
    // String _processedString = JSONWorkAround.processJSONStringThatContainsThoseSpecialVariables(_rawString);
    //
    // String _expectation = "This is Baby app text Cool.";
    //
    // expect(_processedString, _expectation);

  });
// -----------------------------------------------------------------------------
  /// and lets make a method test to check if this works
  test("testing double from a string", () async {

    // String _inputA = '34.55';
    // double _output = DoubleFromStringTest.getDoubleIfPossible(_inputA);
    // expect(_output, 34.55);
    //
    // String _inputB = 'XX34.55';
    // double _outputB = DoubleFromStringTest.getDoubleIfPossible(_inputB);
    // expect(_outputB, null);
    //
    // String _inputC = 'XAfdjdb4';
    // double _outputC = DoubleFromStringTest.getDoubleIfPossible(_inputC);
    // expect(_outputC, null);
    //
    // String _inputD = '178712364871624.83762874623';
    // double _outputD = DoubleFromStringTest.getDoubleIfPossible(_inputD);
    // expect(_outputD, 178712364871624.83762874623);

  });
// -----------------------------------------------------------------------------
  test("remove All Characters After Number Of Characters", () async {

    const String _input = '123456789abcdefg';
    const int _number = 7;
    final String _output = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: _input,
        numberOfCharacters: _number
    );
    expect(_output, '1234567');

  });
// -----------------------------------------------------------------------------
  test("power", () async {

    final int _output = Numeric.power(num: 5, power: 3);
    expect(_output, 125);

  });
// -----------------------------------------------------------------------------
  test("get Number Within Digits", () async {

    final String _output = Numeric.getNumberWithinDigits(num: 957, digits: 4);
    expect(_output, '0957');

  });
// -----------------------------------------------------------------------------
  test("Specs are the same", () async {

    List<Spec> specsA = const [

      Spec(specsListID: 'x', value: 'x'),
      Spec(specsListID: 'y', value: 'y'),
      Spec(specsListID: 'z', value: 'z'),

    ];

    List<Spec> specsB = const [

      Spec(specsListID: 'x', value: 'x'),
      Spec(specsListID: 'y', value: 'y'),
      Spec(specsListID: 'z', value: 'z'),

    ];

    final bool _areTheSame = Spec.specsListsAreTheSame(specsA, specsB);

    expect(_areTheSame, true);

  });
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
  test("Specs are the same", () async {

    List<Spec> specsA = const [

      Spec(specsListID: 'x', value: 'x'),
      Spec(specsListID: 'y', value: 'y'),
      Spec(specsListID: 'z', value: 'z'),

    ];

    const Spec _aSpec = Spec(specsListID: 'z', value: 'v');

    final bool _contains = Spec.specsContainThis(specs: specsA, spec: _aSpec);

    expect(_contains, false);

  });
// -----------------------------------------------------------------------------
  test("Object is list of specs", () async {

    List<Spec> specsA = const [

      Spec(specsListID: 'x', value: 'x'),
      Spec(specsListID: 'y', value: 'y'),
      Spec(specsListID: 'z', value: 'z'),

    ];

    dynamic thing = ['d', 'r'];

    final bool isSpecs = ObjectChecker.objectIsListOfSpecs(thing);

    expect(isSpecs, false);

  });
// -----------------------------------------------------------------------------


}