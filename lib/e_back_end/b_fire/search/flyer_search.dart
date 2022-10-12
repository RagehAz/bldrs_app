import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// FLYERS

// --------------------
/// SEARCH FLYERS BY AREA AND FLYER TYPE
Future<List<FlyerModel>> flyersByZoneAndFlyerType({
  @required BuildContext context,
  @required ZoneModel zone,
  @required FlyerType flyerType,
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

        final String _flyerType = FlyerTyper.cipherFlyerType(flyerType);
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
// --------------------
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
// --------------------
Future<List<FlyerModel>> flyersByZoneAndTitle({
  @required BuildContext context,
  @required ZoneModel zone,
  @required String title,
  @required QueryDocumentSnapshot<Object> startAfter,
  bool addDocsIDs = false,
  int limit = 6,
}) async {

  final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
    context: context,
    collName: FireColl.flyers,
    // orderBy: 'score',
    addDocSnapshotToEachMap: true,
    limit: limit,
    startAfter: startAfter,
    finders: <FireFinder>[
      FireFinder(
          field: 'trigram',
          comparison: FireComparison.arrayContains,
          value: TextMod.removeAllCharactersAfterNumberOfCharacters(
            input: title.trim(),
            numberOfChars: Standards.maxTrigramLength,
          )
      ),
      FireFinder(
        field: 'zone.countryID',
        comparison: FireComparison.equalTo,
        value: zone.countryID,
      ),
      FireFinder(
        field: 'zone.cityID',
        comparison: FireComparison.equalTo,
        value: zone.cityID,
      ),
    ],
  );

  List<FlyerModel> _result = <FlyerModel>[];

  if (Mapper.checkCanLoopList(_maps)) {
    _result = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
  }

  return _result;
}
// -----------------------------------------------------------------------------

/// FLYER PROMOTION

// --------------------
Future<List<FlyerPromotion>> flyerPromotionsByCity({
  @required BuildContext context,
  @required String cityID,
  // @required List<String> districts,
  // @required DateTime timeLimit,
}) async {

  final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
    context: context,
    collName: FireColl.flyersPromotions,
    limit: 10,
    finders: <FireFinder>[
      FireFinder(
        field: 'cityID',
        comparison: FireComparison.equalTo,
        value: cityID,
      ),
    ],
  );

  final List<FlyerPromotion> _flyerPromotions = FlyerPromotion.decipherFlyersPromotions(
    maps: _maps,
    fromJSON: false,
  );

  return _flyerPromotions;
}
// -----------------------------------------------------------------------------
