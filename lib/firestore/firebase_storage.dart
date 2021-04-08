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
Future<String> getFirebaseStoragePicURL({PicType picType, String fileName}) async {

  final _ref = _getReferenceFromFirebaseStorage(documentName: firebaseStorageDocument(picType), fileName: fileName);

  String _url = await _ref.getDownloadURL();

  return _url;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> savePicOnFirebaseStorageAndGetURL({BuildContext context, File inputFile, String fileName, PicType picType}) async {
  String _imageURL;

  await tryAndCatch(
    context: context,
    functions: () async {

      final _ref = _getReferenceFromFirebaseStorage(documentName: firebaseStorageDocument(picType), fileName: fileName);

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
// === === === === === === === === === === === === === === === === === === ===
String firebaseStorageDocument(PicType picType){
  switch (picType){
    case PicType.userPic        :   return   'usersPics';     break; // uses userID as file name
    case PicType.authorPic      :   return   'authorsPics';   break; // uses userID as file name
    case PicType.bzLogo         :   return   'bzLogos';       break; // uses bzID as file name
    case PicType.slideHighRes   :   return   'slidesPics';    break; // uses flyerID_slideIndex as file name
    case PicType.slideLowRes    :   return   'slidesPics';    break; // uses flyerID_slideIndex as file name
    case PicType.dum            :   return   'dumz';          break;
    case PicType.askPic         :   return   'askPics';       break;
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
        fileName: SlideModel.generateSlideID(flyerID, slide.slideIndex),
    );

    _picturesURLs.add(_picURL);

  }

  return _picturesURLs;
}
// === === === === === === === === === === === === === === === === === === ===
Future<String> saveAssetToFireStorageAndGetURL ({BuildContext context, String asset, String fileName, PicType picType}) async {
  String _url;

  File _result = await getImageFileFromAssets(context, asset);

  print('uploading $fileName pic to fireStorage in folder of $picType');

  _url = await savePicOnFirebaseStorageAndGetURL(
    context: context,
    fileName: fileName,
    picType: picType,
    inputFile: _result,
  );

  print('uploaded pic : $_url');

  return _url;
}
// === === === === === === === === === === === === === === === === === === ===
Future<void> deleteFireBaseStoragePic({BuildContext context, String fileName, PicType picType}) async {

  await tryAndCatch(
  context: context,
    functions: () async {
          Reference _picRef  = _getReferenceFromFirebaseStorage(documentName: firebaseStorageDocument(picType), fileName: fileName);
          await _picRef.delete();
    }
  );

}