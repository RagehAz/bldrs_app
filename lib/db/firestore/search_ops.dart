import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
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
      String collName,
      String field,
      dynamic compareValue,
      ValueIs valueIs,
      bool addDocsIDs,
  }) async {

      Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    await tryAndCatch(
        context: context,
        methodName: 'mapsByFieldValue',
        functions: () async {

      QuerySnapshot _collectionSnapshot;

      final CollectionReference _collRef = Fire.getCollectionRef(collName);

      /// IF EQUAL TO
      if (valueIs == ValueIs.EqualTo){
        _collectionSnapshot = await _collRef
            .where(field, isEqualTo: compareValue)
            .get();
      }
      /// IF GREATER THAN
      else if (valueIs == ValueIs.GreaterThan){
        _collectionSnapshot = await _collRef
            .where(field, isGreaterThan: compareValue)
            .get();
      }
      /// IF GREATER THAN OR EQUAL
      else if (valueIs == ValueIs.GreaterOrEqualThan){
        _collectionSnapshot = await _collRef
            .where(field, isGreaterThanOrEqualTo: compareValue)
            .get();
      }
      /// IF LESS THAN
      else if (valueIs == ValueIs.LessThan){
        _collectionSnapshot = await _collRef
            .where(field, isLessThan: compareValue)
            .get();
      }
      /// IF LESS THAN OR EQUAL
      else if (valueIs == ValueIs.LessOrEqualThan){
        _collectionSnapshot = await _collRef
            .where(field, isLessThanOrEqualTo: compareValue)
            .get();
      }
      /// IF IS NOT EQUAL TO
      else if (valueIs == ValueIs.NotEqualTo){
        _collectionSnapshot = await _collRef
            .where(field, isNotEqualTo: compareValue)
            .get();
      }
      /// IF IS NULL
      else if (valueIs == ValueIs.Null){
        _collectionSnapshot = await _collRef
            .where(field, isNull: compareValue)
            .get();
      }
      /// IF whereIn
      else if (valueIs == ValueIs.WhereIn){
        _collectionSnapshot = await _collRef
            .where(field, whereIn: compareValue)
            .get();
      }
      /// IF whereNotIn
      else if (valueIs == ValueIs.WhereNotIn){
        _collectionSnapshot = await _collRef
            .where(field, whereNotIn: compareValue)
            .get();
      }
      /// IF array contains
      else if (valueIs == ValueIs.ArrayContains){
        _collectionSnapshot = await _collRef
            .where(field, arrayContains: compareValue)
            .get();
      }
      /// IF array contains any
      else if (valueIs == ValueIs.ArrayContainsAny){
        _collectionSnapshot = await _collRef
            .where(field, arrayContainsAny: compareValue)
            .get();
      }

      Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);

      _maps = Mapper.getMapsFromQuerySnapshot(
        querySnapshot: _collectionSnapshot,
        addDocsIDs: true,
      );

      Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

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

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

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

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

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
// --------------------------------------
/// SEARCH FLYERS BY AREA AND FLYER TYPE
  static Future<List<TinyFlyer>> flyersByZoneAndFlyerType({
    BuildContext context,
    Zone zone,
    FlyerType flyerType,
  }) async {

      List<TinyFlyer> _tinyFlyers = <TinyFlyer>[];

      await tryAndCatch(
          context: context,
          methodName: 'mapsByTwoValuesEqualTo',
          functions: () async {

            final CollectionReference _flyersCollection = Fire.getCollectionRef(FireCollection.tinyFlyers);

            QuerySnapshot _collectionSnapshot;

            final String _flyerType = FlyerTypeClass.cipherFlyerType(flyerType);
            final Zone _zone = zone;

            print('searching tiny flyers of type : $_flyerType : in $_zone');

            _collectionSnapshot = await _flyersCollection
                .where('flyerType', isEqualTo: _flyerType)
                .where('flyerZone.provinceID', isEqualTo: _zone.cityID)
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
//

/// SEARCHING USERS
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> usersByUserName({BuildContext context, String compareValue}) async {

    // /// WORK GOOD WITH 1 SINGLE WORD FIELDS,, AND SEARCHES BY MATCHES THE INITIAL CHARACTERS :
    // /// 'Rag' --->    gets [Rageh Mohamed]
    // /// 'geh' -/->    doesn't get [Rageh Mohamed]
    // /// 'Moh' -/->    doesn't get [Rageh Mohamed]
    // /// 'Mohamed -/-> doesn't get [Rageh Mohamed]
    // QuerySnapshot<Map<String, dynamic>> _snapshots = await Fire.getCollectionRef(FireCollection.users).orderBy("name").where("name",isGreaterThanOrEqualTo: compareValue).where("name",isLessThanOrEqualTo: compareValue+"z").get();

    // QuerySnapshot<Map<String, dynamic>> _snapshots = await Fire.getCollectionRef(FireCollection.users)
    //     .orderBy("name")
    //     .where("nameTrigram", arrayContainsAny: [compareValue]).get();
    //     // .where("name",isLessThanOrEqualTo: compareValue+"z")
    // List<Map<String, dynamic> >_result = Mapper.getMapsFromQuerySnapshot(
    //   querySnapshot: _snapshots,
    //   addDocsIDs: false,
    // );

    final dynamic _result = await mapsByFieldValue(
      context: context,
      collName: FireCollection.users,
      field: 'nameTrigram',
      compareValue: compareValue,
      addDocsIDs: false,
      valueIs: ValueIs.ArrayContains,
    );

      List<UserModel> _usersModels = <UserModel>[];

      if (_result != <UserModel>[] || _result != null){
        _usersModels = UserModel.decipherUsersMaps(
          maps: _result,
          fromJSON: false,
        );
      }

      return _usersModels;
    }
// -----------------------------------------------------------------------------
}


