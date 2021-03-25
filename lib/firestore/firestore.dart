import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
class FireStoreCollection{
  static const String users = 'users';
  static const String countries = 'countries';
  static const String questions = 'questions';
  static const String bzz = 'bzz';
  static const String flyers = 'flyers';
}

// ---------------------------------------------------------------------------
CollectionReference getFirestoreCollectionReference (String collectionName){
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  CollectionReference _collection = _fireInstance.collection(collectionName);
  return _collection;
}
// ---------------------------------------------------------------------------
DocumentReference getFirestoreDocumentReference (String collectionName, String documentName){
  CollectionReference _collection = getFirestoreCollectionReference(collectionName);
  DocumentReference _doc =  _collection.doc(documentName);
  return _doc;
}
// ---------------------------------------------------------------------------
Future<void> updateFieldOnFirestore({
  BuildContext context ,
  String collectionName,
  String documentName,
  String field,
  dynamic input
}) async {
  DocumentReference _doc =  getFirestoreDocumentReference(collectionName, documentName);

  // if (){}else if(){}else{}
  try {

    await _doc.update({field : input});

    await superDialog(context, 'Successfully updated\n$collectionName\\$documentName\\$field to :\n"$input"','Success');

    minimizeKeyboardOnTapOutSide(context);

  } catch(error) {
    superDialog(context, error, 'Ops !');
  }

}
// ---------------------------------------------------------------------------
Stream<QuerySnapshot> getFirestoreCollectionSnapshots(String collectionName){
  CollectionReference _collection = getFirestoreCollectionReference(collectionName);
  Stream<QuerySnapshot> _snapshots = _collection.snapshots();
  return _snapshots;
}
// ---------------------------------------------------------------------------
Stream<DocumentSnapshot> getFirestoreDocumentSnapshots(String collectionName, String documentName){
  DocumentReference _document = getFirestoreDocumentReference(collectionName, documentName);
  Stream<DocumentSnapshot> _snapshots = _document.snapshots();
  return _snapshots;
}
// ---------------------------------------------------------------------------
Future<dynamic> getFireStoreDocumentMap(String collectionName, String documentName) async {

  final DocumentReference _document = getFirestoreDocumentReference(collectionName, documentName);

  Map<String, dynamic> _map; //QueryDocumentSnapshot

  await _document.get().then<dynamic>((DocumentSnapshot snapshot) async{
    _map = snapshot.data();
  });

  return _map;
}
// ---------------------------------------------------------------------------
Future<List<QueryDocumentSnapshot>> getFireStoreCollectionMaps(String collectionName) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
  List<QueryDocumentSnapshot> _maps = querySnapshot.docs;
  return _maps;
}
// ---------------------------------------------------------------------------
