import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:flutter/material.dart';

/// AGGREGATED DOCUMENTS
//
/// This is user to break a big map into small maps
/// and prevents from creating single map for each model
class Aggredocs{
  List<Map<String, dynamic>> docs;
  String collName;

  Aggredocs({
    this.docs,
    this.collName,
});
// -----------------------------------------------------------------------------
  static const int _aggredocLength = 500;
// -----------------------------------------------------------------------------
  static Aggredocs createAggredocsFromMaps({List<dynamic> maps, int numberOfMapKeys, String collName}){
    final int _finalAggredocLength = (_aggredocLength / (numberOfMapKeys + 1)).floor();

    List<Map<String, dynamic>> _docs = <Map<String, dynamic>>[];

    for (int i = 0; i < maps.length; i++){

      final int _aggredocIndex = (i / _finalAggredocLength).floor();

      if(_docs.length <= _aggredocIndex){
        _docs.add({});
      }
      Mapper.insertPairInMap(map: _docs[_aggredocIndex], key: '$i', value: maps[i]);

    }

    Aggredocs _aggredocs = Aggredocs(
      docs: _docs,
      collName: collName,
    );

    return _aggredocs;
  }
// -----------------------------------------------------------------------------
  static Future<void> uploadAggredocs({
    BuildContext context,
    Aggredocs aggredocs,
    String collName,
    String docName,
    String subCollName,
  }) async {

    for (int i = 0; i < aggredocs.docs.length; i++){

      await Fire.createNamedSubDoc(
        context: context,
        collName: collName,
        docName: docName,
        subCollName: subCollName,
        subDocName: 'doc_$i',
        input: aggredocs.docs[i],
      );

    }

  }

}