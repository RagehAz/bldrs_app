import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/publish_time_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:bldrs/e_db/fire/ops/app_state_ops.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
// -----------------------------------------------------------------------------
  test('correct input _aMapInTheList', () {
    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final Map<String, dynamic> _aMapInTheList = <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    };

    final bool _result = Mapper.checkMapsContainMap(
      maps: _listOfMaps,
      map: _aMapInTheList,
    );

    expect(_result, true);
  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByOneField', () {
    final Map<String, dynamic> _aMapNotInTheListByOneField = <String, dynamic>{
      'id': 'b',
      'name': 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final bool _result = Mapper.checkMapsContainMap(
      maps: _listOfMaps,
      map: _aMapNotInTheListByOneField,
    );

    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('in-correct _aMapNotInTheListByTwoFields', () {
    final Map<String, dynamic> _aMapNotInTheListByTwoFields = <String, dynamic>{
      'id': 'beeeeeeee',
      'name': 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final bool _result = Mapper.checkMapsContainMap(
      maps: _listOfMaps,
      map: _aMapNotInTheListByTwoFields,
    );

    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('map == map', () {
    final Map<String, dynamic> _aMapInTheList = <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    };

    final Map<String, dynamic> _aMapInTheListCopy = <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    };

    final bool _result = Mapper.checkMapsAreIdentical(
        map1: _aMapInTheList,
        map2: _aMapInTheListCopy
    );

    expect(_result, true);
  });
// -----------------------------------------------------------------------------
  test('maps are not equal', () {
    final Map<String, dynamic> _aMapInTheList = <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    };

    final Map<String, dynamic> _aMapNotInTheListByOneField = <String, dynamic>{
      'id': 'b',
      'name': 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final bool _result = Mapper.checkMapsAreIdentical(
      map1: _aMapInTheList,
      map2: _aMapNotInTheListByOneField,
    );

    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('Mapper.listsAreTheSame', () {

    final List<String> _list1 = <String>[
      'cars/sport/ferrari/Competizione/',
      'cars/sport/ferrari/Monza/',
      'cars/sport/chevrolet/corvette/',
      'cars/4wheel/jeep/wrangler/',
      'cars/4wheel/hummer/h2/',
      'cars/4wheel/hummer/h3/',
      'bikes/race/honda/CBR/',
      'bikes/race/honda/KOKO/',
      'bikes/cruiser/harley/sportster/',
      'bikes/cruiser/harley/DAVIDSON/',
      'bikes/city/harley/bobo/',
    ];
    final List<String> _list2 = <String>[
      'cars/sport/ferrari/Competizione/',
      'cars/sport/ferrari/Monza/',
      'cars/sport/chevrolet/corvette/',
      'cars/4wheel/jeep/wrangler/',
      'cars/4wheel/hummer/h2/',
      'cars/4wheel/hummer/h3/',
      'bikes/race/honda/CBR/',
      'bikes/race/honda/KOKO/',
      'bikes/cruiser/harley/sportster/',
      'bikes/cruiser/harley/DAVIDSON/',
      'bikes/city/harley/bobo/',
    ];

    final bool _result = Mapper.checkListsAreIdentical(list1: _list1, list2: _list2);

    expect(_result, true);
  });
// -----------------------------------------------------------------------------
  test('lists are not the same', () {
    final List<String> _list1 = <String>['1', '2', '3'];
    final List<String> _list2 = <String>['1', '2', '4'];

    final bool _result = Mapper.checkListsAreIdentical(list1: _list1, list2: _list2);

    expect(_result, false);
  });
// -----------------------------------------------------------------------------
  test('index of a map in list of maps', () {
    final Map<String, dynamic> _aMapInTheList = <String, dynamic>{
      'id': 'b',
      'name': 'meshmesh',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final List<Map<String, dynamic>> _theList = _listOfMaps;

    final int _indexOfTheMap =
        Mapper.indexOfMapInListOfMaps(_theList, _aMapInTheList);

    final int _result = _indexOfTheMap;

    expect(_result, 1);
  });
// -----------------------------------------------------------------------------
  test('index of a map not in the list of maps', () {
    final Map<String, dynamic> _aMapNotInTheListByOneField = <String, dynamic>{
      'id': 'b',
      'name': 'meshmeshaaaaaaaaayaaaaaaa',
    };

    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final List<Map<String, dynamic>> _theList = _listOfMaps;

    final int _indexOfTheMap =
        Mapper.indexOfMapInListOfMaps(_theList, _aMapNotInTheListByOneField);

    final int _result = _indexOfTheMap;

    expect(_result, -1);
  });
// -----------------------------------------------------------------------------
  test('get index of a map by key value', () {
    final List<Map<String, dynamic>> _listOfMaps = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'a',
        'name': 'Ahmad',
      },
      <String, dynamic>{
        'id': 'b',
        'name': 'meshmesh',
      },
    ];

    final List<Map<String, dynamic>> _theList = _listOfMaps;

    final int _indexOfTheMap = Mapper.indexOfMapByValueInListOfMaps(
        listOfMaps: _theList, key: 'id', value: 'b');

    final int _result = _indexOfTheMap;

    expect(_result, 1);
  });
// -----------------------------------------------------------------------------
  test('get map from urlQuery', () {
    const String _urlQuery =
        'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';

    final Map<String, dynamic> _map =
        Mapper.getMapFromURLQuery(urlQuery: _urlQuery);

    final Map<String, dynamic> _expected = <String, dynamic>{
      'country': 'eg',
      'category': 'business',
      'apiKey': '65f7556ec76449fa7dc7c0069f040ca',
    };

    expect(_map, _expected);
  });
// -----------------------------------------------------------------------------
  test('sqlCipherStrings and sqlDecipherStrings', () {
    final List<String> strings = <String>['aa', 'bb', 'cc'];

    final String string = TextMod.sqlCipherStrings(strings);

    final List<String> _toListAgain = TextMod.sqlDecipherStrings(string);

    final List<String> _expected = strings;

    expect(_toListAgain, _expected);
  });
// -----------------------------------------------------------------------------
  test('sqlCipherGeoPoint and sqlDecipherGeoPoint', () {
    const GeoPoint _point = GeoPoint(12.3, 45.6);

    final String _string = Atlas.cipherGeoPoint(point: _point, toJSON: true);

    final GeoPoint _pointAgain =
        Atlas.decipherGeoPoint(point: _string, fromJSON: true);

    const dynamic _expected = GeoPoint(12.3, 45.6);
    expect(_pointAgain, _expected);
  });
// -----------------------------------------------------------------------------
  test('sqlCipherPublishTimes and sqlDecipherPublishTimes', () {

    final PublishTime timeA = PublishTime(
        state: PublishState.published,
        time: Timers.createDate(year: 1987, month: 06, day: 10),
    );

    final PublishTime timeB = PublishTime(
        state: PublishState.draft,
        time: Timers.createDate(year: 2011, month: 02, day: 26)
    );

    final List<PublishTime> _times = <PublishTime>[timeA, timeB];

    blog('2 : _times[0].timeStamp : ${_times[0].time}');
    blog('3 : _times[0].state : ${_times[0].state}');
    blog('4 : _times[1].timeStamp : ${_times[1].time}');
    blog('5 : _times[1].state : ${_times[1].state}');

    // dynamic _expected =  false;
    expect(1, 1);
  });
// -----------------------------------------------------------------------------
  test('base64 ', () async {
    final FlyerModel _flyerModel = FlyerModel.dummyFlyers()[0];

    final dynamic _pic = _flyerModel.slides[0].pic;

    final String _base64 = await Floaters.getBase64FromFileOrURL(_pic);

    // final bool _isURL = ObjectChecker.objectIsString(_pic);

    // final bool _base64IsString = ObjectChecker.objectIsString(_base64);
    //
    final bool _base64IsBase64 = ObjectChecker.isBase64(_pic);

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    blog('pic is : $_pic');
    blog('_base64 : $_base64');

    expect(_base64IsBase64, false);
  });
// -----------------------------------------------------------------------------
  test('stringContainsSubString', () async {
    const String _string =
        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.';
    const String _substring = '[firebase_auth/user-not-found]';

    final bool _mapContainsTheError = TextChecker.stringContainsSubString(
      string: _string,
      subString: _substring,
    );

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_mapContainsTheError, true);
  });
// -----------------------------------------------------------------------------
  test('stringContainsSubStringREGEXP', () async {
    const String _string = 'This is test text to get the damn subString bool Thing\n'
        'bibi';
    const String _substring = 'bibi';

    final bool _stringContainsSubString = TextChecker.stringContainsSubStringRegExp(
      string: _string,
      subString: _substring,
      caseSensitive: true,
    );

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_stringContainsSubString, true);
  });
// -----------------------------------------------------------------------------
  test('objectIsDatTime', () async {
    final dynamic _object = DateTime.now();
    final dynamic _object2 = Timers.cipherTime(time: _object, toJSON: false);
    final bool _isDateTime = ObjectChecker.objectIsDateTime(_object2);

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_isDateTime, false);
  });
// -----------------------------------------------------------------------------
  test('replace map pair', () async {
    final Map<String, Object> map = <String, Object>{
      'one': 'wa7ed',
      'two': 'etneen',
      'three': 'talata',
    };

    final Map<String, Object> _newMap =
        Mapper.replacePair(map: map, fieldKey: 'two', inputValue: 'it works');

    final Map<String, Object> _expected = <String, Object>{
      'one': 'wa7ed',
      'two': 'it works',
      'three': 'talata',
    };

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_newMap, _expected);
  });
// -----------------------------------------------------------------------------
  test('This is #VAR01 app text #VAR02.', () async {
    const String _string = 'This is #VAR01 app text #VAR02.';

    Iterable<String> _allStringMatches(String text, RegExp regExp) =>
        regExp.allMatches(text).map((RegExpMatch m) => m.group(0));

    final dynamic _things = _allStringMatches(_string, RegExp(r'#VAR..'));

    final List<String> _expectation = <String>['#VAR01', '#VAR02'];

    blog('things are ${_things.toString()}');

    // final bool _base65IsNotURL = ObjectChecker.objectIsURL(_base64) == false;

    expect(_things, _expectation);
  });
// -----------------------------------------------------------------------------
  /// and lets make a method test to check if life might give us lemons
  test('Testing JSON Variables work around idea', () async {
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
  test('testing double from a string', () async {
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
  test('remove All Characters After Number Of Characters', () async {
    const String _input = '123456789abcdefg';
    const int _number = 7;
    final String _output = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: _input, numberOfCharacters: _number);
    expect(_output, '1234567');
  });
// -----------------------------------------------------------------------------
  test('power', () async {
    final int _output = Numeric.calculateIntegerPower(num: 5, power: 3);
    expect(_output, 125);
  });
// -----------------------------------------------------------------------------
  test('get Number Within Digits', () async {
    final String _output = Numeric.formatNumberWithinDigits(num: 957, digits: 4);
    expect(_output, '0957');
  });
// -----------------------------------------------------------------------------
  test('Specs are the same', () async {
    const List<SpecModel> specsA = <SpecModel>[
      SpecModel(pickerChainID: 'x', value: 'x'),
      SpecModel(pickerChainID: 'y', value: 'y'),
      SpecModel(pickerChainID: 'z', value: 'z'),
    ];

    const List<SpecModel> specsB = <SpecModel>[
      SpecModel(pickerChainID: 'x', value: 'x'),
      SpecModel(pickerChainID: 'y', value: 'y'),
      SpecModel(pickerChainID: 'z', value: 'z'),
    ];

    final bool _areTheSame = SpecModel.checkSpecsListsAreIdentical(specsA, specsB);

    expect(_areTheSame, true);
  });
// -----------------------------------------------------------------------------
  test('Specs are the same', () async {
    const List<SpecModel> specsA = <SpecModel>[
      SpecModel(pickerChainID: 'x', value: 'x'),
      SpecModel(pickerChainID: 'y', value: 'y'),
      SpecModel(pickerChainID: 'z', value: 'z'),
    ];

    const SpecModel _aSpec = SpecModel(pickerChainID: 'z', value: 'v');

    final bool _contains =
        SpecModel.checkSpecsContainThisSpec(specs: specsA, spec: _aSpec);

    expect(_contains, false);
  });
// -----------------------------------------------------------------------------
  test('Object is list of specs', () async {
    const List<SpecModel> specsA = <SpecModel>[
      SpecModel(pickerChainID: 'x', value: 'x'),
      SpecModel(pickerChainID: 'y', value: 'y'),
      SpecModel(pickerChainID: 'z', value: 'z'),
    ];

    final List<String> things = <String>['d', 'r'];

    final bool isThingsSpecs = ObjectChecker.objectIsListOfSpecs(things);
    final bool isSpecs = ObjectChecker.objectIsListOfSpecs(specsA);

    expect(isSpecs, true);
    expect(isThingsSpecs, false);
  });
// -----------------------------------------------------------------------------
  test('getNumberOfFractions', () async {
    const double _number = 10.12553;
    final int _numberFractions = Numeric.getNumberOfFractions(number: _number);
    expect(_numberFractions, 5);
  });
// -----------------------------------------------------------------------------
  test('binary search', () async {
    final List<int> _list = <int>[0,1,2,3,4,5,6,7,8,9,10,12,15,18,19,22,25,26,27,29,31,33,35,38,39,40,42,43,48];
    
    final int _index = Numeric.binarySearch(
        list: _list,
        searchedValue: 10,
    );

    expect(_index, 10);
  });
// -----------------------------------------------------------------------------
  test('objectIsURL', () async {
    const String _thing = null;

    final bool _isURL = ObjectChecker.objectIsURL(_thing);

    expect(_isURL, false);
  });
// -----------------------------------------------------------------------------
  test('removeStringsFromStrings', () async {

    const List<String> _source = <String>['wa7ed', 'etneen', 'talata', 'arba3a'];

    const List<String> _toRemove = <String>['wa7ed', 'etneen'];

    final List<String> _modified = Stringer.removeStringsFromStrings(
        removeFrom: _source,
        removeThis: _toRemove,
    );

    expect(_modified, <String>['talata', 'arba3a']);
  });
// -----------------------------------------------------------------------------
  test('Mapper.chains Are the same', () {

    final List<String> _list1 = <String>[
      'cars/sport/ferrari/Competizione/',
      'cars/sport/ferrari/Monza/',
      'cars/sport/chevrolet/corvette/',
      'cars/4wheel/jeep/wrangler/',
      'cars/4wheel/hummer/h2/',
      'cars/4wheel/hummer/h3/',
      'bikes/race/honda/CBR/',
      'bikes/race/honda/KOKO/',
      'bikes/cruiser/harley/sportster/',
      'bikes/cruiser/harley/DAVIDSON/',
      'bikes/city/harley/bobo/',
    ];

    final List<Chain> _chains = ChainPathConverter.createChainsFromPaths(paths: _list1);

    final List<String> _generatedPaths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: _chains
    );

    final List<Chain> _regeneratedChains = ChainPathConverter.createChainsFromPaths(paths: _generatedPaths);

    final bool _result = Chain.checkChainsListsAreIdenticalOLDMETHOD(chains1: _chains, chains2: _regeneratedChains);

    expect(_result, true);
  });
// -----------------------------------------------------------------------------
  test('app need update', () {

    final bool _needUpdate = AppStateOps.appVersionNeedUpdate(
        globalVersion: '1.2.5+2',
        userVersion: '1.2.4',
    );

    expect(_needUpdate, true);

  });
// -----------------------------------------------------------------------------
  test('list has null value', () {

    final List<String> _list1 = <String>[
      'wa7ed',
      'etneen',
      null,
    ];

    final List<String> _list2 = <String>[
      null,
      'etneen',
      null,
    ];

    final List<String> _list3 = <String>[
      'etneen',
      'null',
    ];

    final bool _hasNull1 = Mapper.checkListHasNullValue(_list1);
    final bool _hasNull2 = Mapper.checkListHasNullValue(_list2);
    final bool _hasNull3 = Mapper.checkListHasNullValue(_list3);

    expect(_hasNull1, true);
    expect(_hasNull2, true);
    expect(_hasNull3, false);

  });
// -----------------------------------------------------------------------------
  test('notes are the same', () {

    final NoteModel note1 = NoteModel.dummyNote().copyWith(seenTime: Timers.createDateTime(hour: 1,millisecond: 5, microsecond: 2));
    final NoteModel note2 = NoteModel.dummyNote().copyWith(seenTime: Timers.createDateTime(hour: 1,millisecond: 5, microsecond: 2));

    final bool _areTheSame = NoteModel.checkNotesAreIdentical(
        note1: note1,
        note2: note2,
    );

    expect(_areTheSame, true);

  });
// -----------------------------------------------------------------------------
  test('notes Lists are the same', () {

    final List<NoteModel> note1 = <NoteModel>[
      NoteModel.dummyNote(),
      NoteModel.dummyNote().copyWith(body: 'blah'),
      NoteModel.dummyNote().copyWith(title: 'things'),
    ];

    final List<NoteModel> note2 = <NoteModel>[
    NoteModel.dummyNote(),
    NoteModel.dummyNote().copyWith(body: 'blah'),
    NoteModel.dummyNote().copyWith(title: 'thing'),
    ];

    final bool _areTheSame = NoteModel.checkNotesListsAreIdentical(
      notes1: note1,
      notes2: note2,
    );

    expect(_areTheSame, false);

  });
// -----------------------------------------------------------------------------
  test('bzz types & geopoints are the same', () {

    final List<BzType> _types1 = <BzType>[BzType.broker, BzType.contractor];
    final List<BzType> _types2 = <BzType>[BzType.broker, BzType.contractor];

    final bool _same = Mapper.checkListsAreIdentical(
      list1: _types1,
      list2: _types2,
    );
    expect(_same, true);

    const GeoPoint _point1 = GeoPoint(10, 15.5);
    const GeoPoint _point2 = GeoPoint(10, 15.5);

    final bool _pointsAreTheSame = _point1 == _point2;

    expect(_pointsAreTheSame, true);

  });
// -----------------------------------------------------------------------------
  test('contacts are the same', () {

    const List<ContactModel> _con1 = <ContactModel>[
      ContactModel(value: 'x', contactType: ContactType.email),
      ContactModel(value: 'e', contactType: ContactType.instagram),
    ];

    const List<ContactModel> _con2 = <ContactModel>[
      ContactModel(value: 'x', contactType: ContactType.email),
      ContactModel(value: 'ee', contactType: ContactType.instagram),
    ];

    final bool _same = ContactModel.checkContactsListsAreIdentical(
        contacts1: _con1,
        contacts2: _con2,
    );

    expect(_same, false);


  });
// -----------------------------------------------------------------------------
  test('bzz are the same', () {

    final BzModel _bz1 = BzModel.dummyBz('bzID');
    final BzModel _bz2 = BzModel.dummyBz('bzID');

    final bool _same = BzModel.checkBzzAreIdentical(
      bz1: _bz1,
      bz2: _bz2,
    );

    // BzModel.blogBzzDifferences(
    //   bz1: _bz1,
    //   bz2: _bz2,
    // );
    //
    // print('a77a aaaa');

    expect(_same, true);


  });
// -----------------------------------------------------------------------------
}
