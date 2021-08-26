import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mapper{
// -----------------------------------------------------------------------------
  /// TODO : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]
  static List<String> getFirstValuesFromMaps(List<Map<String, Object>> listOfMaps){
    List<String> listOfFirstValues = new List();

    for (int x = 0; x<listOfMaps.length; x++){
      String firstValue = (listOfMaps[x].values.toList())[0];
      listOfFirstValues.add(firstValue);
    }

    return listOfFirstValues;
  }
// -----------------------------------------------------------------------------
  /// TODO : check getFirstValuesFromMaps if not used in production
  /// [
  /// {'key' : 'ID'         , 'key' : 'Value'       },
  /// {'key' : 'firstValue' , 'key' : 'secondValue' },
  /// ]
  static List<String> getSecondValuesFromMaps(List<Map<String, Object>> listOfMaps){
    List<String> listOfValues = new List();

    for (int x = 0; x<listOfMaps.length; x++){
      String secondValue = (listOfMaps[x].values.toList())[1];
      listOfValues.add(secondValue);
    }

    return listOfValues;
  }
// -----------------------------------------------------------------------------
  static List<dynamic> cloneListOfStrings(List<dynamic> list){
    List<dynamic> _newList = new List();

    for (var x in list){
      _newList.add(x);
    }
    return _newList;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> getMapsFromQuerySnapshot({
    QuerySnapshot querySnapshot,
    bool addDocsIDs,
  }){

    final List<QueryDocumentSnapshot> _docsSnapshots = querySnapshot.docs;

    final List<Map<String, dynamic>> _maps = getMapsFromQueryDocumentSnapshotsList(
      queryDocumentSnapshots: _docsSnapshots,
      addDocsIDs: addDocsIDs,
    );

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
    List<QueryDocumentSnapshot> queryDocumentSnapshots,
    bool addDocsIDs,
  }){

    List<Map<String, dynamic>> _maps = new List();

    for (var docSnapshot in queryDocumentSnapshots){
      String _docID = docSnapshot.id;
      Map<String, dynamic> _map = docSnapshot.data();

      if (addDocsIDs == true){
        _map['id'] = _docID;
      }

      _maps.add(_map);
    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> getMapFromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    Map<String, dynamic> _map = documentSnapshot.data();
    return _map;

  }
// -----------------------------------------------------------------------------
  static bool listOfMapsContainValue({List<dynamic> listOfMaps, String field, String value}){

    bool _listOfMapContainsTheValue;

    for (var map in listOfMaps){

      if (map[field] == value){
        _listOfMapContainsTheValue = true;
        break;
      } else {
        _listOfMapContainsTheValue = false;
      }

    }

    return _listOfMapContainsTheValue;
  }
// -----------------------------------------------------------------------------
  /// listOfMaps = [
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// {'key1' : 'value', 'key2' : 'value2'}
  /// ];
  ///
  /// map = {'key1' : 'value', 'key2' : 'value2'};
  static bool listOfMapsContainMap({List<Map<String, dynamic>> listOfMaps, Map<String, dynamic> map}){

    bool _listOfMapContainsTheMap;

    bool _inputsAreInvalid = listOfMaps == null || listOfMaps.length == 0 || map == null ? true : false;

    if(_inputsAreInvalid == true){
      _listOfMapContainsTheMap = false;
    }

    else {

    for (var _map in listOfMaps){

      if (mapsAreTheSame(_map, map)){
        _listOfMapContainsTheMap = true;
        break;
      } else {
        _listOfMapContainsTheMap = false;
      }

    }

    }

    return _listOfMapContainsTheMap;
  }
// -----------------------------------------------------------------------------
  static bool listsAreTheSame({List<dynamic> list1, List<dynamic> list2}){
    bool listsAreTheSame;

    if (list1.length != list2.length){
      listsAreTheSame = false;
    }

    else {

      for (int i = 0; i<list1.length; i++){

        if (list1[i] != list2[i]){
          listsAreTheSame = false;
          break;
        }

        else{
          listsAreTheSame = true;
        }

      }

    }


    return listsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool mapsAreTheSame(Map<String, dynamic> map1, Map<String, dynamic> map2){
    bool _mapsAreTheSame;

    bool _inputsAreInvalid = map1 == null || map2 == null ? true : false;

    if (_inputsAreInvalid == true){
      _mapsAreTheSame = null;
    }

    else {
      List<String> _map1Keys = map1.keys.toList();
      List<dynamic> _map1Values = map1.values.toList();

      List<String> _map2Keys = map2.keys.toList();
      List<dynamic> _map2Values = map2.values.toList();

      if(_map1Keys.length != _map2Keys.length){
        _mapsAreTheSame = false;
      }

      else{

        if (
        listsAreTheSame(list1: _map1Keys, list2: _map2Keys) == true
            &&
            listsAreTheSame(list1: _map1Values, list2: _map2Values) == true
        ){
          _mapsAreTheSame = true;
        }

        else {
          _mapsAreTheSame = false;
        }

      }

    }


    return _mapsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static int indexOfMapInListOfMaps(List<Map<String, dynamic>> listOfMaps, Map<String,dynamic> map){
      int _indexOfTheMap = listOfMaps.indexWhere((m) => Mapper.mapsAreTheSame(m, map));
      return _indexOfTheMap;
  }
// -----------------------------------------------------------------------------
  static int indexOfMapByValueInListOfMaps({List<Map<String, dynamic>> listOfMaps, String key, dynamic value}){
    int _indexOfTheMap = listOfMaps.indexWhere((map) => map[key] == value);
    return _indexOfTheMap;
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> insertPairInMap({Map<String,dynamic> map, String key, dynamic value}){
    map.putIfAbsent(key, () => value);

    Map<String, dynamic> _result = {};
    _result.addAll(map);

    return _result;
  }
// -----------------------------------------------------------------------------
  /// url query looks like "key1=value1&key1=value2&key3=value3"
  static Map<String, dynamic> getMapFromURLQuery({String urlQuery}){
    /// url query should look like this
    /// 'country=eg&category=business&apiKey=65f7556ec76449fa7dc7c0069f040ca';

    Map<String, dynamic> _output = {};

    int _numberOfAnds = '&'.allMatches(urlQuery).length;
    int _numberOfEquals = '='.allMatches(urlQuery).length;
    bool _countsOfPairsAreGood = _numberOfAnds + 1 == _numberOfEquals;

    /// if urlQuery counts are good
    if (_countsOfPairsAreGood == true){

      /// pairs should look like this : key=value
      List<String> _pairs = new List();

      /// holds temp trimmed url in here while trimming loops
      String _trimmedURL = urlQuery;

      print('_trimmedURL : $_trimmedURL');

      /// trim urlQuery into string pairs
      for (int i = 0; i < _numberOfAnds; i++){

        String _beforeAnd = TextMod.trimTextAfterFirstSpecialCharacter(_trimmedURL, '&');
        _pairs.add(_beforeAnd);

        String _afterAnd = TextMod.trimTextBeforeFirstSpecialCharacter(_trimmedURL, '&');

        if (i == _numberOfAnds - 1){
          _pairs.add(_afterAnd);
        } else {
          _trimmedURL = _afterAnd;
        }

      }

      /// add pairs to a map
      for (String pair in _pairs){

        String _key = TextMod.trimTextAfterFirstSpecialCharacter(pair, '=');
        String _value = TextMod.trimTextBeforeFirstSpecialCharacter(pair, '=');

        _output = Mapper.insertPairInMap(map: _output, key: _key,value: _value,);

      }

    }

    /// if counts are no good
    else {
      print('getMapFromURLQuery : _countsOfPairsAreGood : $_countsOfPairsAreGood');
      print('getMapFromURLQuery : something is wrong in this : urlQuery : $urlQuery');
    }


    return _output;
  }
// -----------------------------------------------------------------------------
}
