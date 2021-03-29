import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/models/user_model.dart';
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

  /// create empty firestore flyer document to get back _flyerID
  DocumentReference _docRef = await createFireStoreDocument(
    context: context,
    collectionName: FireStoreCollection.flyers,
    input: {},
  );
  String _flyerID = _docRef.id;

  /// save slide pictures on fireStorage and get back their URLs
  List<String> _picturesURLs = await savePicturesToFireStorageAndGetListOfURL(context, inputFlyerModel.slides, _flyerID);

  /// update slides with URLs
  List<SlideModel> _updatedSlides = await replaceSlidesPicturesWithNewURLs(_picturesURLs, inputFlyerModel.slides);

  /// TASK : generate flyerURL
  String _flyerURL = 'www.bldrs.net' ;

  /// update FlyerModel with newSlides & flyerURL
  FlyerModel _updatedFlyerModel = FlyerModel(
    flyerID: inputFlyerModel.flyerID,
    flyerType: inputFlyerModel.flyerType,
    flyerURL: _flyerURL,
    authorID: inputFlyerModel.authorID,
    tinyBz: inputFlyerModel.tinyBz,
    publishTime: inputFlyerModel.publishTime,
    slides: _updatedSlides,
  );

  /// replace empty flyer document with the new refactored one _updatedFlyerModel
  await replaceFirestoreDocument(
    context: context,
    collectionName: FireStoreCollection.flyers,
    docName: _flyerID,
    input: _updatedFlyerModel.toMap(),
  );

  /// add new TinyFlyer in firestore
  await createFireStoreNamedDocument(
    context: context,
    collectionName: FireStoreCollection.tinyFlyers,
    docName: _flyerID,
    input: (getTinyFlyerFromFlyerModel(_updatedFlyerModel)).toMap(),
  );

  /// add new flyerIndex in fireStore


  /// add flyer counters sub collection and document in flyer store
  ///
  ///
  /// add flyer saved sub collection in firestore
  ///
  ///
  /// add flyer shares sub collection in firestore
  ///
  ///
  /// add flyer views sub collection in firestore
  ///
  ///
  /// add tiny flyer to bz document in 'tinyFlyers' field
  ///
  ///
  /// add tiny flyer to local list and notifyListeners


  return _updatedFlyerModel;
}
// ----------------------------------------------------------------------
  Future<void> updateFlyerDoc(FlyerModel flyerModel) async {
  await _flyersCollectionRef.doc(flyerModel.flyerID).update(flyerModel.toMap());
}
// ----------------------------------------------------------------------
Future<void> deleteFlyerDoc(String flyerID) async {
  final DocumentReference _flyerDocRef = flyerDocRef(flyerID);
  await _flyerDocRef.delete();
}
// ----------------------------------------------------------------------

}
