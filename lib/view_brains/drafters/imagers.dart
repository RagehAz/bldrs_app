// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'file_formatters.dart';
// === === === === === === === === === === === === === === === === === === ===
DecorationImage superImage(String picture, BoxFit boxFit){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: boxFit,
  );

  return picture == '' ? null : image;
}
// === === === === === === === === === === === === === === === === === === ===
Widget superImageWidget(dynamic pic){
  return
    objectIsJPGorPNG(pic)?
    Image.asset(pic, fit: BoxFit.cover,)
        :
    objectIsSVG(pic)?
    WebsafeSvg.asset(pic, fit: BoxFit.cover)
        :
    /// max user NetworkImage(userPic), to try it later
    objectIsURL(pic)?
    Image.network(pic, fit: BoxFit.cover,)
        :
    objectIsFile(pic)?
    Image.file(
        pic,
        fit: BoxFit.cover,
    )
    :
  Container();
}
// === === === === === === === === === === === === === === === === === === ===
enum PicType{
  userPic,
  authorPic,
  bzLogo,
  slideHighRes,
  slideLowRes,
}
// === === === === === === === === === === === === === === === === === === ===
int concludeImageQuality(PicType picType){
  switch (picType){
    case PicType.userPic      :   return  70   ;     break;
    case PicType.authorPic    :   return  80   ;     break;
    case PicType.bzLogo       :   return  80   ;     break;
    case PicType.slideHighRes :   return  100  ;     break;
    case PicType.slideLowRes  :   return  60   ;     break;
    default : return   null;
}
}
// === === === === === === === === === === === === === === === === === === ===
double concludeImageMaxWidth(PicType picType){
  switch (picType){
    case PicType.userPic      :   return  150   ;     break;
    case PicType.authorPic    :   return  150   ;     break;
    case PicType.bzLogo       :   return  150   ;     break;
    case PicType.slideHighRes :   return  1000   ;     break;
    case PicType.slideLowRes  :   return  150   ;     break;
    default : return   null;
  }
}
// === === === === === === === === === === === === === === === === === === ===
// double concludeImageMaxHeight(PicType picType){
//   switch (picType){
//     case PicType.userPic      :   return  150   ;     break;
//     case PicType.authorPic    :   return  200   ;     break;
//     case PicType.bzLogo       :   return  400   ;     break;
//     case PicType.slideHighRes :   return  800   ;     break;
//     case PicType.slideLowRes  :   return  400   ;     break;
//     default : return   null;
//   }
// }
// === === === === === === === === === === === === === === === === === === ===
Future<PickedFile> takeGalleryPicture(PicType picType) async {
  final _picker = ImagePicker();

  final _imageFile = await _picker.getImage(
    source: ImageSource.gallery,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  return _imageFile;

}
// === === === === === === === === === === === === === === === === === === ===
Future<PickedFile> takeCameraPicture(PicType picType) async {
  final _picker = ImagePicker();

  final _imageFile = await _picker.getImage(
    source: ImageSource.camera,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  return _imageFile;

}
// === === === === === === === === === === === === === === === === === === ===
/// secret sacred code that will fix the world someday
// final _appDir = await sysPaths.getApplicationDocumentsDirectory();
// final _fileName = path.basename(_imageFile.path);
// final _savedImage = await _currentPic.copy('${_appDir.path}/$_fileName');
// _selectImage(savedImage);
// // === === === === === === === === === === === === === === === === === === ===
class ImageSize{
  final int width;
  final int height;

  ImageSize({
    @required this.width,
    @required this.height,
});
}
// === === === === === === === === === === === === === === === === === === ===
Future<ImageSize> superImageSize(dynamic image) async {
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  ImageSize imageSize =  ImageSize(width: decodedImage.width, height: decodedImage.height);
  return imageSize;
}
// // === === === === === === === === === === === === === === === === === === ===
