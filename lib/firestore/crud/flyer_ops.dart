import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_storage.dart';
import '../firestore.dart';

/// Should include all flyer firestore functions/operations
/// except reading data/getting data for widgets injection
class FlyerCRUD{
  /// flyers collection reference
  CollectionReference flyersCollectionRef(){
    return
      getFirestoreCollectionReference(FireStoreCollection.flyers);
  }
// ---------------------------------------------------------------------------
  /// flyer document reference
  DocumentReference flyerDocRef(String flyerID){
    return
      getFirestoreDocumentReference(FireStoreCollection.flyers, flyerID);
  }
// ---------------------------------------------------------------------------
  final CollectionReference _flyersCollectionRef = getFirestoreCollectionReference(FireStoreCollection.flyers);
// ---------------------------------------------------------------------------
  /// create empty firestore flyer doc and return flyerID 'docID'
  Future<FlyerModel> createFlyerOps(BuildContext context, FlyerModel inputFlyerModel, BzModel bzModel) async {

    print('1- staring create flyer ops');

  /// create empty firestore flyer document to get back _flyerID
  DocumentReference _docRef = await createFireStoreDocument(
    context: context,
    collectionName: FireStoreCollection.flyers,
    input: {},
  );
  String _flyerID = _docRef.id;

  print('2- flyer doc ID created : $_flyerID');

    /// save slide pictures on fireStorage and get back their URLs
  List<String> _picturesURLs = await savePicturesToFireStorageAndGetListOfURL(context, inputFlyerModel.slides, _flyerID);

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
  );

    print('5- flyer model updated with flyerID, flyerURL & updates slides pic URLs');

    /// replace empty flyer document with the new refactored one _finalFlyerModel
  await replaceFirestoreDocument(
    context: context,
    collectionName: FireStoreCollection.flyers,
    docName: _flyerID,
    input: _finalFlyerModel.toMap(),
  );

    print('6- flyer model added to flyers/$_flyerID');

    /// add new TinyFlyer in firestore
  TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyerModel);
  await createFireStoreNamedDocument(
    context: context,
    collectionName: FireStoreCollection.tinyFlyers,
    docName: _flyerID,
    input: _finalTinyFlyer.toMap(),
  );

    print('7- Tiny flyer model added to tinyFlyers/$_flyerID');

    /// add new flyerKeys in fireStore
    /// TASK : perform string.toLowerCase() on each string before upload
  await createFireStoreNamedDocument(
    context: context,
    collectionName: FireStoreCollection.flyersKeys,
    docName: _flyerID,
    input: await getKeyWordsMap(_finalFlyerModel.keyWords),
  );

    print('8- flyer keys add');

    /// add flyer counters sub collection and document in flyer store
  await insertFireStoreSubDocument(
    context: context,
    collectionName: FireStoreCollection.flyers,
    docName: _flyerID,
    subCollectionName: FireStoreCollection.subFlyerCounters,
    subDocName: FireStoreCollection.subFlyerCounters,
    input: await SlideModel.cipherSlidesCounters(_updatedSlides),
  );

    print('9- flyer counters added');

    /// add nano flyer to bz document in 'bzFlyers' field
  List<NanoFlyer> _bzNanoFlyers = bzModel.bzFlyers;
  NanoFlyer _finalNanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyerModel);
    _bzNanoFlyers.add(_finalNanoFlyer);
  await updateFieldOnFirestore(
      context: context,
      collectionName: FireStoreCollection.bzz,
      documentName: _finalFlyerModel.tinyBz.bzID,
      field: 'bzFlyers',
      input: NanoFlyer.cipherNanoFlyers(_bzNanoFlyers),
  );

    print('10- tiny flyer added to bzID in bzz/${_finalFlyerModel.tinyBz.bzID}');

    return _finalFlyerModel;
}
// ----------------------------------------------------------------------
//   static Future<FlyerModel> readFlyerOps({BuildContext context, String flyerID}) async {
//
//     dynamic _flyerMap = await getFireStoreDocumentMap(
//         context: context,
//         collectionName: FireStoreCollection.flyers,
//         documentName: flyerID
//     );
//     FlyerModel _flyer = FlyerModel.decipherFlyerMap(_flyerMap);
//
//     return _flyer;
//   }
// ----------------------------------------------------------------------
  Future<void> updateFlyerOps({BuildContext context, FlyerModel updatedFlyer, FlyerModel originalFlyer}) async {
    FlyerModel _finalFlyer = updatedFlyer;
    /// if slide pics changed, update pics on storage and get their URL
    if(SlideModel.allSlidesPicsAreTheSame(updatedFlyer, originalFlyer) == false){

      /// save slide pictures on fireStorage and get back their URLs
      /// TASK : should check which slide pic was changed first then update only the changed one
      List<String> _picturesURLs = await savePicturesToFireStorageAndGetListOfURL(context, updatedFlyer.slides, updatedFlyer.flyerID);

      /// update slides with URLs
      List<SlideModel> _updatedSlides = await SlideModel.replaceSlidesPicturesWithNewURLs(_picturesURLs, updatedFlyer.slides);

      FlyerModel _updatedFlyer = FlyerModel.replaceSlides(updatedFlyer, _updatedSlides);

      _finalFlyer = _updatedFlyer;
    }

    /// update flyer doc
    await replaceFirestoreDocument(
      context: context,
      collectionName: FireStoreCollection.flyers,
      docName: _finalFlyer.flyerID,
      input: _finalFlyer.toMap(),
    );

    /// if keywords changed, update flyerKeys doc
    if (listsAreTheSame(_finalFlyer.keyWords, originalFlyer.keyWords) == false){
      await replaceFirestoreDocument(
        context: context,
        collectionName: FireStoreCollection.flyersKeys,
        docName: _finalFlyer.flyerID,
        input: await getKeyWordsMap(_finalFlyer.keyWords)
      );
    }

    /// if nanoFlyer is changed, update it in Bz doc
    if(NanoFlyer.nanoFlyersAreTheSame(_finalFlyer, originalFlyer) == false){
      NanoFlyer _finalNanoFlyer = NanoFlyer.getNanoFlyerFromFlyerModel(_finalFlyer);

      BzModel _bzModel = await BzCRUD.readBzOps(context: context, bzID : _finalFlyer.tinyBz.bzID);
      List<NanoFlyer> _finalBzFlyers = NanoFlyer.replaceNanoFlyerInAList(
          originalNanoFlyers :_bzModel.bzFlyers,
          finalNanoFlyer:  _finalNanoFlyer
      );

      await updateFieldOnFirestore(
        context: context,
        collectionName: FireStoreCollection.bzz,
        documentName: _bzModel.bzID,
        field: 'bzFlyers',
        input: NanoFlyer.cipherNanoFlyers(_finalBzFlyers),
      );

    }

    /// if tinyFlyer is changed, update tinyFlyer doc
    if(TinyFlyer.tinyFlyersAreTheSame(_finalFlyer, originalFlyer) == false){
      TinyFlyer _finalTinyFlyer = TinyFlyer.getTinyFlyerFromFlyerModel(_finalFlyer);

      await replaceFirestoreDocument(
        context: context,
        collectionName: FireStoreCollection.tinyFlyers,
        docName: _finalFlyer.flyerID,
        input: _finalTinyFlyer.toMap(),
      );
    }

}
// ----------------------------------------------------------------------
  Future<void> deleteFlyerOps(String flyerID) async {
  final DocumentReference _flyerDocRef = flyerDocRef(flyerID);
  await _flyerDocRef.delete();
}
// ----------------------------------------------------------------------
  Future<void> updateFlyerDoc(FlyerModel flyerModel) async {
    await _flyersCollectionRef.doc(flyerModel.flyerID).update(flyerModel.toMap());
  }

}
