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
}