import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/controllers/theme/standards.dart' as Standards;
import 'package:bldrs/db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/models/kw/kw.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/city_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum ValueIs{
  greaterThan,
  greaterOrEqualThan,
  lessThan,
  lessOrEqualThan,
  equalTo,
  notEqualTo,
  nullValue,
  whereIn,
  whereNotIn,
  arrayContains,
  arrayContainsAny,
}

// -----------------------------------------------------------------------------

  /// GENERAL

// -----------------------------------------------
  Future<QuerySnapshot<Object>> _searchAndGetCollectionSnapshots({
    @required BuildContext context,
    @required CollectionReference<Object> collRef,
    @required ValueIs valueIs,
    @required String field,
    @required dynamic compareValue,
    @required int limit,
  }) async {

    QuerySnapshot<Object> _collectionSnapshot;

    await tryAndCatch(
        context: context,
        methodName: '_getCollectionSnapshots',
        functions: () async {

          /// IF EQUAL TO
          if (valueIs == ValueIs.equalTo){
            _collectionSnapshot = await collRef
                .where(field, isEqualTo: compareValue)
                .limit(limit)
                .get();
          }
          /// IF GREATER THAN
          else if (valueIs == ValueIs.greaterThan){
            _collectionSnapshot = await collRef
                .where(field, isGreaterThan: compareValue)
                .limit(limit)
                .get();
          }
          /// IF GREATER THAN OR EQUAL
          else if (valueIs == ValueIs.greaterOrEqualThan){
            _collectionSnapshot = await collRef
                .where(field, isGreaterThanOrEqualTo: compareValue)
                .limit(limit)
                .get();
          }
          /// IF LESS THAN
          else if (valueIs == ValueIs.lessThan){
            _collectionSnapshot = await collRef
                .where(field, isLessThan: compareValue)
                .limit(limit)
                .get();
          }
          /// IF LESS THAN OR EQUAL
          else if (valueIs == ValueIs.lessOrEqualThan){
            _collectionSnapshot = await collRef
                .where(field, isLessThanOrEqualTo: compareValue)
                .limit(limit)
                .get();
          }
          /// IF IS NOT EQUAL TO
          else if (valueIs == ValueIs.notEqualTo){
            _collectionSnapshot = await collRef
                .where(field, isNotEqualTo: compareValue)
                .limit(limit)
                .get();
          }
          /// IF IS NULL
          else if (valueIs == ValueIs.nullValue){
            _collectionSnapshot = await collRef
                .where(field, isNull: compareValue)
                .limit(limit)
                .get();
          }
          /// IF whereIn
          else if (valueIs == ValueIs.whereIn){
            _collectionSnapshot = await collRef
                .where(field, whereIn: compareValue)
                .limit(limit)
                .get();
          }
          /// IF whereNotIn
          else if (valueIs == ValueIs.whereNotIn){
            _collectionSnapshot = await collRef
                .where(field, whereNotIn: compareValue)
                .limit(limit)
                .get();
          }
          /// IF array contains
          else if (valueIs == ValueIs.arrayContains){
            _collectionSnapshot = await collRef
                .where(field, arrayContains: compareValue)
                .limit(limit)
                .get();
          }
          /// IF array contains any
          else if (valueIs == ValueIs.arrayContainsAny){
            _collectionSnapshot = await collRef
                .where(field, arrayContainsAny: compareValue)
                .limit(limit)
                .get();
          }

        }
    );


    return _collectionSnapshot;
  }
// -----------------------------------------------
    Future<dynamic> mapsByFieldValue({
      @required BuildContext context,
      @required String collName,
      @required String field,
      @required dynamic compareValue,
      @required ValueIs valueIs,
      bool addDocsIDs = false,
      bool addDocSnapshotToEachMap = false,
      int limit = 3,
  }) async {

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);

    final CollectionReference<Object> _collRef = Fire.getCollectionRef(collName);

    final QuerySnapshot<Object> _collectionSnapshot = await _searchAndGetCollectionSnapshots(
      context: context,
      collRef: _collRef,
      valueIs: valueIs,
      field: field,
      compareValue: compareValue,
      limit: limit,
    );

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);

     final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
      querySnapshot: _collectionSnapshot,
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    );

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

    return _maps;

  }
// -----------------------------------------------
  Future<dynamic> subCollectionMapsByFieldValue({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required String field,
    @required dynamic compareValue,
    @required ValueIs valueIs,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
    int limit = 3,
  }) async {

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: field, varNewValue: compareValue, tracerIsOn: true);

    final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    final QuerySnapshot<Object> _collectionSnapshot = await _searchAndGetCollectionSnapshots(
      context: context,
      collRef: _collRef,
      valueIs: valueIs,
      field: field,
      compareValue: compareValue,
      limit: limit,
    );

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: 'valueIs', varNewValue: valueIs, tracerIsOn: true);

    final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQuerySnapshot(
      querySnapshot: _collectionSnapshot,
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    );

    // Tracer.traceMethod(methodName: 'mapsByFieldValue', varName: '_maps', varNewValue: _maps, tracerIsOn: true);

    return _maps;

  }
// -----------------------------------------------
  Future<dynamic> mapsByValueInArray({
    @required BuildContext context,
    @required CollectionReference<Object> collRef,
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

          QuerySnapshot<Object> _collectionSnapshot;

          /// if search value is just 1 string
          if (value is String == true){
            _collectionSnapshot = await collRef
                .where(field, arrayContains: value)
                .get();
          }
          /// i search value is list of strings
          else if(value is List == true){
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
// -----------------------------------------------
  Future<dynamic> mapsByTwoValuesEqualTo({
    @required BuildContext context,
    @required CollectionReference<Object> collRef,
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

          QuerySnapshot<Object> _collectionSnapshot;

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

  /// FLYERS

// -----------------------------------------------
/// SEARCH FLYERS BY AREA AND FLYER TYPE
  Future<List<FlyerModel>> flyersByZoneAndFlyerType({
    @required BuildContext context,
    @required ZoneModel zone,
    @required FlyerTypeClass.FlyerType flyerType,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
  }) async {

      List<FlyerModel> _flyers = <FlyerModel>[];

      await tryAndCatch(
          context: context,
          methodName: 'mapsByTwoValuesEqualTo',
          functions: () async {

            final CollectionReference<Object> _flyersCollection = Fire.getCollectionRef(FireColl.flyers);


            final String _flyerType = FlyerTypeClass.cipherFlyerType(flyerType);
            final ZoneModel _zone = zone;

            print('searching flyers of type : $_flyerType : in $_zone');

            final QuerySnapshot<Object> _collectionSnapshot = await _flyersCollection
                .where('flyerType', isEqualTo: _flyerType)
                .where('flyerZone.cityID', isEqualTo: _zone.cityID)
                .get();


            final List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
              querySnapshot: _collectionSnapshot,
              addDocsIDs: addDocsIDs,
              addDocSnapshotToEachMap: addDocSnapshotToEachMap,
            );

             _flyers = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

          });

      return _flyers;

    }
// -----------------------------------------------
  Future<List<FlyerModel>> flyersByZoneAndKeyword({
    @required BuildContext context,
    @required ZoneModel zone,
    @required KW kw,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
    int limit = 3,
  }) async {

    List<FlyerModel> _flyers = <FlyerModel>[];

    await tryAndCatch(
        context: context,
        methodName: 'flyersByZoneAndKeyword',
        functions: () async {

          final CollectionReference<Object> _flyersCollection = Fire.getCollectionRef(FireColl.flyers);

          final ZoneModel _zone = zone;

          print('searching flyers of keyword : ${kw.id} : in ${_zone.countryID} - ${_zone.cityID}');

          final QuerySnapshot<Object> _collectionSnapshot = await _flyersCollection
              .where('zone.countryID', isEqualTo: _zone.countryID)
              .where('zone.cityID', isEqualTo: _zone.cityID)
              .where('keywordsIDs', arrayContains: kw.id)
              .limit(limit)
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
// -----------------------------------------------
  Future<List<FlyerModel>> flyersByZoneAndTitle({
    @required BuildContext context,
    @required ZoneModel zone,
    @required String title,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
    int limit = 3,
}) async {


    List<Map<String, dynamic>> _maps = await mapsByFieldValue(
      context: context,
      collName: FireColl.flyers,
      field: 'trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: title.trim(),
        numberOfCharacters: Standards.maxTrigramLength,
      ),
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
      valueIs: ValueIs.arrayContains,
      limit: limit,
    );

    List<FlyerModel> _result = <FlyerModel>[];

    if (Mapper.canLoopList(_maps)){

      _result = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    }

    return _result;
}
// -----------------------------------------------------------------------------

  /// USERS

// -----------------------------------------------
  Future<List<UserModel>> usersByUserName({
    @required BuildContext context,
    @required String name
  }) async {

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
      compareValue: name.trim(),
      valueIs: ValueIs.arrayContains,
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
// -----------------------------------------------
  Future<List<UserModel>> usersByNameAndIsAuthor({
    @required BuildContext context,
    @required String name,
    int limit = 3,
    bool addDocsIDs = false,
    bool addDocSnapshotToEachMap = false,
  }) async {

    List<UserModel> _usersModels = <UserModel>[];

    await tryAndCatch(
        context: context,
        methodName: 'usersByNameAndIsAuthor',
        functions: () async {

          final CollectionReference<Object> _usersCollection = Fire.getCollectionRef(FireColl.users);

          final QuerySnapshot<Object> _collectionSnapshot = await _usersCollection
              .where('myBzzIDs', isNotEqualTo: <String>[])
              .where('trigram', arrayContains: name.trim().toLowerCase())
              .limit(limit)
              .get();

          final List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: addDocsIDs,
            addDocSnapshotToEachMap: addDocSnapshotToEachMap,
          );

          if (Mapper.canLoopList(_maps)){
            _usersModels = UserModel.decipherUsersMaps(maps: _maps, fromJSON: false);
          }

        });


    return _usersModels;
  }
// -----------------------------------------------------------------------------

  /// BZZ

// -----------------------------------------------
  Future<List<BzModel>> bzzByBzName({
    @required BuildContext context,
    @required String bzName
  }) async {

    final List<Map<String, dynamic>> _result = await mapsByFieldValue(
      context: context,
      collName: FireColl.bzz,
      field: 'trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: bzName.trim(),
        numberOfCharacters: Standards.maxTrigramLength,
      ),
      valueIs: ValueIs.arrayContains,
    );

    List<BzModel> _bzz = <BzModel>[];

    if (Mapper.canLoopList(_result)){
      _bzz = BzModel.decipherBzz(
        maps: _result,
        fromJSON: false,
      );
    }

    return _bzz;

  }
// -----------------------------------------------------------------------------

  /// ZONES

// -----------------------------------------------
  Future<List<CityModel>> citiesByCityName({
    @required BuildContext context,
    @required String cityName,
    @required String lingoCode
  }) async {

    List<CityModel> _cities = <CityModel>[];

    if (cityName != null && cityName.length != 0){

      final List<Map<String, dynamic>> _result = await subCollectionMapsByFieldValue(
        context: context,
        collName: FireColl.zones,
        docName: FireDoc.zones_cities,
        subCollName: FireSubColl.zones_cities_cities,
        field: 'names.$lingoCode.trigram',
        compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
          input: CountryModel.fixCountryName(cityName),
          numberOfCharacters: Standards.maxTrigramLength,
        ),
        valueIs: ValueIs.arrayContains,
      );


      if (Mapper.canLoopList(_result)){
        _cities = CityModel.decipherCitiesMaps(
          maps: _result,
          fromJSON: false,
        );
      }

    }

    return _cities;

  }
// -----------------------------------------------
  /// not tested
  Future<List<CityModel>> citiesByCityNameAndCountryID({
    @required BuildContext context,
    @required String cityName,
    @required String countryID,
    @required String lingoCode,
  }) async {

    List<CityModel> _cities = <CityModel>[];

    await tryAndCatch(
        context: context,
        methodName: 'mapsByTwoValuesEqualTo',
        functions: () async {

          final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
            collName: FireColl.zones,
            docName: FireDoc.zones_cities,
            subCollName: FireSubColl.zones_cities_cities,
          );

          final String _searchValue = TextMod.removeAllCharactersAfterNumberOfCharacters(
            input: CountryModel.fixCountryName(cityName),
            numberOfCharacters: Standards.maxTrigramLength,
          );

          final QuerySnapshot<Object> _collectionSnapshot = await _collRef
              .where('countryID', isEqualTo: countryID)
              .where('names.$lingoCode.trigram', arrayContains: _searchValue)
              .get();


          List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: false,
            addDocSnapshotToEachMap: false,
          );

          _cities = CityModel.decipherCitiesMaps(maps: _maps, fromJSON: false);

        });

    return _cities;

  }
// -----------------------------------------------------------------------------
