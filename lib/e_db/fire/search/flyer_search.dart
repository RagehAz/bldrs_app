import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart' as FlyerTypeClass;
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as Search;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        final CollectionReference<Object> _flyersCollection =
        Fire.getCollectionRef(FireColl.flyers);

        final String _flyerType = FlyerTypeClass.cipherFlyerType(flyerType);
        final ZoneModel _zone = zone;

        blog('searching flyers of type : $_flyerType : in $_zone');

        final QuerySnapshot<Object> _collectionSnapshot =
        await _flyersCollection
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
Future<List<FlyerModel>> flyersByZoneAndKeywordID({
  @required BuildContext context,
  @required ZoneModel zone,
  @required String keywordID,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
  int limit = 3,
}) async {
  List<FlyerModel> _flyers = <FlyerModel>[];

  await tryAndCatch(
      context: context,
      methodName: 'flyersByZoneAndKeyword',
      functions: () async {
        final CollectionReference<Object> _flyersCollection =
        Fire.getCollectionRef(FireColl.flyers);

        final ZoneModel _zone = zone;

        blog(
            'searching flyers of keyword : $keywordID : in ${_zone.countryID} - ${_zone.cityID}');

        final QuerySnapshot<Object> _collectionSnapshot =
        await _flyersCollection
            .where('zone.countryID', isEqualTo: _zone.countryID)
            .where('zone.cityID', isEqualTo: _zone.cityID)
            .where('keywordsIDs', arrayContains: keywordID)
            .limit(limit)
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
Future<List<FlyerModel>> flyersByZoneAndTitle({
  @required BuildContext context,
  @required ZoneModel zone,
  @required String title,
  bool addDocsIDs = false,
  bool addDocSnapshotToEachMap = false,
  int limit = 3,
}) async {

  final List<Map<String, dynamic>> _maps = await Search.mapsByFieldValue(
    context: context,
    collName: FireColl.flyers,
    field: 'trigram',
    compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: title.trim(),
      numberOfCharacters: Standards.maxTrigramLength,
    ),
    addDocsIDs: addDocsIDs,
    addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    valueIs: Search.ValueIs.arrayContains,
    limit: limit,
  );

  List<FlyerModel> _result = <FlyerModel>[];

  if (Mapper.canLoopList(_maps)) {
    _result = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
  }

  return _result;
}
// -----------------------------------------------------------------------------

  /// FLYER PROMOTION

// -----------------------------------------------
Future<List<FlyerPromotion>> flyerPromotionsByCity({
  @required BuildContext context,
  @required String cityID,
  // @required List<String> districts,
  // @required DateTime timeLimit,
}) async {

  final List<Map<String, dynamic>> _maps = await Search.mapsByFieldValue(
    context: context,
    collName: FireColl.flyersPromotions,
    field: 'cityID',
    compareValue: cityID,
    valueIs: Search.ValueIs.equalTo,
  );

  final List<FlyerPromotion> _flyerPromotions = FlyerPromotion.decipherFlyersPromotions(
    maps: _maps,
    fromJSON: false,
  );

  return _flyerPromotions;
}
// -----------------------------------------------------------------------------
