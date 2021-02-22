import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
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
