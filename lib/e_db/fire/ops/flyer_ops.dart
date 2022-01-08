import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/methods/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Should include all flyer firestore functions/operations
/// except reading data/getting data for widgets injection
// -----------------------------------------------------------------------------

/// REFERENCES

// ---------------------------------------------------
//   /// flyers collection reference
//   CollectionReference _collRef(){
//     return Fire.getCollectionRef(FireColl.flyers);
//   }
// // -----------------------------------------------------------------------------
//   /// flyer document reference
//   DocumentReference _flyerDocRef(String flyerID){
//     return Fire.getDocRef(
//           collName: FireColl.flyers,
//           docName: flyerID
//       );
//   }
// -----------------------------------------------------------------------------

/// CREATE

// ---------------------------------------------------
/// create empty firestore flyer doc and return flyerID 'docID'
Future<FlyerModel> createFlyerOps({
  @required BuildContext context,
  @required FlyerModel inputFlyerModel,
  @required BzModel bzModel,
}) async {
  blog('1- staring create flyer ops');

  /// create empty firestore flyer document to get back _flyerID
  final DocumentReference<Object> _docRef = await Fire.createDoc(
    context: context,
    collName: FireColl.flyers,
    input: inputFlyerModel.toMap(toJSON: false),
  );

  final String _flyerID = _docRef.id;

  blog('2- flyer doc ID created : $_flyerID');

  /// save slide pictures on fireStorage and get back their URLs
  final List<String> _picturesURLs =
      await Storage.createStorageSlidePicsAndGetURLs(
    context: context,
    slides: inputFlyerModel.slides,
    flyerID: _flyerID,
    authorID: inputFlyerModel.authorID,
  );

  blog('3- _picturesURLs created index 0 is : ${_picturesURLs[0]}');

  /// update slides with URLs
  final List<SlideModel> _updatedSlides =
      await SlideModel.replaceSlidesPicturesWithNewURLs(
          _picturesURLs, inputFlyerModel.slides);

  blog('4- slides updated with URLs');

  /// update FlyerModel with newSlides & flyerURL
  final FlyerModel _finalFlyerModel = FlyerModel(
    id: _flyerID,
    title: inputFlyerModel.title,
    trigram: TextGen.createTrigram(input: inputFlyerModel.title),
    // -------------------------
    flyerType: inputFlyerModel.flyerType,
    flyerState: inputFlyerModel.flyerState,
    keywordsIDs: inputFlyerModel.keywordsIDs,
    showsAuthor: inputFlyerModel.showsAuthor,
    zone: inputFlyerModel.zone,
    // -------------------------
    authorID: inputFlyerModel.authorID,
    bzID: inputFlyerModel.bzID,
    // -------------------------
    position: inputFlyerModel.position,
    // -------------------------
    slides: _updatedSlides,
    // -------------------------
    isBanned: inputFlyerModel.isBanned,
    times: <PublishTime>[
      ...inputFlyerModel.times,
      PublishTime(state: FlyerState.published, time: DateTime.now()),
    ],
    info: inputFlyerModel.info,
    specs: inputFlyerModel.specs,
    priceTagIsOn: inputFlyerModel.priceTagIsOn,
  );

  blog(
      '5- flyer model updated with flyerID, flyerURL & updates slides pic URLs');

  /// replace empty flyer document with the new refactored one _finalFlyerModel
  await Fire.updateDoc(
    context: context,
    collName: FireColl.flyers,
    docName: _flyerID,
    input: _finalFlyerModel.toMap(toJSON: false),
  );

  blog('7- Tiny flyer model added to tinyFlyers/$_flyerID');

  /// add flyer counters sub collection and document in flyer store
  await Fire.createNamedSubDoc(
    context: context,
    collName: FireColl.flyers,
    docName: _flyerID,
    subCollName: FireSubColl.flyers_flyer_counters,
    subDocName: FireSubDoc.flyers_flyer_counters_counters,
    input: await SlideModel.cipherSlidesCounters(_updatedSlides),
  );

  blog('9- flyer counters added');

  /// add flyerID to bz document in 'flyersIDs' field
  final List<String> _bzFlyersIDs = bzModel.flyersIDs;
  _bzFlyersIDs.add(_flyerID);
  await Fire.updateDocField(
    context: context,
    collName: FireColl.bzz,
    docName: _finalFlyerModel.bzID,
    field: 'flyersIDs',
    input: _bzFlyersIDs,
  );

  blog('10- tiny flyer added to bzID in bzz/${_finalFlyerModel.bzID}');

  return _finalFlyerModel;
}
// -----------------------------------------------------------------------------

/// READ

// ---------------------------------------------------
Future<FlyerModel> readFlyerOps({
  @required BuildContext context,
  @required String flyerID,
}) async {

  final dynamic _flyerMap = await Fire.readDoc(
      context: context,
      collName: FireColl.flyers,
      docName: flyerID
  );

  final FlyerModel _flyer = FlyerModel.decipherFlyer(
      map: _flyerMap,
      fromJSON: false
  );

  return _flyer;
}
// ---------------------------------------------------
Future<List<FlyerModel>> readBzFlyers({
  @required BuildContext context,
  @required BzModel bzModel
}) async {
  final List<FlyerModel> _flyers = <FlyerModel>[];

  if (Mapper.canLoopList(bzModel?.flyersIDs)) {
    for (final String id in bzModel.flyersIDs) {
      final FlyerModel _flyer = await readFlyerOps(
        context: context,
        flyerID: id,
      );

      if (_flyer != null) {
        _flyers.add(_flyer);
      }
    }
  }

  return _flyers;
}
// ---------------------------------------------------
Future<List<FlyerModel>> readBzzFlyers({
  @required BuildContext context,
  @required List<BzModel> bzzModels,
}) async {
  final List<FlyerModel> _allFlyers = <FlyerModel>[];

  if (Mapper.canLoopList(bzzModels)) {
    for (final BzModel bz in bzzModels) {
      final List<FlyerModel> _bzFlyers = await FireFlyerOps.readBzFlyers(
        context: context,
        bzModel: bz,
      );

      if (Mapper.canLoopList(_bzFlyers)) {
        _allFlyers.addAll(_bzFlyers);
      }
    }
  }

  return _allFlyers;
}
// ---------------------------------------------------
Future<List<ReviewModel>> readAllReviews({
  @required BuildContext context,
  @required String flyerID,
}) async {
  final List<dynamic> _maps = await Fire.readSubCollectionDocs(
    context: context,
    collName: FireColl.flyers,
    docName: flyerID,
    subCollName: FireSubColl.flyers_flyer_reviews,
    addDocsIDs: true,
    orderBy: 'reviewID',
    addDocSnapshotToEachMap: false,
    limit: 10,

    /// task : paginate in flyer reviews
  );

  final List<ReviewModel> _reviews =
      ReviewModel.decipherReviews(maps: _maps, fromJSON: false);

  return _reviews;
}
// ---------------------------------------------------
Future<List<FlyerModel>> paginateFlyers({
  @required BuildContext context,
  @required ZoneModel zone,
  @required int limit,
  // @required FlyerType flyerType,
  // @required List<Keyword> keywords, or just one keyword
  DocumentSnapshot<Object> startAfter,
}) async {

  final CollectionReference<Object> _collRef = Fire.getCollectionRef(FireColl.flyers);
  QuerySnapshot<Object> _collectionSnapshot;

  /// INITIAL QUERY
  if (startAfter == null){

    final Query _initialQuery = _collRef
        .where('isBanned', isEqualTo: false)
        .where('zone.countryID', isEqualTo: zone.countryID)
        .where('zone.cityID', isEqualTo: zone.cityID)
        // .where('zone.districtID', isEqualTo: zone.districtID)
        // .where('keywordsIDs', arrayContains: keyword.id)
        // .where('flyerType', isEqualTo: flyerType)
        // .orderBy('score')
        .orderBy('id', descending: true) /// temp until we fix the scoring system
        .limit(limit);

    _collectionSnapshot = await _initialQuery.get();

  }

  /// CONTINUE QUERY
  else {

    final Query _continueQuery = _collRef
        .where('isBanned', isEqualTo: false)
        .where('zone.countryID', isEqualTo: zone.countryID)
        .where('zone.cityID', isEqualTo: zone.cityID)
        // .where('zone.districtID', isEqualTo: zone.districtID)
        // .where('keywordsIDs', arrayContains: keyword.id)
        // .where('flyerType', isEqualTo: flyerType)
        // .orderBy('score')
        .orderBy('id', descending: true) /// temp until we fix the scoring system
        .startAfterDocument(startAfter)
        .limit(limit);

    _collectionSnapshot = await _continueQuery.get();
  }

  final List<Map<String, dynamic>> _foundMaps = Mapper.getMapsFromQuerySnapshot(
    querySnapshot: _collectionSnapshot,
    addDocsIDs: true,
    addDocSnapshotToEachMap: true,
  );

  final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
      maps: _foundMaps,
      fromJSON: false,
  );

  return _flyers;
}
// -----------------------------------------------------------------------------

/// UPDATE

// ---------------------------------------------------
Future<FlyerModel> updateFlyerOps({
  @required BuildContext context,
  @required FlyerModel updatedFlyer,
  @required FlyerModel originalFlyer,
  @required BzModel bzModel,
}) async {
  // steps ----------
  /// A - if slides changed
  ///   A1 - loop each slide in updated slides to check which changed
  ///     x1 - if slide pic changed
  ///       a - upload File to fireStorage/slidesPics/slideID and get URL
  ///       b - recreate SlideModel with new pic URL
  ///       c - add the updated slide into the finalSlides
  ///     x2 - if slide pic did not change
  ///       c - add the slide into the finalSlides
  ///   A2 - replace slides in updatedFlyer with the finalSlides
  ///   A3 - clone updatedFlyer into finalFlyer
  /// B - Delete fire storage pictures if updatedFlyer.slides.length > originalFlyer.slides.length
  ///   B1 - get slides IDs which should be deleted starting first index after updatedFlyer.slides.length
  ///   B2 - delete pictures from fireStorage/slidesPics/slideID : slide ID is "flyerID_index"
  /// C - update flyer doc in fireStore/flyers/flyerID
  /// D - if keywords changed, update flyerKeys doc in : fireStore/flyersKeys/flyerID
  /// F - if tinyFlyer is changed, update tinyFlyer doc
  ///   F1 - get FinalTinyFlyer from final Flyer
  ///   F2 - update fireStore/tinyFlyers/flyerID
  // ----------

  FlyerModel _finalFlyer = updatedFlyer;

  blog('besm allah');

  /// A - if slides changed
  if (SlideModel.allSlidesPicsAreTheSame(
          finalFlyer: updatedFlyer, originalFlyer: originalFlyer) ==
      false) {
    blog('A -  slides are not the same');

    /// A1 - loop each slide in updated slides to check which changed
    final List<SlideModel> _finalSlides = <SlideModel>[];
    for (final SlideModel slide in updatedFlyer.slides) {
      blog('A1 - checking slide ${slide.slideIndex}');

      /// x1 - if slide pic changed
      if (ObjectChecker.objectIsFile(slide.pic) == true) {
        blog('x1 - slide ${slide.slideIndex} is FILE');

        /// a - upload File to fireStorage/slidesPics/slideID and get URL
        final String _newPicURL = await Storage.createStoragePicAndGetURL(
          context: context,
          docName: StorageDoc.slides,
          picName:
              SlideModel.generateSlideID(updatedFlyer.id, slide.slideIndex),
          inputFile: slide.pic,
          ownerID: originalFlyer.authorID,
        );

        final ImageSize _imageSize = await ImageSize.superImageSize(slide.pic);

        blog('a - slide ${slide.slideIndex} got this URL : $_newPicURL');

        /// b - recreate SlideModel with new pic URL
        final SlideModel _updatedSlide = SlideModel(
          slideIndex: slide.slideIndex,
          pic: _newPicURL,
          headline: slide.headline,
          description: slide.description,
          // -------------------------
          sharesCount: slide.sharesCount,
          viewsCount: slide.viewsCount,
          savesCount: slide.savesCount,
          imageSize: _imageSize,
          picFit: slide.picFit,
          midColor: slide.midColor,
        );

        /// c - add the updated slide into finalSlides
        _finalSlides.add(_updatedSlide);

        blog('c - slide ${slide.slideIndex} added to the _finalSlides');
      }

      /// x2 - if slide pic did not change
      else {
        /// c - add the slide into finalSlides
        _finalSlides.add(slide);

        blog('c - slide ${slide.slideIndex} is URL');
      }

      blog('A1 - all slides checked');
    }

    /// A2 - replace slides in updatedFlyer with the finalSlides
    final FlyerModel _updatedFlyer =
        FlyerModel.replaceSlides(updatedFlyer, _finalSlides);

    /// A3 - clone updatedFlyer into finalFlyer
    _finalFlyer = _updatedFlyer.clone();
  }

  /// B - Delete fire storage pictures if updatedFlyer.slides.length > originalFlyer.slides.length
  if (originalFlyer.slides.length > _finalFlyer.slides.length) {
    final List<String> _slidesIDsToBeDeleted = <String>[];

    /// B1 - get slides IDs which should be deleted starting first index after updatedFlyer.slides.length
    for (int i = _finalFlyer.slides.length;
        i < originalFlyer.slides.length;
        i++) {
      _slidesIDsToBeDeleted.add(SlideModel.generateSlideID(_finalFlyer.id, i));
    }

    /// B2 - delete pictures from fireStorage/slidesPics/slideID : slide ID is "flyerID_index"
    for (final String slideID in _slidesIDsToBeDeleted) {
      await Storage.deleteStoragePic(
        context: context,
        docName: StorageDoc.slides,
        picName: slideID,
      );
    }
  }

  blog(
      'B - all slides Got URLs and deleted slides have been overridden or deleted');

  /// C - update flyer doc in fireStore/flyers/flyerID
  await Fire.updateDoc(
    context: context,
    collName: FireColl.flyers,
    docName: _finalFlyer.id,
    input: _finalFlyer.toMap(toJSON: false),
  );

  blog('C - flyer updated on fireStore in fireStore/flyers/${_finalFlyer.id}');

  /// D - if keywords changed, update flyerKeys doc in : fireStore/flyersKeys/flyerID
  // if (Mapper.listsAreTheSame(list1: _finalFlyer.keywordsIDs, list2: originalFlyer.keywordsIDs) == false){
  //   await Fire.updateDoc(
  //       context: context,
  //       collName: FireCollection.flyersKeys,
  //       docName: _finalFlyer.flyerID,
  //       input: await TextMod.getKeywordsMap(_finalFlyer.keywordsIDs)
  //   );
  //
  //   blog('D - flyer keywords updated on FireStore');
  //
  // }

  blog('F - finished uploading flyer');

  return _finalFlyer;
}
// ---------------------------------------------------
//   Future<void> switchFlyerShowsAuthor({
//     @required BuildContext context,
//     @required String flyerID,
//     @required bool val
//   }) async {
//     await Fire.updateDocField(
//       context: context,
//       collName: FireColl.flyers,
//       docName: flyerID,
//       field: 'flyerShowsAuthor',
//       input: val,
//     );
//   }
// -----------------------------------------------------------------------------

/// DELETE

// ---------------------------------------------------
Future<void> deactivateFlyerOps(
    {@required BuildContext context,
    @required String flyerID,
    @required BzModel bzModel}) async {
  // steps ----------
  /// C - update fireStore/flyers/flyerID['deletionTime']
  /// D - Update fireStore/flyers/flyerID['flyerState'] to Deactivated
  // ----------

  /// TASK : can merge the below two doc writes into one method later in optimization
  /// C - update fireStore/flyers/flyerID['deletionTime']
  final DateTime _deletionTime = DateTime.now();
  await Fire.updateDocField(
    context: context,
    collName: FireColl.flyers,
    docName: flyerID,
    field: 'deletionTime',
    input: Timers.cipherTime(
      time: _deletionTime,
      toJSON: false,
    ),
  );

  /// D - Update fireStore/flyers/flyerID['flyerState'] to Deactivated
  await Fire.updateDocField(
    context: context,
    collName: FireColl.flyers,
    docName: flyerID,
    field: 'flyerState',
    input: FlyerModel.cipherFlyerState(FlyerState.unpublished),
  );
}

// -----------------------------------------------------------------------------
Future<void> deleteFlyerOps({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required BzModel bzModel,
  @required bool deleteFlyerIDFromBzzFlyersIDs,
}) async {
  // steps ----------
  /// A1 - get flyers IDs of this bzModel
  /// A2 - update fireStore/bzz/bzID['flyersIDs']
  /// D - delete fireStore/flyers/flyerID/views/(all sub docs)
  /// E - delete fireStore/flyers/flyerID/shares/(all sub docs)
  /// F - delete fireStore/flyers/flyerID/saves/(all sub docs)
  /// G - delete fireStore/flyers/flyerID/counters/counters
  /// H - delete fireStorage/slidesPics/slideID for all flyer slides
  /// I - delete firestore/flyers/flyerID
  // ----------

  if (flyerModel != null && flyerModel.id != null && bzModel != null) {
    /// A1 - get flyers IDs of this bzModel
    blog('A1 - get flyers IDs of this bzModel');
    final List<String> _bzFlyersIDs = bzModel.flyersIDs;

    /// A2 - update fireStore/bzz/bzID['flyersIDs']
    if (Mapper.canLoopList(_bzFlyersIDs) &&
        deleteFlyerIDFromBzzFlyersIDs == true) {
      _bzFlyersIDs.remove(flyerModel.id);

      await Fire.updateDocField(
        context: context,
        collName: FireColl.bzz,
        docName: bzModel.id,
        field: 'flyersIDs',
        input: _bzFlyersIDs,
      );
    }

    /// D - delete fireStore/flyers/flyerID/views/(all sub docs)
    blog('D - delete flyer views sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
      subCollName: FireSubColl.flyers_flyer_views,
    );

    /// E - delete fireStore/flyers/flyerID/shares/(all sub docs)
    blog('E - delete shares sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
      subCollName: FireSubColl.flyers_flyer_shares,
    );

    /// F - delete fireStore/flyers/flyerID/saves/(all sub docs)
    blog('F - delete saves sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
      subCollName: FireSubColl.flyers_flyer_saves,
    );

    /// G - delete fireStore/flyers/flyerID/counters/counters
    blog('G - delete counters sub doc');
    await Fire.deleteSubDoc(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
      subCollName: FireSubColl.flyers_flyer_counters,
      subDocName: FireSubDoc.flyers_flyer_counters_counters,
    );

    /// H - delete fireStorage/slidesPics/slideID for all flyer slides
    blog('H - delete flyer slide pics');
    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerModel.id,
      numberOfSlides: flyerModel.slides.length,
    );
    for (final String id in _slidesIDs) {
      blog('a - delete slideHighRes : $id from ${_slidesIDs.length} slides');
      await Storage.deleteStoragePic(
        context: context,
        picName: id,
        docName: StorageDoc.slides,
      );
    }

    /// I - delete firestore/flyers/flyerID
    blog('I - delete flyer doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.id,
    );

    blog(
        'DELETE FLYER OPS ENDED for ${flyerModel.id} ---------------------------');
  }
}
// -----------------------------------------------------------------------------

/// PROMOTION

// ---------------------------------------------------
Future<void> promoteFlyerInCity({
  @required BuildContext context,
  @required FlyerPromotion flyerPromotion,
}) async {

  final Error _error = ArgumentError('promoteFlyerInCity : COULD NOT PROMOTE FLYER [${flyerPromotion?.flyerID ?? '-'} IN CITY [${flyerPromotion?.cityID ?? '-'}]');

  if (flyerPromotion != null){

    await tryAndCatch(
        context: context,
        functions: () async {

          await Fire.createNamedDoc(
              context: context,
              collName: FireColl.flyersPromotions,
              docName: flyerPromotion.flyerID,
              input: flyerPromotion.toMap(),
          );

        },
        onError: (String error){
          throw _error;
        }
    );

  }

  else {
    throw _error;
  }

}
// ---------------------------------------------------
// Future<void> demoteFlyerInCity({
//   @required BuildContext context,
//   @required CityModel cityModel,
//   @required String flyerID,
// }) async {
//
//   if (cityModel != null && flyerID != null){
//
//     cityModel.promotedFlyersIDs.remove(flyerID);
//
//     await Fire.updateSubDocField(
//       context: context,
//       collName: FireColl.zones,
//       docName: FireDoc.zones_cities,
//       subCollName: FireSubColl.zones_cities_cities,
//       subDocName: cityModel.cityID,
//       field: 'promotedFlyersIDs',
//       input: cityModel.promotedFlyersIDs,
//     );
//
//   }
//
// }
// -----------------------------------------------------------------------------