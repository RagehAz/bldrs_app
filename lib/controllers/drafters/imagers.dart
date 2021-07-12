// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
// import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'object_checkers.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
// -----------------------------------------------------------------------------
DecorationImage superImage(String picture, BoxFit boxFit){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: boxFit,
  );

  return picture == '' ? null : image;
}
// -----------------------------------------------------------------------------
Widget superImageWidget(dynamic pic, {int width, int height, BoxFit fit, double scale}){

  BoxFit _boxFit = fit == null ? BoxFit.cover : fit;

  // int _width = fit == BoxFit.fitWidth ? width : null;
  // int _height = fit == BoxFit.fitHeight ? height : null;

  Asset _asset = ObjectChecker.objectIsAsset(pic) ? pic : null;

  double _scale = scale == null ? 1 : scale;

  return
    Transform.scale(
      scale: _scale,
      child:
      ObjectChecker.objectIsJPGorPNG(pic)?
      Image.asset(pic, fit: _boxFit)
          :
      ObjectChecker.objectIsSVG(pic)?
      WebsafeSvg.asset(pic, fit: _boxFit,)
          :
      /// max user NetworkImage(userPic), to try it later
      ObjectChecker.objectIsURL(pic)?
      Image.network(pic, fit: _boxFit)
          :
      ObjectChecker.objectIsFile(pic)?
      Image.file(
        pic,
        fit: _boxFit,
        width: width.toDouble(),
        height: height.toDouble(),
      )
          :
      ObjectChecker.objectIsAsset(pic)?
      AssetThumb(
        asset: _asset,
        width: (_asset.originalWidth).toInt(),
        height: (_asset.originalHeight).toInt(),
        spinner: Loading(loading: true,),
      )
          :
      Container(),
    );

}
// -----------------------------------------------------------------------------
enum PicType{
  userPic,
  authorPic,
  bzLogo,
  slideHighRes,
  slideLowRes,
  dum,
  askPic,
}
// -----------------------------------------------------------------------------
int concludeImageQuality(PicType picType){
  switch (picType){
    case PicType.userPic      :  return  100   ;  break;
    case PicType.authorPic    :  return  100   ;  break;
    case PicType.bzLogo       :  return  100   ;  break;
    case PicType.slideHighRes :  return  100  ;  break;
    case PicType.slideLowRes  :  return  80   ;  break;
    case PicType.dum          :  return  100  ;  break;
    case PicType.askPic       :  return  100  ;  break;
    default : return   null;
}
}
// -----------------------------------------------------------------------------
double concludeImageMaxWidth(PicType picType){
  switch (picType){
    case PicType.userPic      :  return  150   ;  break;
    case PicType.authorPic    :  return  150   ;  break;
    case PicType.bzLogo       :  return  150   ;  break;
    case PicType.slideHighRes :  return  1000  ;  break;
    case PicType.slideLowRes  :  return  150   ;  break;
    case PicType.dum          :  return  null  ;  break;
    case PicType.askPic       :  return  null  ;  break;
    default : return   null;
  }
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
Future<File> takeGalleryPicture(PicType picType) async {
  final _picker = ImagePicker();

  final _imageFile = await _picker.getImage(
    source: ImageSource.gallery,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  File _result = _imageFile != null ? File(_imageFile.path) : null;

  return _result;
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
/// secret sacred code that will fix the world someday
// final _appDir = await sysPaths.getApplicationDocumentsDirectory();
// final _fileName = path.basename(_imageFile.path);
// final _savedImage = await _currentPic.copy('${_appDir.path}/$_fileName');
// _selectImage(savedImage);
// -----------------------------------------------------------------------------
class ImageSize{
  final int width;
  final int height;

  ImageSize({
    @required this.width,
    @required this.height,
});
}
// -----------------------------------------------------------------------------
Future<ImageSize> superImageSize(dynamic image) async {
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  ImageSize imageSize =  ImageSize(width: decodedImage.width, height: decodedImage.height);
  return imageSize;
}
// -----------------------------------------------------------------------------
Future<Uint8List> getBytesFromAsset(String iconPath, int width) async {
  ByteData data = await rootBundle.load(iconPath);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}
// -----------------------------------------------------------------------------
Future <Uint8List> getBytesFromCanvas(int width, int height, urlAsset) async {
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
// -----------------------------------------------------------------------------
Future <ui.Image> loadImage(List < int > img) async {
  final Completer < ui.Image > completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {

    return completer.complete(img);
  });
  return completer.future;
}
// -----------------------------------------------------------------------------
Future<File> getImageFileFromLocalAsset(BuildContext context, String inputAsset) async {
  File _file;
  String asset = ObjectChecker.objectIsSVG(inputAsset) ? Iconz.DumBusinessLogo : inputAsset;
  await tryAndCatch(
      context: context,
      methodName : 'getImageFileFromAssets',
      functions: () async {
        print('0. removing assets/ from input image path');
        String _pathTrimmed = removeNumberOfCharactersFromAString(asset, 7);
        print('1. starting getting image from assets');
        final _byteData = await rootBundle.load('assets/$_pathTrimmed');
        print('2. we got byteData and creating the File aho');
        final _tempFile = File('${(await getTemporaryDirectory()).path}/${getFileNameFromAsset(_pathTrimmed)}');
        print('3. we created the FILE and will overwrite image data as bytes');
        await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
        await _tempFile.create(recursive: true);
        _file = _tempFile;
        print('4. file is ${_file.path}');
      }
  );
  return _file;
}
// -----------------------------------------------------------------------------
Future<File> urlToFile(String imageUrl) async {
// generate random number.
  var rng = new Random();
// get temporary directory of device.
  Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
  String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
  File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
  http.Response response = await http.get(imageUrl);
// write bodyBytes received in response to file.
  await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
  return file;
}

// Selection full. Deselect
// -----------------------------------------------------------------------------
Future<List<Asset>> getMultiImagesFromGallery({BuildContext context, List<Asset> images, bool mounted, @required BzAccountType accountType}) async {
  List<Asset> resultList = <Asset>[];
  String error = 'No Error Detected';

  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: Standards.getMaxFlyersSlidesByAccountType(accountType),
      enableCamera: true,
      selectedAssets: images,
      cupertinoOptions: CupertinoOptions(
        takePhotoIcon: "Take photo",
        doneButtonTitle: "Done",
      ),
      materialOptions: MaterialOptions(
        actionBarColor: "#13244b",
        actionBarTitle: Wordz.choose(context),
        allViewTitle: "All Photos",
        useDetailsView: false,
        selectCircleStrokeColor: "#ffc000",
        startInAllView: true,
        textOnNothingSelected: 'Nothing is Fucking Selected',
        statusBarColor: "#000000", // the app status bar
        lightStatusBar: false,
        // actionBarTitleColor: "#13244b", // page title color, White is Default
        autoCloseOnSelectionLimit: false,
        selectionLimitReachedText: 'Can\'t add more Imgaes Bitch !',
        // unknown impact
        // backButtonDrawable: 'wtf is this backButtonDrawable',
        // okButtonDrawable: 'dunno okButtonDrawable',
      ),
    );
  } on Exception catch (e) {
    error = e.toString();

    if (error != 'The user has cancelled the selection'){
      await superDialog(
        context: context,
        boolDialog: false,
        title: 'Error',
        body: error,
      );

    }

  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  if (!mounted){
    return null;
  } else {
    return resultList;

  }

}
// -----------------------------------------------------------------------------
Future<File> getFileFromCropperAsset(Asset asset) async {
  ByteData _byteData = await asset.getThumbByteData(asset.originalWidth, asset.originalHeight, quality: 100);

  String _name = trimTextAfterLastSpecialCharacter(asset.name, '.');

  print('====================================================================================== asset name is : ${asset.runtimeType}');

  final _tempFile = File('${(await getTemporaryDirectory()).path}/${_name}');
  await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
  await _tempFile.create(recursive: true);

  File _file = _tempFile;

  return _file;
}
// -----------------------------------------------------------------------------
