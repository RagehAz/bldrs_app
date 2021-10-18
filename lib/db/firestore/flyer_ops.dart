import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/records/publish_time_model.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/helpers/image_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Should include all flyer firestore functions/operations
/// except reading data/getting data for widgets injection
class FlyerOps{
  /// flyers collection reference
  CollectionReference flyersCollectionRef(){
    return
      Fire.getCollectionRef(FireColl.flyers);
  }
// -----------------------------------------------------------------------------
  /// flyer document reference
  DocumentReference flyerDocRef(String flyerID){
    return
      Fire.getDocRef(
          collName: FireColl.flyers,
          docName: flyerID
      );
  }
// -----------------------------------------------------------------------------
  /// create empty firestore flyer doc and return flyerID 'docID'
  Future<FlyerModel> createFlyerOps(BuildContext context, FlyerModel inputFlyerModel, BzModel bzModel) async {

    print('1- staring create flyer ops');

    /// create empty firestore flyer document to get back _flyerID
    final DocumentReference _docRef = await Fire.createDoc(
      context: context,
      collName: FireColl.flyers,
      input: inputFlyerModel.toMap(toJSON: false),
    );

    final String _flyerID = _docRef.id;

    print('2- flyer doc ID created : $_flyerID');

    /// save slide pictures on fireStorage and get back their URLs
    final List<String> _picturesURLs = await Fire.createStorageSlidePicsAndGetURLs(
      context: context,
      slides: inputFlyerModel.slides,
      flyerID: _flyerID,
    );

    print('3- _picturesURLs created index 0 is : ${_picturesURLs[0]}');

    /// update slides with URLs
    final List<SlideModel> _updatedSlides = await SlideModel.replaceSlidesPicturesWithNewURLs(_picturesURLs, inputFlyerModel.slides);

    print('4- slides updated with URLs');

    /// update FlyerModel with newSlides & flyerURL
    final FlyerModel _finalFlyerModel = FlyerModel(
      flyerID: _flyerID,
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

    print('5- flyer model updated with flyerID, flyerURL & updates slides pic URLs');

    /// replace empty flyer document with the new refactored one _finalFlyerModel
    await Fire.updateDoc(
      context: context,
      collName: FireColl.flyers,
      docName: _flyerID,
      input: _finalFlyerModel.toMap(toJSON: false),
    );


    print('7- Tiny flyer model added to tinyFlyers/$_flyerID');


    /// add flyer counters sub collection and document in flyer store
  await Fire.createNamedSubDoc(
    context: context,
    collName: FireColl.flyers,
    docName: _flyerID,
    subCollName: FireColl.flyers_flyer_counters,
    subDocName: FireColl.flyers_flyer_counters,
    input: await SlideModel.cipherSlidesCounters(_updatedSlides),
  );

  print('9- flyer counters added');

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

    print('10- tiny flyer added to bzID in bzz/${_finalFlyerModel.bzID}');

    return _finalFlyerModel;
  }
// -----------------------------------------------------------------------------
  static Future<FlyerModel> readFlyerOps({BuildContext context, String flyerID}) async {

    final dynamic _flyerMap = await Fire.readDoc(
        context: context,
        collName: FireColl.flyers,
        docName: flyerID
    );

    final FlyerModel _flyer = FlyerModel.decipherFlyer(map: _flyerMap, fromJSON: false);

    return _flyer;
  }
// -----------------------------------------------------------------------------
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
  Future<FlyerModel> updateFlyerOps({BuildContext context, FlyerModel updatedFlyer, FlyerModel originalFlyer, BzModel bzModel}) async {
    FlyerModel _finalFlyer = updatedFlyer;

    print('besm allah');

    /// A - if slides changed
    if(SlideModel.allSlidesPicsAreTheSame(finalFlyer: updatedFlyer, originalFlyer: originalFlyer) == false){

      print('A -  slides are not the same');

      /// A1 - loop each slide in updated slides to check which changed
      final List<SlideModel> _finalSlides = <SlideModel>[];
      for (var slide in updatedFlyer.slides){

        print('A1 - checking slide ${slide.slideIndex}');

        /// x1 - if slide pic changed
        if (ObjectChecker.objectIsFile(slide.pic) == true){

          print('x1 - slide ${slide.slideIndex} is FILE');

          /// a - upload File to fireStorage/slidesPics/slideID and get URL
          final String _newPicURL = await Fire.createStoragePicAndGetURL(
            context: context,
            picType: PicType.slideHighRes,
            fileName: SlideModel.generateSlideID(updatedFlyer.flyerID, slide.slideIndex),
            inputFile: slide.pic,
          );

          final ImageSize _imageSize = await ImageSize.superImageSize(slide.pic);

          print('a - slide ${slide.slideIndex} got this URL : $_newPicURL');

          /// b - recreate SlideModel with new pic URL
          final SlideModel _updatedSlide = SlideModel(
            slideIndex : slide.slideIndex,
            pic : _newPicURL,
            headline : slide.headline,
            description : slide.description,
            // -------------------------
            sharesCount : slide.sharesCount,
            viewsCount : slide.viewsCount,
            savesCount : slide.savesCount,
            imageSize: _imageSize,
            picFit: slide.picFit,
            midColor: slide.midColor,
          );

          /// c - add the updated slide into finalSlides
          _finalSlides.add(_updatedSlide);

          print('c - slide ${slide.slideIndex} added to the _finalSlides');

        }

        /// x2 - if slide pic did not change
        else {

          /// c - add the slide into finalSlides
          _finalSlides.add(slide);

          print('c - slide ${slide.slideIndex} is URL');

        }

        print('A1 - all slides checked');

      }

      /// A2 - replace slides in updatedFlyer with the finalSlides
      final FlyerModel _updatedFlyer = FlyerModel.replaceSlides(updatedFlyer, _finalSlides);

      /// A3 - clone updatedFlyer into finalFlyer
      _finalFlyer = _updatedFlyer.clone();
    }

    /// B - Delete fire storage pictures if updatedFlyer.slides.length > originalFlyer.slides.length
    if(originalFlyer.slides.length > _finalFlyer.slides.length){
      final List<String> _slidesIDsToBeDeleted = <String>[];

      /// B1 - get slides IDs which should be deleted starting first index after updatedFlyer.slides.length
      for (int i = _finalFlyer.slides.length; i < originalFlyer.slides.length; i++){
        _slidesIDsToBeDeleted.add(SlideModel.generateSlideID(_finalFlyer.flyerID, i));
      }

      /// B2 - delete pictures from fireStorage/slidesPics/slideID : slide ID is "flyerID_index"
      for (var slideID in _slidesIDsToBeDeleted){
        await Fire.deleteStoragePic(
          context: context,
          picType: PicType.slideHighRes,
          fileName: slideID,
        );
      }

    }

    print('B - all slides Got URLs and deleted slides have been overridden or deleted');

    /// C - update flyer doc in fireStore/flyers/flyerID
    await Fire.updateDoc(
      context: context,
      collName: FireColl.flyers,
      docName: _finalFlyer.flyerID,
      input: _finalFlyer.toMap(toJSON: false),
    );

    print('C - flyer updated on fireStore in fireStore/flyers/${_finalFlyer.flyerID}');

    /// D - if keywords changed, update flyerKeys doc in : fireStore/flyersKeys/flyerID
    // if (Mapper.listsAreTheSame(list1: _finalFlyer.keywordsIDs, list2: originalFlyer.keywordsIDs) == false){
    //   await Fire.updateDoc(
    //       context: context,
    //       collName: FireCollection.flyersKeys,
    //       docName: _finalFlyer.flyerID,
    //       input: await TextMod.getKeywordsMap(_finalFlyer.keywordsIDs)
    //   );
    //
    //   print('D - flyer keywords updated on FireStore');
    //
    // }


    print('F - finished uploading flyer');

    return _finalFlyer;
  }
// -----------------------------------------------------------------------------
  // /// A1 - remove nano flyer from bz nanoFlyers
  // /// A2 - update fireStore/bzz/bzID['nanoFlyers']
  // ///  B - Delete fireStore/tinyFlyers/flyerID
  /// C - update fireStore/flyers/flyerID['deletionTime']
  /// D - Update fireStore/flyers/flyerID['flyerState'] to Deactivated
  Future<void> deactivateFlyerOps({BuildContext context,String flyerID, BzModel bzModel}) async {

    // /// A1 - remove nano flyer from bz nanoFlyers
    // final List<String> _bzFlyersIDs = bzModel.flyersIDs;
    // _bzFlyersIDs.remove(flyerID);

    // /// A2 - update fireStore/bzz/bzID['nanoFlyers']
    // await Fire.updateDocField(
    //   context: context,
    //   collName: FireCollection.bzz,
    //   docName: bzModel.bzID,
    //   field: 'nanoFlyers',
    //   input: NanoFlyer.cipherNanoFlyers(_updatedBzNanoFlyers),
    // );

    // /// B - Delete fireStore/tinyFlyers/flyerID
    // await Fire.deleteDoc(
    //   context: context,
    //   collName: FireCollection.tinyFlyers,
    //   docName: flyerID,
    // );

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
  /// A1 - remove nano flyer from bz nanoFlyers
  /// A2 - update fireStore/bzz/bzID['nanoFlyers']
  /// D - delete fireStore/flyers/flyerID/views/(all sub docs)
  /// E - delete fireStore/flyers/flyerID/shares/(all sub docs)
  /// F - delete fireStore/flyers/flyerID/saves/(all sub docs)
  /// G - delete fireStore/flyers/flyerID/counters/counters
  /// H - delete fireStorage/slidesPics/slideID for all flyer slides
  /// I - delete firestore/flyers/flyerID
  Future<void> deleteFlyerOps({BuildContext context,FlyerModel flyerModel, BzModel bzModel}) async {

    /// A1 - remove nano flyer from bz nanoFlyers
    print('A1 - remove nano flyer from bz nanoFlyers');
    final List<String> _bzFlyersIDs = bzModel.flyersIDs;

    /// A2 - update fireStore/bzz/bzID['nanoFlyers']
    if (Mapper.canLoopList(_bzFlyersIDs)){

      _bzFlyersIDs.remove(flyerModel.flyerID);

      await Fire.updateDocField(
        context: context,
        collName: FireColl.bzz,
        docName: bzModel.bzID,
        field: 'flyersIDs',
        input: _bzFlyersIDs,
      );
    }


    /// D - delete fireStore/flyers/flyerID/views/(all sub docs)
    print('D - delete flyer views sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireColl.flyers_flyer_views,
    );

    /// E - delete fireStore/flyers/flyerID/shares/(all sub docs)
    print('E - delete shares sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireColl.flyers_flyer_shares,
    );

    /// F - delete fireStore/flyers/flyerID/saves/(all sub docs)
    print('F - delete saves sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireColl.flyers_flyer_saves,
    );

    /// G - delete fireStore/flyers/flyerID/counters/counters
    print('G - delete counters sub doc');
    await Fire.deleteSubDoc(
        context: context,
        collName: FireColl.flyers,
        docName: flyerModel.flyerID,
        subCollName: FireColl.flyers_flyer_counters,
        subDocName: FireColl.flyers_flyer_counters
    );

    /// H - delete fireStorage/slidesPics/slideID for all flyer slides
    print('H - delete flyer slide pics');
    final List<String> _slidesIDs = SlideModel.generateSlidesIDs(
      flyerID: flyerModel.flyerID,
      numberOfSlides: flyerModel.slides.length,
    );
    for (var id in _slidesIDs){

      print('a - delete slideHighRes : $id from ${_slidesIDs.length} slides');
      await Fire.deleteStoragePic(
        context: context,
        fileName: id,
        picType: PicType.slideHighRes,
      );

    }

    /// I - delete firestore/flyers/flyerID
    print('I - delete flyer doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireColl.flyers,
      docName: flyerModel.flyerID,
    );

    print('DELETE FLYER OPS ENDED ---------------------------');

  }
// =============================================================================
  Future<void> switchFlyerShowsAuthor({BuildContext context, String flyerID, bool val}) async {
    await Fire.updateDocField(
      context: context,
      collName: FireColl.flyers,
      docName: flyerID,
      field: 'flyerShowsAuthor',
      input: val,
    );
  }
// -----------------------------------------------------------------------------
  static Future<List<ReviewModel>> readAllReviews({BuildContext context, String flyerID,}) async {
    final List<dynamic> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireColl.flyers,
      docName: flyerID,
      subCollName: FireColl.flyers_flyer_reviews,
      addDocsIDs: true,
    );

    final List<ReviewModel> _reviews = ReviewModel.decipherReviews(maps: _maps, fromJSON: false);

    return _reviews;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readBzFlyers({BuildContext context, BzModel bzModel}) async {
    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.canLoopList(bzModel?.flyersIDs)){
      for (String id in bzModel.flyersIDs){

        final FlyerModel _flyer = await readFlyerOps(
          context: context,
          flyerID: id,
        );

        if (_flyer != null){

          _flyers.add(_flyer);

        }
      }
    }

    return _flyers;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readBzzFlyers({BuildContext context, List<BzModel> bzzModels}) async {
    final List<FlyerModel> _allFlyers = <FlyerModel>[];

    if (Mapper.canLoopList(bzzModels)){
      for (BzModel bz in bzzModels){

        final List<FlyerModel> _bzFlyers = await FlyerOps.readBzFlyers(
          context: context,
          bzModel: bz,
        );

        if (Mapper.canLoopList(_bzFlyers)){
          _allFlyers.addAll(_bzFlyers);
        }

      }
    }

    return _allFlyers;
  }
// -----------------------------------------------------------------------------
}
