import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/models/sub_models/slide_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
Reference _getReferenceFromFirebaseStorage({String documentName, String fileName,}) {
  final ref = FirebaseStorage.instance
      .ref()
      .child(documentName)
      .child(fileName + '.jpg'); // should be bzID

  return ref;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveBzLogoOnFirebaseStorageAndGetURL({File inputFile, String fileName,}) async {
  final _ref = _getReferenceFromFirebaseStorage(documentName: 'bzLogos', fileName: fileName);

  await _ref.putFile(inputFile);

  final _imageURL = await _ref.getDownloadURL();

  return _imageURL;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveAuthorPicOnFirebaseStorageAndGetURL({File inputFile, String fileName,}) async {
  final _ref = _getReferenceFromFirebaseStorage(documentName: 'authorsPics', fileName: fileName);

  await _ref.putFile(inputFile);

  final _imageURL = await _ref.getDownloadURL();

  return _imageURL;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveUserPicOnFirebaseStorageAndGetURL({File inputFile, String fileName,}) async {
  final _ref = _getReferenceFromFirebaseStorage(documentName: 'usersPics', fileName: fileName);

  await _ref?.putFile(inputFile);

  final _imageURL = await _ref.getDownloadURL();

  return _imageURL;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveSlidePicOnFirebaseStorageAndGetURL({File inputFile, String fileName,}) async {
  final _ref = _getReferenceFromFirebaseStorage(documentName: 'slidesPics', fileName: fileName);

  await _ref.putFile(inputFile);

  final _imageURL = await _ref.getDownloadURL();

  return _imageURL;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> savePicOnFirebaseStorageAndGetURL({BuildContext context, File inputFile, String fileName, PicType picType}) async {
  String _imageURL;

  await tryAndCatch(
    context: context,
    functions: () async {

      final _ref = _getReferenceFromFirebaseStorage(documentName: firebaseStorageDocument(picType), fileName: fileName);

      ImageSize imageSize = await superImageSize(inputFile);

      SettableMetadata metaData = SettableMetadata(
        customMetadata: {'width': '${imageSize.width}', 'height': '${imageSize.height}'}
      );

      await _ref.putFile(
          inputFile,
          metaData,
      );

      _imageURL = await _ref.getDownloadURL();

    }
  );
      return _imageURL;
}
// === === === === === === === === === === === === === === === === === === ===
String firebaseStorageDocument(PicType picType){
  switch (picType){
    case PicType.userPic        :   return   'usersPics';       break; // uses userID as file name
    case PicType.authorPic      :   return   'authorsPics';     break; // uses userID as file name
    case PicType.bzLogo         :   return   'bzLogos';         break; // uses bzID as file name
    case PicType.slideHighRes   :   return   'slidesPics';      break; // uses flyerID_slideIndex as file name
    case PicType.slideLowRes    :   return   'slidesPicsLow';   break; // uses flyerID_slideIndex as file name
    case PicType.dum            :   return    'dumz';           break;
    default : return   null;
  }
}
// === === === === === === === === === === === === === === === === === === ===
Future<List<String>> savePicturesToFireStorageAndGetListOfURL(BuildContext context, List<SlideModel> currentSlides, String flyerID) async {
  List<String> _picturesURLs = new List();

  for (var slide in currentSlides) {

    String _picURL = await savePicOnFirebaseStorageAndGetURL(
        context: context,
        inputFile: slide.picture,
        picType: PicType.slideHighRes,
        fileName: '${flyerID}_${slide.slideIndex}'
    );

    _picturesURLs.add(_picURL);

  }

  return _picturesURLs;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveAssetToFireStorageAndGetURL ({BuildContext context, String asset, String fileName, PicType picType}) async {
  String _url;

  File _result = await getImageFileFromAssets(context, asset);

  _url = await savePicOnFirebaseStorageAndGetURL(
    context: context,
    fileName: fileName,
    picType: picType,
    inputFile: _result,
  );

  return _url;
}
// === === === === === === === === === === === === === === === === === === ===
