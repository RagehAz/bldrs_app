// import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
// import 'package:bldrs/f_helpers/drafters/text_mod.dart';
// import 'package:filers/filers.dart';
//
// class OldStorageMethods {
//   // -----------------------------------------------------------------------------
//
//   const OldStorageMethods();
//
//   // -----------------------------------------------------------------------------
//
//   /// CREATE
//
//   // --------------------
//   /*
//   /// protocol
//   /// TESTED : WORKS PERFECT
//   static Future<String> createStoragePicAndGetURL({
//     @required File inputFile,
//     @required String collName,
//     @required String docName,
//     @required List<String> ownersIDs,
//   }) async {
//
//     /// NOTE
//     /// creates new pic in document name according to pic type,
//     /// and overrides existing pic if already exists
//
//     String _imageURL;
//
//     await tryAndCatch(
//         invoker: 'createStoragePicAndGetURL',
//         functions: () async {
//
//           final Dimensions imageSize = await Dimensions.superDimensions(inputFile);
//
//           final Map<String, String> _metaDataMap = <String, String>{
//             'width': '${imageSize.width}',
//             'height': '${imageSize.height}',
//           };
//
//           _imageURL = await Storage.uploadFileAndGetURL(
//             storageCollName: collName,
//             docName: docName,
//             file: inputFile,
//             ownersIDs: ownersIDs,
//             metaDataAddOn: _metaDataMap,
//           );
//
//         });
//
//     return _imageURL;
//   }
//    */
//   // --------------------
//   /*
//   /// flyerStorageOps
//   /// TESTED : WORKS PERFECT
//   static Future<List<String>> createStorageSlidePicsAndGetURLs({
//     @required List<SlideModel> slides,
//     @required String flyerID,
//     @required String bzCreatorID,
//     @required String flyerAuthorID,
//     ValueChanged<List<String>> onFinished,
//   }) async {
//
//     final List<String> _picturesURLs = <String>[];
//
//     if (Mapper.checkCanLoopList(slides) == true && flyerID != null && bzCreatorID != null){
//
//       await Future.wait(<Future>[
//
//         ...List.generate(slides.length, (index) async {
//
//           final String _picURL = await createStoragePicAndGetURL(
//             inputFile: slides[index].picPath,
//             collName: StorageColl.slides,
//             ownersIDs: <String>[bzCreatorID, flyerAuthorID],
//             docName: SlideModel.generateSlideID(
//               flyerID: flyerID,
//               slideIndex: slides[index].slideIndex,
//             ),
//           );
//
//           _picturesURLs.add(_picURL);
//
//         }),
//
//       ]);
//
//     }
//
//     if (onFinished != null){
//       onFinished(_picturesURLs);
//     }
//
//     return _picturesURLs;
//   }
//    */
//   // --------------------
//   /*
//   /// protocol
//   static Future<List<String>> createMultipleStoragePicsAndGetURLs({
//     @required List<File> files,
//     @required List<String> docsNames,
//     @required List<String> ownersIDs,
//     @required String collName,
//   }) async {
//
//     final List<String> _picsURLs = <String>[];
//
//     if (
//         Mapper.checkCanLoopList(files)
//         &&
//         Mapper.checkCanLoopList(docsNames)
//         &&
//         files.length == docsNames.length
//     ) {
//
//       await Future.wait(<Future>[
//
//         ...List.generate(files.length, (index){
//
//           final File _file = files[index];
//           final String _name = docsNames[index];
//
//           return createStoragePicAndGetURL(
//             inputFile: _file,
//             collName: collName,
//             docName: _name,
//             ownersIDs: ownersIDs,
//           ).then((String url){
//             _picsURLs.add(url);
//           });
//
//       }),
//
//       ]);
//
//     }
//
//     return _picsURLs;
//   }
//    */
//   // --------------------
//   /*
//   /// protocol
//   /// TASK : createStoragePicFromAssetAndGetURL not tested properly
//   static Future<String> createStoragePicFromLocalAssetAndGetURL({
//     @required String asset,
//     @required String docName,
//     @required String collName,
//     @required List<String> ownersIDs,
//   }) async {
//     String _url;
//
//     final File _result = await Filers.getFileFromLocalRasterAsset(
//       localAsset: asset,
//     );
//
//     blog('uploading $docName pic to fireStorage in folder of $collName');
//
//     _url = await createStoragePicAndGetURL(
//       docName: docName,
//       collName: collName,
//       inputFile: _result,
//       ownersIDs: ownersIDs,
//     );
//
//     blog('uploaded pic : $_url');
//
//     return _url;
//   }
//    */
//   // -----------------------------------------------------------------------------
//
//   /// UPDATE
//
//   // --------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   static Future<String> updateExistingPic({
//     @required String oldURL,
//     @required File newPic,
//   }) async {
//     String _output;
//
//     if (oldURL != null && newPic != null){
//
//       await tryAndCatch(
//         invoker: 'updateExistingPic',
//         functions: () async {
//
//           final Reference _ref = await StorageRef.byURL(
//             url: oldURL,
//           );
//
//           final FullMetadata _fullMeta = await _ref?.getMetadata();
//
//           final Map<String, dynamic> _existingMetaData = _fullMeta?.customMetadata;
//
//           final SettableMetadata metaData = SettableMetadata(
//             customMetadata: _existingMetaData,
//           );
//
//           await _ref?.putFile(newPic, metaData);
//
//           _output = await _ref?.getDownloadURL();
//
//
//         },
//       );
//
//     }
//
//     return _output;
//   }
//    */
//   // --------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   static Future<String> createOrUpdatePic({
//     @required String oldURL,
//     @required File newPic,
//     @required String collName,
//     @required String docName,
//     @required List<String> ownersIDs,
//   }) async {
//     /// returns updated pic new URL
//
//     String _outputURL;
//
//     final bool _oldURLIsValid = ObjectCheck.isAbsoluteURL(oldURL);
//
//     /// when old url exists
//     if (_oldURLIsValid == true){
//
//       _outputURL = await updateExistingPic(
//         oldURL: oldURL,
//         newPic: newPic,
//       );
//
//     }
//
//     /// when no existing image url
//     else {
//
//       _outputURL = await createStoragePicAndGetURL(
//         inputFile: newPic,
//         ownersIDs: ownersIDs,
//         collName: collName,
//         docName: docName,
//       );
//
//     }
//
//     return _outputURL;
//   }
//    */
//   // -----------------------------------------------------------------------------
//
//   /// DELETE
//
//   // --------------------
//   /*
//   /// TESTED : WORKS PERFECT
//   static Future<void> deleteStoragePic({
//     @required String collName,
//     @required String docName,
//   }) async {
//
//     blog('deleteStoragePic : START');
//
//     final bool _canDelete = await checkCanDeleteStorageFile(
//       docName: docName,
//       collName: collName,
//     );
//
//     if (_canDelete == true){
//
//       final dynamic _result = await tryCatchAndReturnBool(
//           invoker: 'deleteStoragePic',
//           functions: () async {
//
//             final Reference _picRef = StorageRef.byNodes(
//               collName: collName,
//               docName: docName,
//             );
//
//             // blog('pic ref : $_picRef');
//             // final FullMetadata _metaData = await _picRef?.getMetadata();
//             // blogFullMetaData(_metaData);
//
//             await _picRef?.delete();
//           },
//           onError: (String error) async {
//
//             const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';
//             if (error == _noImageError){
//
//               blog('deleteStoragePic : NOT FOUND AND NOTHING IS DELETED :docName $collName : picName : $docName');
//
//             }
//             else {
//               blog('deleteStoragePic : $collName/$docName : error : $error');
//             }
//
//           }
//       );
//
//       /// if result is true
//       if (_result == true) {
//         blog('deleteStoragePic : IMAGE HAS BEEN DELETED :docName $collName : picName : $docName');
//       }
//
//       // else {
//       //
//       // }
//
//     }
//
//     else {
//       blog('deleteStoragePic : CAN NOT DELETE STORAGE FILE');
//     }
//
//
//     blog('deleteStoragePic : END');
//
//   }
//    */
//   // -----------------------------------------------------------------------------
//
//   /// CHECKER
//
//   // --------------------
//   /// CAN NOT STOP STORAGE ( Object does not exist at location ) EXCEPTION
//   /*
//   bool checkStorageImageExists(){
//     /// AFTER SOME SEARCHING,, NO WAY TO STOP STORAGE SDK THROWN EXCEPTION
//     /// WHEN THE IMAGE TRIED TO BE CALLED DOES NOT EXISTS.
//     /// END OF STORY
//   }
//  */
// }
