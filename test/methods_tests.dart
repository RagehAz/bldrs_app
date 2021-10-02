import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/models/flyer/sub/spec_model.dart';
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

// -----------------------------------------------------------------------------
}