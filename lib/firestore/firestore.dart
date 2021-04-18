import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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

class StorageDoc{
  static String usersPics     = 'usersPics';   // uses userID as file name
  static String authorsPics   = 'authorsPics'; // uses userID as file name
  static String bzLogos       = 'bzLogos';     // uses bzID as file name
  static String slideHighRes  = 'slidesPics';  // uses flyerID_slideIndex as file name
  static String slideLowRes   = 'slidesPicsLow';  // uses flyerID_slideIndex as file name
  static String dumz          = 'dumz';
  static String askPics       = 'askPics';
// ---------------------------------------------------------------------------
  static String docName(PicType picType){
    switch (picType){
      case PicType.userPic        :   return   usersPics;     break; // uses userID as file name
      case PicType.authorPic      :   return   authorsPics;   break; // uses userID as file name
      case PicType.bzLogo         :   return   bzLogos;       break; // uses bzID as file name
      case PicType.slideHighRes   :   return   slideHighRes;  break; // uses flyerID_slideIndex as file name
      case PicType.slideLowRes    :   return   slideLowRes;   break; // uses flyerID_slideIndex as file name
      case PicType.dum            :   return   dumz;          break;
      case PicType.askPic         :   return   askPics;       break;
      default : return   null;
    }
  }
// ---------------------------------------------------------------------------
}

class Fire{
// =============================================================================



  /// CLOUD FIRESTORE METHODS



// =============================================================================
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
    QuerySnapshot _collectionSnapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    List<QueryDocumentSnapshot> _docsSnapshots = _collectionSnapshot.docs;

    // if we want to alter this method to return List<Map<Sting, dynamic>>
    // we can do this :-
    // List<dynamic> _maps = new List();
    // for (var docSnapShot in _docsSnapshots){
    //   _maps.add(docSnapShot.data());
    // }
    // and then return _maps; but will leave it for now to
    // return <List<QueryDocumentSnapshot>>

    return _docsSnapshots;
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
  static Future<dynamic> readSubCollectionDocs({
    BuildContext context,
    bool addDocsIDs,
    String collName,
    String docName,
    String subCollName,
  }) async {

    List<Map<String, dynamic>> _maps = new List();

    await tryAndCatch(
      context: context,
      functions: () async {

        final CollectionReference _subCollection = getSubCollectionRef(
          collName: collName,
          docName: docName,
          subCollName: subCollName,
        );

        final QuerySnapshot _collectionSnapshot = await _subCollection.get();
        final List<QueryDocumentSnapshot> _docsSnapshots = _collectionSnapshot.docs;

        for (var docSnapshot in _docsSnapshots){

          String _docID = docSnapshot.id;
          Map<String, dynamic> _map = docSnapshot.data();

          if (addDocsIDs == true){
            _map['id'] = _docID;
          }

          _maps.add(_map);
        }

      }
    );

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

          await _subDocRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
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

    await tryAndCatch(
      context: context,
      functions: () async {

        await _doc.update({field : input});

      }
    );

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

    await tryAndCatch(
      context: context,
      functions: () async {
        await _subDoc.update({field : input});
      }
    );

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
  /// ALERT : deleting all sub docs from client device is super dangerous
  static Future<void> deleteAllSubDocs({
    BuildContext context,
    String collName,
    String docName,
    String subCollName,
  }) async {

    /// a - read all sub docs
    List<dynamic> _subDocs = await Fire.readSubCollectionDocs(
      context: context,
      addDocsIDs: true,
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    for(var map in _subDocs){

      String _docID = map['id'];

      await Fire.deleteSubDoc(
        context: context,
        collName: collName,
        docName: docName,
        subCollName: subCollName,
        subDocName: _docID,
      );

    }

}
// =============================================================================



/// FIREBASE STORAGE METHODS



// =============================================================================
  static Reference getStorageRef({
    String docName,
    String fileName,
  }) {
    final ref = FirebaseStorage.instance
        .ref()
        .child(docName)
        .child(fileName + '.jpg'); // should be bzID

    return ref;
  }
// -----------------------------------------------------------------------------
  /// creates new pic in document name according to pic type,
  /// and overrides existing pic if already exists
  static Future<String> createStoragePicAndGetURL({
    BuildContext context,
    File inputFile,
    String fileName,
    PicType picType
  }) async {
    String _imageURL;

    await tryAndCatch(
        context: context,
        functions: () async {

          final _ref = getStorageRef(
              docName: StorageDoc.docName(picType),
              fileName: fileName,
          );

          print('X1 - getting storage ref : $_ref');

          ImageSize imageSize = await superImageSize(inputFile);

          print('X2 - image size is ${imageSize.height} * ${imageSize.width}');

          SettableMetadata metaData = SettableMetadata(
              customMetadata: {'width': '${imageSize.width}', 'height': '${imageSize.height}'}
          );

          print('X3 - meta data assigned');

          await _ref.putFile(
            inputFile,
            metaData,
          );

          print('X4 - File has been uploaded $inputFile');

          _imageURL = await _ref.getDownloadURL();

          print('X5 - _imageURL is downloaded  $_imageURL');
        }
    );
    return _imageURL;
  }
// -----------------------------------------------------------------------------
  static Future<List<String>> createStorageSlidePicsAndGetURLs({
    BuildContext context,
    List<SlideModel> slides,
    String flyerID
  }) async {
    List<String> _picturesURLs = new List();

    for (var slide in slides) {
      String _picURL = await Fire.createStoragePicAndGetURL(
        context: context,
        inputFile: slide.picture,
        picType: PicType.slideHighRes,
        fileName: SlideModel.generateSlideID(flyerID, slide.slideIndex),
      );
      _picturesURLs.add(_picURL);
    }

    return _picturesURLs;
  }
// -----------------------------------------------------------------------------
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromAssetAndGetURL ({
    BuildContext context,
    String asset,
    String fileName,
    PicType picType
  }) async {
    String _url;

    File _result = await getImageFileFromAssets(context, asset);

    print('uploading $fileName pic to fireStorage in folder of $picType');

    _url = await createStoragePicAndGetURL(
      context: context,
      fileName: fileName,
      picType: picType,
      inputFile: _result,
    );

    print('uploaded pic : $_url');

    return _url;
  }
// -----------------------------------------------------------------------------
  static Future<String> readStoragePicURL({
    PicType picType,
    String fileName
  }) async {

    final _ref = getStorageRef(
        docName: StorageDoc.docName(picType),
        fileName: fileName
    );

    String _url = await _ref.getDownloadURL();

    return _url;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteStoragePic({
    BuildContext context,
    String fileName,
    PicType picType
  }) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          Reference _picRef  = getStorageRef(
              docName: StorageDoc.docName(picType),
              fileName: fileName
          );

          await _picRef.delete();
        }
    );

  }
// ---------------------------------------------------------------------------
}
