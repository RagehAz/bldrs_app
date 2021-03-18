// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
// import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
// === === === === === === === === === === === === === === === === === === ===
Future<Uint8List> getBytesFromAsset(String iconPath, int width) async {
  ByteData data = await rootBundle.load(iconPath);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}
// === === === === === === === === === === === === === === === === === === ===
Future < Uint8List > getBytesFromCanvas(int width, int height, urlAsset) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = Colors.transparent;
  final Radius radius = Radius.circular(20.0);
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      paint);

  final ByteData datai = await rootBundle.load(urlAsset);

  var imaged = await loadImage(new Uint8List.view(datai.buffer));

  canvas.drawImage(imaged, new Offset(0, 0), new Paint());

  final img = await pictureRecorder.endRecording().toImage(width, height);
  final data = await img.toByteData(format: ui.ImageByteFormat.png);
  return data.buffer.asUint8List();
}
// === === === === === === === === === === === === === === === === === === ===
Future < ui.Image > loadImage(List < int > img) async {
  final Completer < ui.Image > completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {

    return completer.complete(img);
  });
  return completer.future;
}
// === === === === === === === === === === === === === === === === === === ===
