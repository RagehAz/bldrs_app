import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
class FireCollection{
  static const String users = 'users';
  static const String tinyUsers = 'tinyUsers';
  static const String subUserAsks = 'asks' ;
  static const String subUserSaves = 'saves';

  static const String countries = 'countries';

  static const String asks = 'asks';
  static const String subAskChats = 'chats';
  static const String subAskCounters = 'counters';

  static const String bzz = 'bzz';
  static const String tinyBzz = 'tinyBzz';
  static const String subBzCounters = 'counters';
  static const String subBzFollows = 'follows';
  static const String subBzCalls = 'calls';
  static const String subBzChats = 'chats';

  static const String flyers = 'flyers';
  static const String tinyFlyers = 'tinyFlyers';
  static const String flyersKeys = 'flyersKeys';
  static const String subFlyerCounters = 'counters';
  static const String subFlyerSaves = 'saves';
  static const String subFlyerShares = 'shares';
  static const String subFlyerViews = 'views';

  static const String feedbacks = 'feedbacks';
  static const String admin = 'admin';
}

class AdminDoc{
  static const String sponsors = 'sponsors';
}

// /// cloud firestore database functions
// class FireCloud{}

// ---------------------------------------------------------------------------

class Fire{
// -----------------------------------------------------------------------------
  static CollectionReference getCollectionRef (String collName){
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  CollectionReference _collection = _fireInstance.collection(collName);
  return _collection;
}
// -----------------------------------------------------------------------------
  static DocumentReference getDocRef (String collName, String docName){
    CollectionReference _collection = Fire.getCollectionRef(collName);
    DocumentReference _doc =  _collection.doc(docName);

    // or this syntax
    // final DocumentReference _doc =
    // FirebaseFirestore.instance
    //     .collection(collName)
    //     .doc(docName)

    return _doc;
  }
// -----------------------------------------------------------------------------
  static CollectionReference getSubCollectionRef ({String collName, String docName, String subCollName}){
    final CollectionReference _subCollection = FirebaseFirestore.instance
        .collection('$collName/$docName/$subCollName');

    // or this syntax
    // final CollectionReference _subCollection =
    // FirebaseFirestore.instance
    //     .collection(collName)
    //     .doc(docName)
    //     .collection(subCollName);

    return _subCollection;
}
// -----------------------------------------------------------------------------
  static DocumentReference getSubDocRef ({String collName, String docName, String subCollName, String subDocName}){
    final CollectionReference _subCollection = FirebaseFirestore.instance
        .collection('$collName/$docName/$subCollName');
    final DocumentReference _subDocRef = _subCollection.doc(subDocName);

    // or this syntax
    // final DocumentReference _subDocRef =
    // FirebaseFirestore.instance
    //     .collection(collName)
    //     .doc(docName)
    //     .collection(subCollName)
    //     .doc(subDocName);

    return _subDocRef;
  }
// =============================================================================
  /// creates firestore doc with auto generated ID then returns doc reference
  static Future<DocumentReference> createDoc({
    BuildContext context,
    String collName,
    Map<String, dynamic> input,
  }) async {

    DocumentReference _docRef;

    await tryAndCatch(
        context: context,
        functions: () async {

          final CollectionReference _bzCollectionRef = Fire.getCollectionRef(collName);

          _docRef = _bzCollectionRef.doc();

          await _docRef.set(input);

        }
    );

    return _docRef;
  }
// -----------------------------------------------------------------------------
  static Future<DocumentReference> createNamedDoc({
    BuildContext context,
    String collName,
    String docName,
    Map<String, dynamic> input,
  }) async {

    DocumentReference _docRef;

    await tryAndCatch(
        context: context,
        functions: () async {

          final _docRef = getDocRef(collName, docName);

          await _docRef.set(input);

        }
    );

    return _docRef;
  }
// -----------------------------------------------------------------------------
  /// creates firestore sub doc with auto ID
  static Future<DocumentReference> createSubDoc({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    Map<String, dynamic> input,
  }) async {

    /// creates a new sub doc and new sub collection if didn't exists
    /// and uses the same directory if existed to add a new doc
    /// updates the sub doc if existed
    /// and creates random name for sub doc if sub doc name is null

    DocumentReference _subDocRef = await createNamedSubDoc(
      context: context,
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: null, // to make it generate auto ID
      input: input,
    );

    return _subDocRef;
  }
// -----------------------------------------------------------------------------
  static Future<DocumentReference> createNamedSubDoc({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    String subDocName,
    Map<String, dynamic> input,
  }) async {

    /// creates a new sub doc and new sub collection if didn't exists
    /// and uses the same directory if existed to add a new doc
    /// updates the sub doc if existed
    /// and creates random name for sub doc if sub doc name is null

    DocumentReference _subDocRef;

    await tryAndCatch(
        context: context,
        functions: () async {

          _subDocRef = getSubDocRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocName: subDocName,
          );

          await _subDocRef.set(input);

        }
    );

    return _subDocRef;
  }
// =============================================================================
  static Future<List<QueryDocumentSnapshot>> readCollectionDocs(String collectionName) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    List<QueryDocumentSnapshot> _maps = querySnapshot.docs;
    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> readDoc({
    BuildContext context,
    String collName,
    String docName
  }) async {

    Map<String, dynamic> _map; //QueryDocumentSnapshot

    await tryAndCatch(
      context: context,
      functions: () async {

        final DocumentReference _document = Fire.getDocRef(collName, docName);

        await _document.get().then<dynamic>((DocumentSnapshot snapshot) async{
          _map = snapshot.data();
        });

      },
    );

    return _map;
  }
// -----------------------------------------------------------------------------
  /// TODO : delete Fire.readDocField if not used in release mode
  static Future<dynamic> readDocField({
    BuildContext context,
    String collName,
    String docName,
    String fieldName,
  }) async {

    dynamic _map;

    tryAndCatch(
        context: context,
        functions: () async {
          _map = await Fire.readDoc(
            context: context,
            collName: collName,
            docName: docName,
          );

        }
    );

    return _map[fieldName];
  }
// -----------------------------------------------------------------------------
  /// TASK : GETTING ALL SUB COLLECTION MAPS not tested
  static Future<List<QueryDocumentSnapshot>> readSubCollectionDocs({
    String collName,
    String docName,
    String subCollName
  }) async {

    final CollectionReference _subCollection = getSubCollectionRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    QuerySnapshot querySnapshot = await _subCollection.get();
    List<QueryDocumentSnapshot> _maps = querySnapshot.docs;
    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> readSubDoc({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    String subDocName
  }) async {

    dynamic _map;

    await tryAndCatch(
        context: context,
        functions: () async {

          final DocumentReference _subDocRef = getSubDocRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocName: subDocName,
          );

          await _subDocRef.get().then<dynamic>((DocumentSnapshot snapshot) async{
            _map = snapshot.data();
          });

        }
    );

    return _map;
  }
// -----------------------------------------------------------------------------
  /// TODO : delete Fire.readSubDocField if not used in release mode
  static Future<dynamic> readSubDocField({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    String subDocName,
    String fieldName,
  }) async {

    dynamic _map;

    tryAndCatch(
        context: context,
        functions: () async {
          _map = await Fire.readSubDoc(
            context: context,
            collName: collName,
            docName: docName,
          );

        }
    );

    return _map[fieldName];
  }
// ====================================---
  static Stream<QuerySnapshot> streamCollection(String collectionName){
    CollectionReference _collection = Fire.getCollectionRef(collectionName);
    Stream<QuerySnapshot> _snapshots = _collection.snapshots();
    return _snapshots;
  }
// -----------------------------------------------------------------------------
  static Stream<DocumentSnapshot> streamDoc(String collectionName, String documentName){
    DocumentReference _document = Fire.getDocRef(collectionName, documentName);
    Stream<DocumentSnapshot> _snapshots = _document.snapshots();
    return _snapshots;
  }
// -----------------------------------------------------------------------------
  static Stream<DocumentSnapshot> streamSubDoc({
    String collName,
    String docName,
    String subCollName,
    String subDocName,
  }){
    DocumentReference _document = Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    Stream<DocumentSnapshot> _snapshots = _document.snapshots();
    return _snapshots;
  }
// =============================================================================
  /// this creates a new doc that overrides existing doc
  /// same as createNamedDoc method
  static Future<void> updateDoc({
    BuildContext context,
    String collName,
    String docName,
    Map<String, dynamic> input,
  }) async {

    await createNamedDoc(
      context: context,
      collName: collName,
      docName: docName,
      input: input,
    );

    // or another syntax
    // await tryAndCatch(
    //     context: context,
    //     functions: () async {
    //
    //       DocumentReference _docRef = getDocRef(collName, docName);
    //       await _docRef.set(input);
    //
    //     }
    // );

  }
// -----------------------------------------------------------------------------
  static Future<void> updateDocField({
    BuildContext context ,
    String collName,
    String docName,
    String field,
    dynamic input
  }) async {
    DocumentReference _doc =  Fire.getDocRef(collName, docName);

    // if (){}else if(){}else{}
    try {

      await _doc.update({field : input});

      // await superDialog(context, 'Successfully updated\n$collectionName\\$documentName\\$field to :\n"$input"','Success');

    } catch(error) {
      superDialog(context, error, 'Ops !');
    }

  }
// -----------------------------------------------------------------------------
  static Future<void> updateSubDoc({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    String subDocName,
    Map<String, dynamic> input,
  }) async {

    await createNamedSubDoc(
      context: context,
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
      input: input,
    );

  }
// -----------------------------------------------------------------------------
  /// this updates a field if exists, if absent it creates a new field and inserts the value
  static Future<void> updateSubDocField({
    BuildContext context ,
    String collName,
    String docName,
    String subCollName,
    String subDocName,
    String field,
    dynamic input
  }) async {

    DocumentReference _subDoc =  Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    try {

      await _subDoc.update({field : input});

    } catch(error) {
      superDialog(context, error, 'Ops !');
    }

  }
// =============================================================================
  static Future<void> deleteDoc({
    BuildContext context,
    String collName,
    String docName,
  }) async {

    await tryAndCatch(
        context: context,
        functions: () async {
          DocumentReference _doc = Fire.getDocRef(collName, docName);
          await _doc.delete();
        }
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteSubDoc({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
    String subDocName,
}) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          DocumentReference _subDoc = Fire.getSubDocRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
          subDocName: subDocName,
          );

          await _subDoc.delete();
        }
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteCollection({
    BuildContext context,
    String collName,
  }) async {

    /// TASK : deleting collection and all its docs, sub collections & sub docs require a cloud function

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteSubCollection({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
  }) async {

    /// TASK : deleting sub collection and all its sub docs require a cloud function

  }
// -----------------------------------------------------------------------------
}

// ---------------------------------------------------------------------------
// Future<void> updateFieldOnFirestoreSubDoc({
//   BuildContext context,
//   String collectionName,
//   String docName,
//   String subCollectionName,
//   String subDocName,
//   dynamic input,
// }) async {
//
//   await tryAndCatch(
//       context: context,
//       functions: () async {
//
//     final CollectionReference _collectionRef =
//     getFireCollectionReference(collectionName);
//
//     _subDocRef = _collectionRef.doc(docName).collection(subCollectionName).doc(subDocName);
//
//     await _subDocRef.set(input);
//
//   }
//   );
//
//
// }
// ---------------------------------------------------------------------------
