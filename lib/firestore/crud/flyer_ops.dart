import 'package:bldrs/models/flyer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
Future<String> createFlyerDoc() async {
  DocumentReference _flyerDocRef = _flyersCollectionRef.doc();
  await _flyerDocRef.set({});
  String _flyerID = _flyerDocRef.id;
  return _flyerID;
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

// ############################################################################
/// add flyer to realtime database
//   void addFlyerToRealtimeDatabase(FlyerModel flyer){
//     const url = realtimeDatabaseFlyersPath;
//     http.post(url,
//       body: json.encode({
//         'flyerID' : flyer.flyerID,
//         // -------------------------
//         'flyerType' : flyer.flyerType,
//         'flyerState' : flyer.flyerState,
//         'keyWords' : flyer.keyWords,
//         'flyerShowsAuthor' : flyer.flyerShowsAuthor,
//         'flyerURL' : flyer.flyerURL,
//         // -------------------------
//         'authorID' : flyer.authorID,
//         'bzID' : flyer.bzID,
//         // -------------------------
//         'publishTime' : flyer.publishTime,
//         'flyerPosition' : flyer.flyerPosition,
//         // -------------------------
//         'ankhIsOn' : flyer.ankhIsOn,
//         // -------------------------
//         'slides' : flyer.slides,
//       }),
//     );
//
//     final FlyerModel newFlyer = flyer;
//
//     addFlyerToLocalFlyersList(newFlyer);
//
// }
// ############################################################################
// ############################################################################
