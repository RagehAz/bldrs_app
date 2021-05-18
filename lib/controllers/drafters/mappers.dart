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

    return _mapsAreTheSame;
  }
// -----------------------------------------------------------------------------
}