import 'package:bldrs/controllers/drafters/file_formatters.dart';
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
class FlyerCRUD{
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
  List<NanoFlyer> _bzNanoFlyers = bzModel.bzFlyers;
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

    dynamic _flyerMap = await Fire.readDoc(
        context: context,
        collName: FireCollection.flyers,
        docName: flyerID
    );
    FlyerModel _flyer = FlyerModel.decipherFlyerMap(_flyerMap);

    return _flyer;
  }
// -----------------------------------------------------------------------------
  Future<TinyFlyer> readTinyFlyerOps({BuildContext context, String flyerID}) async {

    Map<String, dynamic> _tinyFlyerMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.tinyFlyers,
      docName: flyerID,
    );

    // print(_tinyFlyerMap);

    TinyFlyer _tinyFlyer = _tinyFlyerMap == null ? null : TinyFlyer.decipherTinyFlyerMap(_tinyFlyerMap);

    return _tinyFlyer;

  }
// -----------------------------------------------------------------------------
  Future<FlyerModel> updateFlyerOps({BuildContext context, FlyerModel updatedFlyer, FlyerModel originalFlyer, BzModel bzModel}) async {
    FlyerModel _finalFlyer = updatedFlyer;

    print('besm allah');

    /// if slide pics changed, update pics on storage and get their URL
    if(SlideModel.allSlidesPicsAreTheSame(finalFlyer: updatedFlyer, originalFlyer: originalFlyer) == false){

      print('1 - slides are not the same');

      /// only for the slides which have pics as Files, should upload them and recreate their slideModels
      List<SlideModel> _updatedSlides = new List();
      for (var slide in updatedFlyer.slides){

        print('2a - checking slide ${slide.slideIndex}');

        if (ObjectChecker.objectIsFile(slide.picture) == true){

          print('2aa - slide ${slide.slideIndex} is FILE');

          /// upload file and get url into new SlideModel to add in _updatedSlides
          String _newPicURL = await Fire.createStoragePicAndGetURL(
            context: context,
            picType: PicType.slideHighRes,
            fileName: SlideModel.generateSlideID(updatedFlyer.flyerID, slide.slideIndex),
            inputFile: slide.picture,
          );

          print('2ab - slide ${slide.slideIndex} got this URL : $_newPicURL');

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

          _updatedSlides.add(_updatedSlide);

          print('2ac - slide ${slide.slideIndex} added to the _updatedSlides');

        } else {
          _updatedSlides.add(slide);

          print('2aa - slide ${slide.slideIndex} is URL');

        }

        print('2b - all slides checked');

      }

      FlyerModel _updatedFlyer = FlyerModel.replaceSlides(updatedFlyer, _updatedSlides);

      _finalFlyer = _updatedFlyer.clone();
    }

    /// as updated pics override existing files in fireStorage
    /// only deleted pics that hasn't been overridden should be deleted from fireStorage
    /// Which are the slides in original flyer that have indexes => updatedFlyerSlides.length and < originalFlyerSlides.length
    if(originalFlyer.slides.length > _finalFlyer.slides.length){
      List<String> _slidesIDsToBeDeleted = new List();

      for (int i = _finalFlyer.slides.length; i < originalFlyer.slides.length; i++){
        _slidesIDsToBeDeleted.add(SlideModel.generateSlideID(_finalFlyer.flyerID, i));
      }

      for (var slideID in _slidesIDsToBeDeleted){
        await Fire.deleteStoragePic(
            context: context,
            picType: PicType.slideHighRes,
            fileName: slideID,
        );

      }
    }

    print('2 - all slides Got URLs and deleted slides have been overridden or deleted');

    /// update flyer doc
    await Fire.updateDoc(
      context: context,
      collName: FireCollection.flyers,
      docName: _finalFlyer.flyerID,
      input: _finalFlyer.toMap(),
    );

    print('3 - flyer updated on fireStore');

    /// if keywords changed, update flyerKeys doc
    if (listsAreTheSame(_finalFlyer.keyWords, originalFlyer.keyWords) == false){
      await Fire.updateDoc(
        context: context,
        collName: FireCollection.flyersKeys,
        docName: _finalFlyer.flyerID,
        input: await getKeyWordsMap(_finalFlyer.keyWords)
      );
    }

    print('4 - flyer keywords updated on FireStore');

    /// if nanoFlyer is changed, update it in Bz doc
    if(NanoFlyer.nanoFlyersAreTheSame(_finalFlyer, originalFlyer) == false){
      NanoFlyer _finalNanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyer);

      List<NanoFlyer> _finalBzFlyers = NanoFlyer.replaceNanoFlyerInAList(
          originalNanoFlyers : bzModel.bzFlyers,
          finalNanoFlyer: _finalNanoFlyer
      );

      await Fire.updateDocField(
        context: context,
        collName: FireCollection.bzz,
        docName: bzModel.bzID,
        field: 'bzFlyers',
        input: NanoFlyer.cipherNanoFlyers(_finalBzFlyers),
      );

      print('4a - nano flyer updated');

    }

    print('5 - nano flyer checked and checking tiny flyer');

    /// if tinyFlyer is changed, update tinyFlyer doc
    if(TinyFlyer.tinyFlyersAreTheSame(_finalFlyer, originalFlyer) == false){
      TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyer);

      await Fire.updateDoc(
        context: context,
        collName: FireCollection.tinyFlyers,
        docName: _finalFlyer.flyerID,
        input: _finalTinyFlyer.toMap(),
      );

      print('5a - tiny flyer updated on FireStore');

    }

    print('6 - finishied uploading flyer');

    return _finalFlyer;
}
// -----------------------------------------------------------------------------
  Future<void> deactivateFlyerOps({BuildContext context,String flyerID, BzModel bzModel}) async {

    /// delete nano flyer from bzFlyers and update the list in bz doc
    List<NanoFlyer> _bzNanoFlyers = bzModel.bzFlyers;
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

    /// trigger flyer Deletion field by adding a timeStamp
    DateTime _deletionTime = DateTime.now();
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      field: 'deletionTime',
      input: cipherDateTimeToString(_deletionTime),
    );

}
// -----------------------------------------------------------------------------
  Future<void> deleteFlyerOps({BuildContext context,FlyerModel flyerModel, BzModel bzModel}) async {

    print('1 - delete nano flyer in bzFlyers');
    List<NanoFlyer> _bzFlyers = bzModel.bzFlyers;
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
}
