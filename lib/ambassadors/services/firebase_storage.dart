import 'dart:io';
import 'package:bldrs/view_brains/drafters/imagers.dart';
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
    case PicType.userPic        :   return   'usersPics';       break;
    case PicType.authorPic      :   return   'authorsPics';     break;
    case PicType.bzLogo         :   return   'bzLogos';         break;
    case PicType.slideHighRes   :   return   'slidesPics';      break;
    case PicType.slideLowRes    :   return   'slidesPicsLow';   break;
    default : return   null;
  }
}
// === === === === === === === === === === === === === === === === === === ===
