// import 'package:path_provider/path_provider.dart' as sysPaths;
// import 'package:path/path.dart' as path;
// import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
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
class ImageSize{
  final int width;
  final int height;

  ImageSize({
    @required this.width,
    @required this.height,
  });
}
// -----------------------------------------------------------------------------
class Imagers{
// -----------------------------------------------------------------------------
static DecorationImage superImage(String picture, BoxFit boxFit){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: boxFit,
  );

  return picture == '' ? null : image;
}
// -----------------------------------------------------------------------------
  static Widget superImageWidget(dynamic pic, {int width, int height, BoxFit fit, double scale}){

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
        width: width?.toDouble(),
        height: height?.toDouble(),
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
  static int concludeImageQuality(PicType picType){
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
  static double concludeImageMaxWidth(PicType picType){
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
  ///
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
  ///
// -----------------------------------------------------------------------------
  /// secret sacred code that will fix the world someday
  /// final _appDir = await sysPaths.getApplicationDocumentsDirectory();
  /// final _fileName = path.basename(_imageFile.path);
  /// final _savedImage = await _currentPic.copy('${_appDir.path}/$_fileName');
  /// _selectImage(savedImage);
  static Future<File> takeGalleryPicture(PicType picType) async {
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
  static Future<PickedFile> takeCameraPicture(PicType picType) async {
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
  static Future<ImageSize> superImageSize(dynamic image) async {
  var decodedImage = await decodeImageFromList(image.readAsBytesSync());
  ImageSize imageSize =  ImageSize(width: decodedImage.width, height: decodedImage.height);
  return imageSize;
}
// -----------------------------------------------------------------------------
  static Future<Uint8List> getBytesFromAsset(String iconPath, int width) async {
  ByteData data = await rootBundle.load(iconPath);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}
// -----------------------------------------------------------------------------
  static Future <Uint8List> getBytesFromCanvas(int width, int height, urlAsset) async {
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
  static Future <ui.Image> loadImage(List < int > img) async {
  final Completer < ui.Image > completer = new Completer();
  ui.decodeImageFromList(img, (ui.Image img) {

    return completer.complete(img);
  });
  return completer.future;
}
// -----------------------------------------------------------------------------
  static Future<File> getImageFileFromLocalAsset(BuildContext context, String inputAsset) async {
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
  static Future<File> urlToFile(String imageUrl) async {
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
// -----------------------------------------------------------------------------
  static Future<List<Asset>> getMultiImagesFromGallery({BuildContext context, List<Asset> images, bool mounted, @required BzAccountType accountType}) async {
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
        selectionLimitReachedText: 'Can\'t add more Images !',
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
  static Future<File> getFileFromCropperAsset(Asset asset) async {
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
  static List<CropAspectRatioPreset> getAndroidCropAspectRatioPresets(){
    List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
    ];
    return _androidRatios;
  }
// -----------------------------------------------------------------------------
  static List<CropAspectRatioPreset> getIOSCropAspectRatioPresets(){
    List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9,
    ];
    return _androidRatios;
  }
// -----------------------------------------------------------------------------
  static Future<File> cropImage(BuildContext context, File file) async {

    /// flyer ratio is : (1 x 1.74)
    double _flyerHeightRatio = Ratioz.xxflyerZoneHeight; // 1.74
    double _maxWidth = 1000;

    File _croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: Ratioz.xxflyerZoneHeight),
      aspectRatioPresets: Platform.isAndroid ? getAndroidCropAspectRatioPresets() : getIOSCropAspectRatioPresets(),
      maxWidth: _maxWidth.toInt(),
      compressFormat: ImageCompressFormat.jpg, /// TASK : need to test png vs jpg storage sizes on firebase
      compressQuality: 100, // max
      cropStyle: CropStyle.rectangle,
      maxHeight: (_maxWidth * _flyerHeightRatio).toInt(),
      androidUiSettings: AndroidUiSettings(
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,

        statusBarColor: Colorz.Black255,
        backgroundColor: Colorz.Black230,
        dimmedLayerColor: Colorz.Black200,

        toolbarTitle: 'Crop Image',//'Crop flyer Aspect Ratio 1:${Ratioz.xxflyerZoneHeight}',
        toolbarColor: Colorz.Black255,
        toolbarWidgetColor: Colorz.White255, // color of : cancel, title, confirm widgets

        activeControlsWidgetColor: Colorz.Yellow255,
        hideBottomControls: false,

        cropFrameColor: Colorz.Grey80,
        cropFrameStrokeWidth: 5,

        showCropGrid: true,
        cropGridColumnCount: 3,
        cropGridRowCount: 6,
        cropGridColor: Colorz.Grey80,
        cropGridStrokeWidth: 2,

      ),

      /// TASK : check cropper in ios
      // iosUiSettings: IOSUiSettings(
      //   title: 'Crop flyer Aspect Ratio 1 : ${Ratioz.xxflyerZoneHeight}',
      //   doneButtonTitle: 'Done babe',
      //   aspectRatioLockDimensionSwapEnabled: ,
      //   aspectRatioLockEnabled: ,
      //   aspectRatioPickerButtonHidden: ,
      //   cancelButtonTitle: ,
      //   hidesNavigationBar: ,
      //   minimumAspectRatio: ,
      //   rectHeight: ,
      //   rectWidth: ,
      //   rectX: ,
      //   rectY: ,
      //   resetAspectRatioEnabled: ,
      //   resetButtonHidden: ,
      //   rotateButtonsHidden: ,
      //   rotateClockwiseButtonHidden: ,
      //   showActivitySheetOnDone: ,
      //   showCancelConfirmationDialog: ,
      // ),
    );

    if (_croppedFile == null){
      return null;
    }

    else {
      return _croppedFile;
    }

  }
// -----------------------------------------------------------------------------
  static BoxFit concludeBoxFitOld(Asset asset){
  BoxFit _fit = asset.isPortrait ? BoxFit.fitHeight : BoxFit.fitWidth;
  return _fit;
  }
// -----------------------------------------------------------------------------
  bool slideBlurIsOn({
    @required dynamic pic,
    @required ImageSize imageSize,
    @required BoxFit boxFit,
    @required double flyerZoneWidth
  }) {
    /// blur layer shall only be active if the height of image supplied is smaller
    /// than flyer height when image width = flyerWidth
    /// hangebha ezzay dih
    // picture == null ? false :
    // ObjectChecker.objectIsJPGorPNG(picture) ? false :
    // boxFit == BoxFit.cover ? true :
    // boxFit == BoxFit.fitWidth || boxFit == BoxFit.contain || boxFit == BoxFit.scaleDown ? true :
    //     false;

    bool _blurIsOn = false;

    bool _imageSizeIsValid =
    imageSize == null ? false :
    imageSize.width == null ? false :
    imageSize.height == null ? false :
    imageSize.width <= 0 ? false :
    imageSize.height <= 0 ? false :
    true;

    if(_imageSizeIsValid == true){

      /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
      int _originalImageWidth = imageSize.width;
      int _originalImageHeight= imageSize.height;
      double _originalImageRatio = _originalImageWidth / _originalImageHeight
      ;
      /// slide aspect ratio : 1 / 1.74 ~= 0.575
      double _flyerZoneHeight = flyerZoneWidth * Ratioz.xxflyerZoneHeight;
      double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

      double _fittedImageWidth;
      double _fittedImageHeight;

      /// if fit width
      if (boxFit == BoxFit.fitWidth){
        _fittedImageWidth = flyerZoneWidth;
        _fittedImageHeight= flyerZoneWidth / _originalImageRatio;
      }

      /// if fit height
      else {
        _fittedImageWidth = _flyerZoneHeight * _originalImageRatio;
        _fittedImageHeight= _flyerZoneHeight;
      }

      double _fittedImageRatio = _fittedImageWidth / _fittedImageHeight;


      /// so
      /// if _originalImageRatio < 0.575 image is narrower than slide,
      /// if ratio > 0.575 image is wider than slide
      double _errorPercentage = Ratioz.slideFitWidthLimit; // ~= max limit from flyer width => flyerZoneWidth * 90%
      double _maxRatioForBlur = _slideRatio / (_errorPercentage / 100);
      double _minRatioForBlur = _slideRatio * (_errorPercentage / 100);

      /// so if narrower more than 10% or wider more than 10%, blur should be active and boxFit shouldn't be cover
      if(_minRatioForBlur > _fittedImageRatio || _fittedImageRatio > _maxRatioForBlur){
        _blurIsOn = true;
      }

      else {
        _blurIsOn = false;
      }

    File _file = pic;
      // print('A - pic : ${_file?.fileNameWithExtension?.toString()}');
      // print('B - ratio : $_fittedImageRatio = W:$_fittedImageWidth / H:$_fittedImageHeight');
      // print('C - Fit : $boxFit');
      // print('C - blur : $_blurIsOn');

    }



    return _blurIsOn;
}
// -----------------------------------------------------------------------------
  static BoxFit concludeBoxFit({Asset asset, double flyerZoneWidth}){
  BoxFit _boxFit;

  /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
  int _originalImageWidth = asset.originalWidth;
  int _originalImageHeight= asset.originalHeight;
  // double _originalImageRatio = _originalImageWidth / _originalImageHeight
  ;
  /// slide aspect ratio : 1 / 1.74 ~= 0.575
  double _flyerZoneHeight = flyerZoneWidth * Ratioz.xxflyerZoneHeight;
  // double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

  // double _fittedImageWidth = flyerZoneWidth; // for info only
  double _fittedImageHeight = (flyerZoneWidth * _originalImageHeight) / _originalImageWidth;

  double _heightAllowingFitHeight = (Ratioz.slideFitWidthLimit/100) * _flyerZoneHeight;

  /// if fitted height is less than the limit
  if(_fittedImageHeight < _heightAllowingFitHeight){
    _boxFit = BoxFit.fitWidth;
  }

  /// if fitted height is higher that the limit
  else {
    _boxFit = BoxFit.fitHeight;
  }

  return _boxFit;
  }
}