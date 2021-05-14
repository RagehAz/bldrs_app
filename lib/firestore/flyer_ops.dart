import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Should include all flyer firestore functions/operations
/// except reading data/getting data for widgets injection
class FlyerOps{
  /// flyers collection reference
  CollectionReference flyersCollectionRef(){
    return
      Fire.getCollectionRef(FireCollection.flyers);
  }
// -----------------------------------------------------------------------------
  /// flyer document reference
  DocumentReference flyerDocRef(String flyerID){
    return
      Fire.getDocRef(FireCollection.flyers, flyerID);
  }
// -----------------------------------------------------------------------------
  /// create empty firestore flyer doc and return flyerID 'docID'
  Future<FlyerModel> createFlyerOps(BuildContext context, FlyerModel inputFlyerModel, BzModel bzModel) async {

    print('1- staring create flyer ops');

  /// create empty firestore flyer document to get back _flyerID
  DocumentReference _docRef = await Fire.createDoc(
    context: context,
    collName: FireCollection.flyers,
    input: {},
  );
  String _flyerID = _docRef.id;

  print('2- flyer doc ID created : $_flyerID');

    /// save slide pictures on fireStorage and get back their URLs
  List<String> _picturesURLs = await Fire.createStorageSlidePicsAndGetURLs(
      context: context,
      slides: inputFlyerModel.slides,
      flyerID: _flyerID,
  );

  print('3- _picturesURLs created index 0 is : ${_picturesURLs[0]}');

    /// update slides with URLs
  List<SlideModel> _updatedSlides = await SlideModel.replaceSlidesPicturesWithNewURLs(_picturesURLs, inputFlyerModel.slides);

  print('4- slides updated with URLs');

    /// TASK : generate flyerURL
  String _flyerURL = 'www.bldrs.net' ;

  /// update FlyerModel with newSlides & flyerURL
  FlyerModel _finalFlyerModel = FlyerModel(
    flyerID: _flyerID,
    // -------------------------
    flyerType: inputFlyerModel.flyerType,
    flyerState: inputFlyerModel.flyerState,
    keyWords: inputFlyerModel.keyWords,
    flyerShowsAuthor: inputFlyerModel.flyerShowsAuthor,
    flyerURL: _flyerURL,
    flyerZone: inputFlyerModel.flyerZone,
    // -------------------------
    tinyAuthor: inputFlyerModel.tinyAuthor,
    tinyBz: inputFlyerModel.tinyBz,
    // -------------------------
    publishTime: DateTime.now(),
    flyerPosition: inputFlyerModel.flyerPosition,
    // -------------------------
    ankhIsOn: false,
    // -------------------------
    slides: _updatedSlides,
    // -------------------------
    flyerIsBanned: inputFlyerModel.flyerIsBanned,
    deletionTime: inputFlyerModel.deletionTime,
  );

    print('5- flyer model updated with flyerID, flyerURL & updates slides pic URLs');

    /// replace empty flyer document with the new refactored one _finalFlyerModel
  await Fire.updateDoc(
    context: context,
    collName: FireCollection.flyers,
    docName: _flyerID,
    input: _finalFlyerModel.toMap(),
  );

    print('6- flyer model added to flyers/$_flyerID');

    /// add new TinyFlyer in firestore
  TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyerModel);
  await Fire.createNamedDoc(
    context: context,
    collName: FireCollection.tinyFlyers,
    docName: _flyerID,
    input: _finalTinyFlyer.toMap(),
  );

    print('7- Tiny flyer model added to tinyFlyers/$_flyerID');

    /// add new flyerKeys in fireStore
    /// TASK : perform string.toLowerCase() on each string before upload
  await Fire.createNamedDoc(
    context: context,
    collName: FireCollection.flyersKeys,
    docName: _flyerID,
    input: await getKeyWordsMap(_finalFlyerModel.keyWords),
  );

    print('8- flyer keys add');

    /// add flyer counters sub collection and document in flyer store
  await Fire.createNamedSubDoc(
    context: context,
    collName: FireCollection.flyers,
    docName: _flyerID,
    subCollName: FireCollection.subFlyerCounters,
    subDocName: FireCollection.subFlyerCounters,
    input: await SlideModel.cipherSlidesCounters(_updatedSlides),
  );

    print('9- flyer counters added');

    /// add nano flyer to bz document in 'bzFlyers' field
  List<NanoFlyer> _bzNanoFlyers = bzModel.nanoFlyers;
  NanoFlyer _finalNanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyerModel);
    _bzNanoFlyers.add(_finalNanoFlyer);
  await Fire.updateDocField(
    context: context,
    collName: FireCollection.bzz,
    docName: _finalFlyerModel.tinyBz.bzID,
    field: 'bzFlyers',
    input: NanoFlyer.cipherNanoFlyers(_bzNanoFlyers),
  );

    print('10- tiny flyer added to bzID in bzz/${_finalFlyerModel.tinyBz.bzID}');

    return _finalFlyerModel;
}
// -----------------------------------------------------------------------------
  Future<FlyerModel> readFlyerOps({BuildContext context, String flyerID}) async {

    dynamic _flyerMap = await Fire().readDoc(
        context: context,
        collName: FireCollection.flyers,
        docName: flyerID
    );
    FlyerModel _flyer = FlyerModel.decipherFlyerMap(_flyerMap);

    return _flyer;
  }
// -----------------------------------------------------------------------------
  Future<TinyFlyer> readTinyFlyerOps({BuildContext context, String flyerID}) async {

    Map<String, dynamic> _tinyFlyerMap = await Fire().readDoc(
      context: context,
      collName: FireCollection.tinyFlyers,
      docName: flyerID,
    );

    // print(_tinyFlyerMap);

    TinyFlyer _tinyFlyer = _tinyFlyerMap == null ? null : TinyFlyer.decipherTinyFlyerMap(_tinyFlyerMap);

    return _tinyFlyer;

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
  /// E - if nanoFlyer is changed, update it in Bz doc
  ///   E1 - get finalNanoFlyer from finalFlyer
  ///   E2 - replace originalNanoFlyer in bzModel with the finalNanoFlyer
  ///   E3 - update fireStore/bzz/bzID['bzFlyers'] with the updated nanoFlyers list
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
      List<SlideModel> _finalSlides = new List();
      for (var slide in updatedFlyer.slides){

        print('A1 - checking slide ${slide.slideIndex}');

        /// x1 - if slide pic changed
        if (ObjectChecker.objectIsFile(slide.picture) == true){

          print('x1 - slide ${slide.slideIndex} is FILE');

          /// a - upload File to fireStorage/slidesPics/slideID and get URL
          String _newPicURL = await Fire.createStoragePicAndGetURL(
            context: context,
            picType: PicType.slideHighRes,
            fileName: SlideModel.generateSlideID(updatedFlyer.flyerID, slide.slideIndex),
            inputFile: slide.picture,
          );

          print('a - slide ${slide.slideIndex} got this URL : $_newPicURL');

          /// b - recreate SlideModel with new pic URL
          SlideModel _updatedSlide = SlideModel(
            slideIndex : slide.slideIndex,
            picture : _newPicURL,
            headline : slide.headline,
            description : slide.description,
            // -------------------------
            sharesCount : slide.sharesCount,
            viewsCount : slide.viewsCount,
            savesCount : slide.savesCount,
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
      FlyerModel _updatedFlyer = FlyerModel.replaceSlides(updatedFlyer, _finalSlides);

      /// A3 - clone updatedFlyer into finalFlyer
      _finalFlyer = _updatedFlyer.clone();
    }

    /// B - Delete fire storage pictures if updatedFlyer.slides.length > originalFlyer.slides.length
    if(originalFlyer.slides.length > _finalFlyer.slides.length){
      List<String> _slidesIDsToBeDeleted = new List();

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
      collName: FireCollection.flyers,
      docName: _finalFlyer.flyerID,
      input: _finalFlyer.toMap(),
    );

    print('C - flyer updated on fireStore in fireStore/flyers/${_finalFlyer.flyerID}');

    /// D - if keywords changed, update flyerKeys doc in : fireStore/flyersKeys/flyerID
    if (TextChecker.listsAreTheSame(_finalFlyer.keyWords, originalFlyer.keyWords) == false){
      await Fire.updateDoc(
          context: context,
          collName: FireCollection.flyersKeys,
          docName: _finalFlyer.flyerID,
          input: await getKeyWordsMap(_finalFlyer.keyWords)
      );

      print('D - flyer keywords updated on FireStore');

    }


    /// E - if nanoFlyer is changed, update it in Bz doc
    if(NanoFlyer.nanoFlyersAreTheSame(_finalFlyer, originalFlyer) == false){

      /// E1 - get finalNanoFlyer from finalFlyer
      NanoFlyer _finalNanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyer);

      /// E2 - replace originalNanoFlyer in bzModel with the finalNanoFlyer
      List<NanoFlyer> _finalBzFlyers = NanoFlyer.replaceNanoFlyerInAList(
          originalNanoFlyers : bzModel.nanoFlyers,
          finalNanoFlyer: _finalNanoFlyer
      );

      /// E3 - update fireStore/bzz/bzID['bzFlyers'] with the updated nanoFlyers list
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.bzz,
        docName: bzModel.bzID,
        field: 'bzFlyers',
        input: NanoFlyer.cipherNanoFlyers(_finalBzFlyers),
      );

      print('E - nano flyer updated');

    }

    print('E - nano flyer checked and checking tiny flyer');

    /// F - if tinyFlyer is changed, update tinyFlyer doc
    if(TinyFlyer.tinyFlyersAreTheSame(_finalFlyer, originalFlyer) == false){

      /// F1 - get FinalTinyFlyer from final Flyer
      TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyer);

      /// F2 - update fireStore/tinyFlyers/flyerID
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.tinyFlyers,
        docName: _finalFlyer.flyerID,
        input: _finalTinyFlyer.toMap(),
      );

      print('F - tiny flyer updated on FireStore');

    }

    print('F - finished uploading flyer');

    return _finalFlyer;
  }
// -----------------------------------------------------------------------------
  Future<void> deactivateFlyerOps({BuildContext context,String flyerID, BzModel bzModel}) async {

    /// delete nano flyer from bzFlyers and update the list in bz doc
    List<NanoFlyer> _bzNanoFlyers = bzModel.nanoFlyers;
    int _nanoFlyerIndex = _bzNanoFlyers.indexWhere((nanoFlyer) => nanoFlyer.flyerID == flyerID);
    _bzNanoFlyers.removeAt(_nanoFlyerIndex);
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
      field: 'bzFlyers',
      input: NanoFlyer.cipherNanoFlyers(_bzNanoFlyers),
    );

    /// delete tinyFlyer
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.tinyFlyers,
      docName: flyerID,
    );

    /// TASK : can merge the below two doc writes into one method later in optimization
    /// trigger flyer Deletion field by adding a timeStamp
    DateTime _deletionTime = DateTime.now();
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      field: 'deletionTime',
      input: cipherDateTimeToString(_deletionTime),
    );

    /// change flyerState to Deactivated
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      field: 'flyerState',
      input: FlyerModel.cipherFlyerState(FlyerState.DeActivated),
    );

}
// -----------------------------------------------------------------------------
  Future<void> deleteFlyerOps({BuildContext context,FlyerModel flyerModel, BzModel bzModel}) async {

    print('1 - delete nano flyer in bzFlyers');
    List<NanoFlyer> _bzFlyers = bzModel.nanoFlyers;
    List<NanoFlyer> _modifiedNanoFlyers= NanoFlyer.removeNanoFlyerFromNanoFlyers(_bzFlyers, flyerModel.flyerID);
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
      field: 'bzFlyers',
      input: NanoFlyer.cipherNanoFlyers(_modifiedNanoFlyers),
    );

    print('2 - delete tiny flyer doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.tinyFlyers,
      docName: flyerModel.flyerID,
    );

    print('3 - delete flyer keys doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.flyersKeys,
      docName: flyerModel.flyerID,
    );

    print('4 - delete flyer views sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireCollection.subFlyerViews,
    );

    print('5 - wont delete flyer view sub collection');
    // dunno if could be done here

    print('6 - delete shares sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireCollection.subFlyerShares,
    );

    print('7 - wont delete shares sub collection');
    // dunno if could be done here

    print('8 - delete saves sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerModel.flyerID,
      subCollName: FireCollection.subFlyerSaves,
    );

    print('9 - wont delete saves sub collection');
    // dunno if could be done here

    print('10 - delete counters sub doc');
    await Fire.deleteSubDoc(
        context: context,
        collName: FireCollection.flyers,
        docName: flyerModel.flyerID,
        subCollName: FireCollection.subFlyerCounters,
        subDocName: FireCollection.subFlyerCounters
    );

    print('11 - wont delete counters sub collection');
    // dunno if could be done here

    print('12 - delete flyer slide pics');
    List<String> _slidesIDs = SlideModel.generateSlidesIDs(flyerModel);
    for (var id in _slidesIDs){

      print('a - delete slideHighRes : $id from ${_slidesIDs.length} slides');
      await Fire.deleteStoragePic(
        context: context,
        fileName: id,
        picType: PicType.slideHighRes,
      );

      // print('b - delete slideLowRes : $id from ${_slidesIDs.length} slides');
      // await Fire.deleteStoragePic(
      //   context: context,
      //   fileName: id,
      //   picType: PicType.slideLowRes,
      // );

    }

    print('13 - delete flyer doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerModel.flyerID,
    );

    print('DELETE FLYER OPS ENDED ---------------------------');

  }
// =============================================================================
  Future<void> switchFlyerShowsAuthor({BuildContext context, String flyerID, bool val}) async {
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      field: 'flyerShowsAuthor',
      input: val,
    );
  }
// -----------------------------------------------------------------------------
}
