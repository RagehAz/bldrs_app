import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum ValueIs{
  GreaterThan,
  GreaterOrEqualThan,
  LessThan,
  LessOrEqualThan,
  EqualTo,
  NotEqualTo,
  Null,
  WhereIn,
  WhereNotIn,
  ArrayContains,
  ArrayContainsAny,
}

class FireSearch {
// -----------------------------------------------------------------------------
    static Future<dynamic> mapsByFieldValue({
      BuildContext context,
      CollectionReference collRef,
      String field,
      dynamic compareValue,
      ValueIs valueIs,
      bool addDocsIDs,
  }) async {

    List<Map<String, dynamic>> _maps = new List();

    await tryAndCatch(
        context: context,
        methodName: 'mapsByFieldValue',
        functions: () async {

      QuerySnapshot _collectionSnapshot;

      /// IF EQUAL TO
      if (valueIs == ValueIs.EqualTo){
        _collectionSnapshot = await collRef
            .where(field, isEqualTo: compareValue)
            .get();
      }
      /// IF GREATER THAN
      else if (valueIs == ValueIs.GreaterThan){
        _collectionSnapshot = await collRef
            .where(field, isGreaterThan: compareValue)
            .get();
      }
      /// IF GREATER THAN OR EQUAL
      else if (valueIs == ValueIs.GreaterOrEqualThan){
        _collectionSnapshot = await collRef
            .where(field, isGreaterThanOrEqualTo: compareValue)
            .get();
      }
      /// IF LESS THAN
      else if (valueIs == ValueIs.LessThan){
        _collectionSnapshot = await collRef
            .where(field, isLessThan: compareValue)
            .get();
      }
      /// IF LESS THAN OR EQUAL
      else if (valueIs == ValueIs.LessOrEqualThan){
        _collectionSnapshot = await collRef
            .where(field, isLessThanOrEqualTo: compareValue)
            .get();
      }
      /// IF IS NOT EQUAL TO
      else if (valueIs == ValueIs.NotEqualTo){
        _collectionSnapshot = await collRef
            .where(field, isNotEqualTo: compareValue)
            .get();
      }
      /// IF IS NULL
      else if (valueIs == ValueIs.Null){
        _collectionSnapshot = await collRef
            .where(field, isNull: compareValue)
            .get();
      }
      /// IF whereIn
      else if (valueIs == ValueIs.WhereIn){
        _collectionSnapshot = await collRef
            .where(field, whereIn: compareValue)
            .get();
      }
      /// IF whereNotIn
      else if (valueIs == ValueIs.WhereNotIn){
        _collectionSnapshot = await collRef
            .where(field, whereNotIn: compareValue)
            .get();
      }
      /// IF array contains
      else if (valueIs == ValueIs.ArrayContains){
        _collectionSnapshot = await collRef
            .where(field, arrayContains: compareValue)
            .get();
      }
      /// IF array contains any
      else if (valueIs == ValueIs.ArrayContainsAny){
        _collectionSnapshot = await collRef
            .where(field, arrayContainsAny: compareValue)
            .get();
      }

      _maps = Mapper.getMapsFromQuerySnapshot(
        querySnapshot: _collectionSnapshot,
        addDocsIDs: true,
      );

    });

    return _maps;

  }
// -----------------------------------------------------------------------------
  static Future<dynamic> mapsByValueInArray({
    BuildContext context,
    CollectionReference collRef,
    String field,
    dynamic value,
    bool addDocsIDs,
}) async {

    List<Map<String, dynamic>> _maps = new List();

    await tryAndCatch(
        context: context,
        methodName: 'mapsByValueInArray',
        functions: () async {

          QuerySnapshot _collectionSnapshot;

          /// if search value is just 1 string
          if (ObjectChecker.objectIsString(value) == true){
            _collectionSnapshot = await collRef
                .where(field, arrayContains: value)
                .get();
          }
          /// i search value is list of strings
          else if(ObjectChecker.objectIsList(value) == true){
            _collectionSnapshot = await collRef
                .where(field, whereIn: value)
                .get();
          }

          _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: true,
          );
    });

    return _maps;
    }
// -----------------------------------------------------------------------------
  static Future<dynamic> mapsByTwoValuesEqualTo({
    BuildContext context,
    CollectionReference collRef,
    String fieldA,
    dynamic valueA,
    String fieldB,
    dynamic valueB,
    bool addDocsIDs,
}) async {

    List<Map<String, dynamic>> _maps = new List();

    await tryAndCatch(
        context: context,
        methodName: 'mapsByTwoValuesEqualTo',
        functions: () async {

          QuerySnapshot _collectionSnapshot;

            _collectionSnapshot = await collRef
                .where(fieldA, isEqualTo: valueA)
                .where(fieldB, isEqualTo: valueB)
                .get();

            print('is not equal to null aho');

          _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: true,
          );
        });

    return _maps;

  }
// -----------------------------------------------------------------------------
/// SEARCHING FLYERS
/// -------------------

/// SEARCH FLYERS BY AREA AND FLYER TYPE
  static Future<List<TinyFlyer>> flyersByZoneAndFlyerType({
    BuildContext context,
    Zone zone,
    FlyerType flyerType,
  }) async {

      List<TinyFlyer> _tinyFlyers = new List();

      await tryAndCatch(
          context: context,
          methodName: 'mapsByTwoValuesEqualTo',
          functions: () async {

            CollectionReference _flyersCollection = Fire.getCollectionRef(FireCollection.tinyFlyers);

            QuerySnapshot _collectionSnapshot;

            int _flyerType = FlyerModel.cipherFlyerType(flyerType);
            Zone _zone = zone;

            print('searching tiny flyers of type : $_flyerType : in $_zone');

            _collectionSnapshot = await _flyersCollection
                .where('flyerType', isEqualTo: _flyerType)
                .where('flyerZone.provinceID', isEqualTo: _zone.provinceID)
                .get();


            List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
              querySnapshot: _collectionSnapshot,
              addDocsIDs: false,
            );

             _tinyFlyers = TinyFlyer.decipherTinyFlyersMaps(_maps);

          });

      return _tinyFlyers;

    }


/// SEARCHING BZZ
///
///
/// SEARCHING USERS

}


