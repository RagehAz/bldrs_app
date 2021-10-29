import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
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

abstract class FireSearch {
// -----------------------------------------------------------------------------
    static Future<dynamic> mapsByFieldValue({
      @required BuildContext context,
      @required String collName,
      @required String field,
      @required dynamic compareValue,
      @required ValueIs valueIs,
      bool addDocsIDs = false,
      bool addDocSnapshotToEachMap = false,
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
        addDocSnapshotToEachMap: addDocSnapshotToEachMap,
      );

      Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

        });

    return _maps;

  }
// -----------------------------------------------------------------------------
  static Future<dynamic> mapsByValueInArray({
    @required BuildContext context,
    @required CollectionReference collRef,
    @required String field,
    @required dynamic value,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
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
            addDocsIDs: addDocsIDs,
            addDocSnapshotToEachMap: addDocSnapshotToEachMap,
          );
    });

    return _maps;
    }
// -----------------------------------------------------------------------------
  static Future<dynamic> mapsByTwoValuesEqualTo({
    @required BuildContext context,
    @required CollectionReference collRef,
    @required String fieldA,
    @required dynamic valueA,
    @required String fieldB,
    @required dynamic valueB,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
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
            addDocsIDs: addDocsIDs,
            addDocSnapshotToEachMap: addDocSnapshotToEachMap,
          );
        });

    return _maps;

  }
// -----------------------------------------------------------------------------
/// SEARCHING FLYERS
// --------------------------------------
/// SEARCH FLYERS BY AREA AND FLYER TYPE
  static Future<List<FlyerModel>> flyersByZoneAndFlyerType({
    @required BuildContext context,
    @required Zone zone,
    @required FlyerType flyerType,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
  }) async {

      List<FlyerModel> _flyers = <FlyerModel>[];

      await tryAndCatch(
          context: context,
          methodName: 'mapsByTwoValuesEqualTo',
          functions: () async {

            final CollectionReference _flyersCollection = Fire.getCollectionRef(FireColl.flyers);


            final String _flyerType = FlyerTypeClass.cipherFlyerType(flyerType);
            final Zone _zone = zone;

            print('searching flyers of type : $_flyerType : in $_zone');

            final QuerySnapshot _collectionSnapshot = await _flyersCollection
                .where('flyerType', isEqualTo: _flyerType)
                .where('flyerZone.cityID', isEqualTo: _zone.cityID)
                .get();


            List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
              querySnapshot: _collectionSnapshot,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap,
            );

             _flyers = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

          });

      return _flyers;

    }


/// SEARCHING BZZ
//

/// SEARCHING USERS
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> usersByUserName({@required BuildContext context, @required String compareValue}) async {

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

    final List<Map<String, dynamic>> _result = await mapsByFieldValue(
      context: context,
      collName: FireColl.users,
      field: 'trigram',
      compareValue: compareValue.trim(),
      addDocsIDs: false,
      valueIs: ValueIs.ArrayContains,
    );

      List<UserModel> _usersModels = <UserModel>[];

      if (Mapper.canLoopList(_result)){
        _usersModels = UserModel.decipherUsersMaps(
          maps: _result,
          fromJSON: false,
        );
      }

      return _usersModels;
    }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> bzzByBzName({@required BuildContext context, @required String compareValue}) async {

    final List<Map<String, dynamic>> _result = await mapsByFieldValue(
      context: context,
      collName: FireColl.bzz,
      field: 'trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: compareValue.trim(),
        numberOfCharacters: Standards.maxTrigramLength,
      ),
      addDocsIDs: false,
      valueIs: ValueIs.ArrayContains,
    );

    List<BzModel> _bzz = <BzModel>[];

    if (Mapper.canLoopList(_result)){
      _bzz = BzModel.decipherBzzMaps(
        maps: _result,
        fromJSON: false,
      );
    }

    return _bzz;


  }
// -----------------------------------------------------------------------------
}


