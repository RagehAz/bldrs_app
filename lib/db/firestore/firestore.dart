import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/models/helpers/image_size.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireCollection{
  static const String users = 'users';
  static const String tinyUsers = 'tinyUsers';
  static const String users_user_asks = 'asks' ;
  static const String users_user_records = 'records';
  static const String users_user_records_bzz = 'follows';
  static const String users_user_records_flyers = 'saves';
  static const String users_user_notifications = 'notifications';

  static const String countries = 'countries';

  static const String questions = 'questions';
  static const String questions_question_chats = 'chats';
  static const String questions_question_counters = 'counters';

  static const String bzz = 'bzz';
  static const String tinyBzz = 'tinyBzz';
  static const String bzz_bz_counters = 'counters';
  static const String bzz_bz_follows = 'follows';
  static const String bzz_bz_calls = 'calls';
  static const String bzz_bz_chats = 'chats';
  static const String bzz_bz_notifications = 'notifications';
  static const String bzz_bz_credits = 'credits';
  static const String bzz_bz_credits_log = 'log';
  static const String bzz_bz_credits_balance = 'balance';

  static const String flyers = 'flyers';
  static const String tinyFlyers = 'tinyFlyers';
  static const String flyersKeys = 'flyersKeys';
  static const String flyers_flyer_counters = 'counters';
  static const String flyers_flyer_saves = 'saves';
  static const String flyers_flyer_shares = 'shares';
  static const String flyers_flyer_views = 'views';
  static const String flyers_flyer_reviews = 'reviews';

  static const String feedbacks = 'feedbacks';
  static const String admin = 'admin';
  static const String admin_sponsors = 'sponsors';
  static const String admin_statistics = 'statistics';
  static const String admin_appState = 'appState';
}

class StorageDoc{
  static const String usersPics     = 'usersPics';   // uses userID as file name
  static const String authorsPics   = 'authorsPics'; // uses userID as file name
  static const String bzLogos       = 'bzLogos';     // uses bzID as file name
  static const String slideHighRes  = 'slidesPics';  // uses flyerID_slideIndex as file name
  static const String slideLowRes   = 'slidesPicsLow';  // uses flyerID_slideIndex as file name
  static const String dumz          = 'dumz';
  static const String askPics       = 'askPics';
  static const String notiBanners = 'notiBanners';
// -----------------------------------------------------------------------------
  static String docName(PicType picType){
    switch (picType){
      case PicType.userPic        :   return   usersPics;     break; // uses userID as file name
      case PicType.authorPic      :   return   authorsPics;   break; // uses userID as file name
      case PicType.bzLogo         :   return   bzLogos;       break; // uses bzID as file name
      case PicType.slideHighRes   :   return   slideHighRes;  break; // uses flyerID_slideIndex as file name
      case PicType.slideLowRes    :   return   slideLowRes;   break; // uses flyerID_slideIndex as file name
      case PicType.dum            :   return   dumz;          break;
      case PicType.askPic         :   return   askPics;       break;
      case PicType.notiBanner     :   return   notiBanners;   break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
}

class Fire{


// -----------------------------------------------------------------------------
  static String pathOfColl({String collName, String docName,}){
    return
      '$collName/$docName';
  }
// -----------------------------------------------------------------------------
  static String pathOfSubColl({String collName, String docName, String subCollName}){
    return
      '$collName/$docName/$subCollName';
  }
// -----------------------------------------------------------------------------
  static String pathOfSubDoc({String collName, String docName, String subCollName, String subDocName}){
    return
      '$collName/$docName/$subCollName/$subDocName';
  }
// =============================================================================



  /// CLOUD FIRESTORE METHODS



// =============================================================================
  static CollectionReference getCollectionRef (String collName){
    final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
    final CollectionReference _collection = _fireInstance.collection(collName);
    return _collection;
  }
// -----------------------------------------------------------------------------
  static DocumentReference getDocRef ({String collName, String docName}){
    final CollectionReference _collection = Fire.getCollectionRef(collName);
    final DocumentReference _doc =  _collection.doc(docName);

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
// -----------------------------------------------------------------------------
  static Future<dynamic> _getMapByDocRef(DocumentReference docRef) async {
    dynamic _map;

    final DocumentSnapshot snapshot = await docRef.get();

    if (snapshot.exists == true){
      _map = Mapper.getMapFromDocumentSnapshot(snapshot);
    } else {
      _map = null;
    }

    //     .then<dynamic>((DocumentSnapshot snapshot) async {
    //   _map = Mapper.getMapFromDocumentSnapshot(snapshot);
    // });
    return _map;
  }
// =============================================================================
  /// creates firestore doc with auto generated ID then returns doc reference
  static Future<DocumentReference> createDoc({
    BuildContext context,
    String collName,
    bool addDocID,
    Map<String, dynamic> input,
  }) async {

    DocumentReference _docRef;

    await tryAndCatch(
        context: context,
        methodName: 'createDoc',
        functions: () async {

          final CollectionReference _bzCollectionRef = Fire.getCollectionRef(collName);

          _docRef = _bzCollectionRef.doc();

          if (addDocID == true){

            Mapper.insertPairInMap(
              map: input,
              key: 'id',
              value: _docRef.id,
            );

          }

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
        methodName: 'createNamedDoc',
        functions: () async {

          final _docRef = getDocRef(
            collName: collName,
            docName: docName,
          );

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

    final DocumentReference _subDocRef = await createNamedSubDoc(
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
        methodName: 'createNamedSubDoc',
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
  static Future<List<dynamic>> readCollectionDocs({
    String collectionName,
    String orderBy,
    @required int limit,
    QueryDocumentSnapshot startAfter,
    bool addDocSnapshotToEachMap,
    bool addDocID,
  }) async {

    final QueryDocumentSnapshot _startAfter = startAfter ?? null;

    QuerySnapshot _collectionSnapshot;


    if(_startAfter == null){
      _collectionSnapshot = await FirebaseFirestore.instance.collection(collectionName).orderBy(orderBy).limit(limit).get();
    }

    else {
      _collectionSnapshot = await FirebaseFirestore.instance.collection(collectionName).orderBy(orderBy).limit(limit).startAfterDocument(startAfter).get();
    }



    final List<QueryDocumentSnapshot> _docsSnapshots = _collectionSnapshot.docs;

    /// to return maps
    final List<dynamic> _maps = <dynamic>[];

    for (QueryDocumentSnapshot docSnapshot in _docsSnapshots){

      Map<String, dynamic> _map = docSnapshot.data();

      if (addDocID == true){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'id',
          value: docSnapshot.id,
        );
      }

      if (addDocSnapshotToEachMap == true){
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'docSnapshot',
          value: docSnapshot,
        );
      }

      _maps.add(_map);

    }
    // return <List<QueryDocumentSnapshot>>

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<dynamic> readDoc({
    BuildContext context,
    String collName,
    String docName
  }) async {

    print('readDoc() : starting to read doc : firestore/$collName/$docName');
    // print('lng : ${Wordz.languageCode(context)}');

    Map<String, dynamic> _map; //QueryDocumentSnapshot

    // print('readDoc() : _map starts as : $_map');

    final dynamic _result = await tryCatchAndReturn(
      context: context,
      methodName: 'readDoc',
      functions: () async {

        final DocumentReference _docRef = Fire.getDocRef(
            collName: collName,
            docName: docName
        );
        // print('readDoc() : _docRef : $_docRef');

        _map = await _getMapByDocRef(_docRef);
        // print('readDoc() : _map : $_map');

      },
    );

    // print('readDoc() : _result : $_result');
    // print('readDoc() : _map : $_map');
    // print('lng : ${Wordz.languageCode(context)}');

    return
      _result.runtimeType == String ? null : _map;
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
        methodName: 'readDocField',
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

    List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    await tryAndCatch(
        context: context,
        methodName: 'readSubCollectionDocs',
        functions: () async {

          final CollectionReference _subCollection = getSubCollectionRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
          );

          final QuerySnapshot _collectionSnapshot = await _subCollection.get();

          _maps = Mapper.getMapsFromQuerySnapshot(
            querySnapshot: _collectionSnapshot,
            addDocsIDs: addDocsIDs,
          );

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
        methodName: 'readSubDoc',
        functions: () async {

          final DocumentReference _subDocRef = getSubDocRef(
            collName: collName,
            docName: docName,
            subCollName: subCollName,
            subDocName: subDocName,
          );

          _map = await _getMapByDocRef(_subDocRef);

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
        methodName: 'readSubDocField',
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
    final CollectionReference _collection = Fire.getCollectionRef(collectionName);
    final Stream<QuerySnapshot> _snapshots = _collection.snapshots();
    return _snapshots;
  }
// -----------------------------------------------------------------------------
  static Stream<QuerySnapshot> streamSubCollection({
    @required String collName,
    @required String docName,
    @required String subCollName,
    @required bool descending,
    @required String orderBy, // field name to order by
    String field,
    dynamic compareValue,
  }){

    final CollectionReference _collection = Fire.getSubCollectionRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    Stream<QuerySnapshot> _snapshots;

    if (field != null && compareValue != null){
      _snapshots = _collection
          .orderBy(orderBy, descending: descending)
          .where('$field', isEqualTo: compareValue)
          .limit(10)
          .snapshots();
    }

    else {
      _snapshots = _collection
          .orderBy(orderBy, descending: descending)
          .snapshots();
    }


    return _snapshots;
  }
// -----------------------------------------------------------------------------
  static Stream<DocumentSnapshot> streamDoc(String collectionName, String documentName){
    final DocumentReference _document = Fire.getDocRef(
        collName: collectionName,
        docName: documentName
    );
    final Stream<DocumentSnapshot> _snapshots = _document.snapshots();
    return _snapshots;
  }
// -----------------------------------------------------------------------------
  static Stream<DocumentSnapshot> streamSubDoc({
    String collName,
    String docName,
    String subCollName,
    String subDocName,
  }){

    final DocumentReference _document = Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    final Stream<DocumentSnapshot> _snapshots = _document.snapshots();

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

    final DocumentReference _doc =  Fire.getDocRef(
        collName: collName,
        docName: docName
    );

    await tryAndCatch(
        context: context,
        methodName: 'updateDocField',
        functions: () async {

          await _doc.update({field : input});

          print('Updated doc : $docName : field : [$field] : to : ${input.toString()}');

        }
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> updateDocFieldKeyValue({
    BuildContext context ,
    String collName,
    String docName,
    String field,
    String key,
    dynamic input,
  }) async {

    await updateDocField(
      context: context,
      collName: collName,
      docName: docName,
      field: '$field.$key',
      input: input,
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

    final DocumentReference _subDoc =  Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    await tryAndCatch(
        context: context,
        methodName: 'updateSubDocField',
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
        methodName: 'deleteDoc',
        functions: () async {

          final DocumentReference _doc = Fire.getDocRef(
            collName: collName,
            docName: docName,
          );

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
        methodName: 'deleteSubDoc',
        functions: () async {

          final DocumentReference _subDoc = Fire.getSubDocRef(
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
    final List<dynamic> _subDocs = await Fire.readSubCollectionDocs(
      context: context,
      addDocsIDs: true,
      collName: collName,
      docName: docName,
      subCollName: subCollName,
    );

    for(var map in _subDocs){

      final String _docID = map['id'];

      await Fire.deleteSubDoc(
        context: context,
        collName: collName,
        docName: docName,
        subCollName: subCollName,
        subDocName: _docID,
      );

    }

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteDocField({
    BuildContext context,
    String collName,
    String docName,
    String field,
  }) async {

    final DocumentReference _docRef = Fire.getDocRef(
      collName: collName,
      docName: docName,
    );

    // await tryAndCatch(
    //     context: context,
    //     methodName: 'deleteSubDocField',
    //     functions: () async {

    // Remove field from the document
    final Map<String, Object> updates = new Map();

    updates.addAll({
      field : FieldValue.delete(),
    });

    await _docRef.update(updates);

    //     }
    // );

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteSubDocField({
    BuildContext context,
    String collName,
    String docName,
    String field,
    String subCollName,
    String subDocName,
  }) async {

    final DocumentReference _docRef = Fire.getSubDocRef(
      collName: collName,
      docName: docName,
      subCollName: subCollName,
      subDocName: subDocName,
    );

    await tryAndCatch(
        context: context,
        methodName: 'deleteSubDocField',
        functions: () async {

          // Remove field from the document
          final Map<String, Object> updates = new Map();

          updates.addAll({
            field : FieldValue.delete(),
          });

          await _docRef.update(updates);

        }
    );

  }
// =============================================================================

  /// FIREBASE STORAGE METHODS

// =============================================================================
  static Reference getStorageRef({
    BuildContext context,
    String docName,
    String fileName,
  }) {

    print('getting fire storage reference');

    final Reference _ref = FirebaseStorage.instance
        .ref()
        .child(docName)
        .child(fileName + '.jpg') ?? null;

    return _ref;
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
        methodName: 'createStoragePicAndGetURL',
        functions: () async {

          final Reference _ref = getStorageRef(
            docName: StorageDoc.docName(picType),
            fileName: fileName,
          );

          print('X1 - getting storage ref : $_ref');

          final ImageSize imageSize = await ImageSize.superImageSize(inputFile);

          print('X2 - image size is ${imageSize.height} * ${imageSize.width}');

          final SettableMetadata metaData = SettableMetadata(
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

    final List<String> _picturesURLs = <String>[];

    for (var slide in slides) {

      final String _picURL = await Fire.createStoragePicAndGetURL(
        context: context,
        inputFile: slide.pic,
        picType: PicType.slideHighRes,
        fileName: SlideModel.generateSlideID(flyerID, slide.slideIndex),
      );

      _picturesURLs.add(_picURL);

    }

    return _picturesURLs;
  }
// -----------------------------------------------------------------------------
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    BuildContext context,
    List<dynamic> pics,
    List<String> names,
  }) async {

    final List<String> _picsURLs = <String>[];

    for (int i =0; i < pics.length; i++) {
      final String _picURL = await Fire.createStoragePicAndGetURL(
        context: context,
        inputFile: pics[i],
        picType: PicType.slideHighRes,
        fileName: names[i],
      );
      _picsURLs.add(_picURL);
    }

    return _picsURLs;
  }
// -----------------------------------------------------------------------------
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL ({
    BuildContext context,
    String asset,
    String fileName,
    PicType picType
  }) async {
    String _url;

    final File _result = await Imagers.getImageFileFromLocalAsset(context, asset);

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

    final Reference _ref = getStorageRef(
        docName: StorageDoc.docName(picType),
        fileName: fileName
    );

    final String _url = await _ref.getDownloadURL();

    return _url;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteStoragePic({
    BuildContext context,
    String fileName,
    PicType picType
  }) async {

    dynamic _result = await tryCatchAndReturn(
        context: context,
        methodName: 'deleteStoragePic',
        functions: () async {

          final Reference _picRef  = getStorageRef(
              docName: StorageDoc.docName(picType),
              fileName: fileName
          );

          final FullMetadata _metaData = await _picRef?.getMetadata();

          print('_metaData ------------------------- : $_metaData');

          await _picRef?.delete();
        }
    );

    print('checking delete result : $_result');

    /// if result is an error, pop a dialog
    if (_result.runtimeType == String){

      /// only if the error is not
      /// [firebase_storage/object-not-found] No object exists at the desired reference.
      const String _fileDoesNotExistError = '[firebase_storage/object-not-found] No object exists at the desired reference.';

      if (_result == _fileDoesNotExistError){

        // await superDialog(
        //   context: context,
        //   title: '',
        //   body: 'there is no image to delete',
        //   boolDialog: false,
        // );

        print('there is no image to delete');

      } else {

        await CenterDialog.showCenterDialog(
          context: context,
          title: 'Can not delete image',
          body: '${_result.toString()}',
          boolDialog: false,
        );

      }

    }

    /// if result is null, so no error was thrown and procedure succeeded
    else {

      // await superDialog(
      //   context: context,
      //   title: '',
      //   body: 'Picture has been deleted',
      //   boolDialog: false,
      // );

      print('picture has been deleted');

    }

  }
// -----------------------------------------------------------------------------
}
