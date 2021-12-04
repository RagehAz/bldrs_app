import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/standards.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

enum PicType{
  userPic,
  authorPic,
  bzLogo,
  slideHighRes,
  slideLowRes,
  dum,
  askPic,
  notiBanner,
}

// -----------------------------------------------------------------------------

  /// PHONE GALLERY

// ---------------------------------------------------
  Future<File> takeGalleryPicture({@required PicType picType}) async {
    final ImagePicker _picker = ImagePicker();
    File _result;

    final XFile _imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: concludeImageQuality(picType),
      maxWidth: concludeImageMaxWidth(picType),
      // maxHeight: concludeImageMaxHeight(picType)
    );

    if (_imageFile != null){
      _result = File(_imageFile.path);
    }


    return _result;
  }
// ---------------------------------------------------
  Future<File> takeCameraPicture({@required PicType picType}) async {
    final ImagePicker _picker = ImagePicker();

    final XFile _imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: concludeImageQuality(picType),
      maxWidth: concludeImageMaxWidth(picType),
      // maxHeight: concludeImageMaxHeight(picType)
    );

    final File _result = _imageFile != null ? File(_imageFile.path) : null;

    return _result;
  }
// ---------------------------------------------------
  Future<List<Asset>> takeGalleryMultiPictures({
    @required BuildContext context,
    @required List<Asset> images,
    @required bool mounted,
    @required BzAccountType accountType,
  }) async {
    List<Asset> _resultList = <Asset>[];
    String _error = 'No Error Detected';

    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: Standards.getMaxSlidesCount(accountType),
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
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
      _error = e.toString();

      if (_error != 'The user has cancelled the selection'){
        await CenterDialog.showCenterDialog(
          context: context,
          boolDialog: false,
          title: 'Error',
          body: _error,
        );

      }

    }

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
    if (!mounted){
      return null;
    } else {
      return _resultList;

    }

  }
// ---------------------------------------------------
  Future<File> cropImage({
    @required BuildContext context,
    @required File file,
  }) async {

    /// flyer ratio is : (1 x 1.74)
    const double _flyerHeightRatio = Ratioz.xxflyerZoneHeight; // 1.74
    const double _maxWidth = 1000;

    final File _croppedFile = await ImageCropper.cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: Ratioz.xxflyerZoneHeight),
      aspectRatioPresets: Platform.isAndroid ? getAndroidCropAspectRatioPresets() : getIOSCropAspectRatioPresets(),
      maxWidth: _maxWidth.toInt(),
      compressFormat: ImageCompressFormat.jpg, /// TASK : need to test png vs jpg storage sizes on firebase
      compressQuality: 100, // max
      cropStyle: CropStyle.rectangle,
      maxHeight: (_maxWidth * _flyerHeightRatio).toInt(),
      androidUiSettings: const AndroidUiSettings(
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,

        statusBarColor: Colorz.black255,
        backgroundColor: Colorz.black230,
        dimmedLayerColor: Colorz.black200,

        toolbarTitle: 'Crop Image',//'Crop flyer Aspect Ratio 1:${Ratioz.xxflyerZoneHeight}',
        toolbarColor: Colorz.black255,
        toolbarWidgetColor: Colorz.white255, // color of : cancel, title, confirm widgets

        activeControlsWidgetColor: Colorz.yellow255,
        hideBottomControls: false,

        cropFrameColor: Colorz.grey80,
        cropFrameStrokeWidth: 5,

        showCropGrid: true,
        cropGridColumnCount: 3,
        cropGridRowCount: 6,
        cropGridColor: Colorz.grey80,
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

  /// FILE GETTERS

// ---------------------------------------------------
  Future<File> getEmptyFile(String fileName) async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();
    final String _appDocPath = _appDocDir.path;
    final String _filePath = '${_appDocPath}/${fileName}';
    final File _file = File(_filePath);
    return _file;
  }
// ---------------------------------------------------
  /// THIS IS TEMP DIRECTORY
  Future<File> getTempEmptyFile(String fileName) async {
    final Directory _tempDir = await getTemporaryDirectory();
    final String _tempPath = _tempDir.path;
    final String _tempFilePath = '${_tempPath}/${fileName}';
    final File _tempFile = File(_tempFilePath);
    return _tempFile;
  }
// ---------------------------------------------------
  /// TAMAM
  Future<File> getFileFromLocalRasterAsset({
    @required BuildContext context,
    @required String localAsset,
    int width = 100,
  }) async {

    File _file;
    final String _asset = ObjectChecker.objectIsSVG(localAsset) ? Iconz.BldrsAppIcon : localAsset;

    await tryAndCatch(
        context: context,
        methodName : 'getFileFromLocalRasterAsset',
        functions: () async {
          // print('0. removing [assets/] from input image path');
          String _pathTrimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(_asset, 7);
          // print('1. starting getting image from assets');
          // final ByteData _byteData = await rootBundle.load('assets/$_pathTrimmed');
          // print('2. we got byteData and creating the File aho');
          final String _fileName = TextMod.getFileNameFromAsset(_pathTrimmed);
          // final File _tempFile = await getEmptyFile(_fileNae);
          // print('3. we created the FILE and will overwrite image data as bytes');
          // final File _finalFile = await writeBytesOnFile(file: _tempFile, byteData: _byteData);
          // _tempFile.delete(recursive: true);
          //
          // _file = _finalFile;
          //
          // print('4. file is ${_file.path}');

          Uint8List _uInt = await getUint8ListFromLocalRasterAsset(asset: _asset, width: width);
          _file = await getFileFromUint8List(uInt8List: _uInt, fileName: _fileName);

        }
    );

    return _file;
  }
// ---------------------------------------------------
  Future<File> getFileFromUint8List({
    @required Uint8List uInt8List,
    @required String fileName,
  }) async {
    File _file = await getTempEmptyFile(fileName);

    _file = await writeUint8ListOnFile(
      uint8list: uInt8List,
      file: _file,
    );

    return _file;
  }
// ---------------------------------------------------
  Future<File> getFileFromURL(String imageUrl) async {
    /// generate random number.
    final Random _rng = new Random();
    /// get temporary directory of device.
    final Directory _tempDir = await getTemporaryDirectory();
    /// get temporary path from temporary directory.
    final String _tempPath = _tempDir.path;
    /// create a new file in temporary path with random file name.
    final File _file = new File('$_tempPath'+ (_rng.nextInt(100)).toString() +'.png');
    /// call http.get method and pass imageUrl into it to get response.
    final Uri _imageUri = Uri.parse(imageUrl);
    final http.Response _response = await http.get(_imageUri);
    /// write bodyBytes received in response to file.
    await _file.writeAsBytes(_response.bodyBytes);
    /// now return the file which is created with random name in
    /// temporary directory and image bytes from response is written to // that file.
    return _file;
  }
// ---------------------------------------------------
  Future<File> getFileFromPickerAsset(Asset asset) async {
    ByteData _byteData = await asset.getThumbByteData(asset.originalWidth, asset.originalHeight, quality: 100);

    String _name = TextMod.removeTextAfterLastSpecialCharacter(asset.name, '.');

    print('====================================================================================== asset name is : ${asset.runtimeType}');

    final File _tempFile = File('${(await getTemporaryDirectory()).path}/${_name}');
    await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
    await _tempFile.create(recursive: true);

    File _file = _tempFile;

    return _file;
  }
// ---------------------------------------------------
  Future<List<File>> getFilesFromPickerAssets(List<Asset> assets) async {
    List<File> _files = <File>[];

    if (Mapper.canLoopList(assets)){

      for (Asset asset in assets) {

        final File _file = await getFileFromPickerAsset(asset);
        _files.add(_file);

      }

    }

    return _files;
  }
// ---------------------------------------------------
  Future<File> getFileFromDynamic(dynamic pic) async {
    File _file;

    if(pic != null){

      if(ObjectChecker.objectIsFile(pic) == true){
        _file = pic;
      }

      else if (ObjectChecker.objectIsAsset(pic) == true){
        _file = await  getFileFromPickerAsset(pic);
      }

      else if (ObjectChecker.objectIsURL(pic) == true){
        _file = await getFileFromURL(pic);
      }

      else if (ObjectChecker.objectIsJPGorPNG(pic) == true){
        // _file = await getFile
      }

    }

    return _file;
  }
// ---------------------------------------------------
  Future<File> getFilerFromBase64(String base64) async {

    final Uint8List _fileAgainAsInt = await base64Decode(base64);

    final File _fileAgain = await getFileFromUint8List(
      uInt8List: _fileAgainAsInt,
      fileName: '${Numeric.createUniqueID()}',
    );

    return _fileAgain;
  }
// -----------------------------------------------------------------------------

  /// FILE WRITING

// ---------------------------------------------------
  Future<File> writeUint8ListOnFile({@required File file, @required Uint8List uint8list}) async {
    await file.writeAsBytes(uint8list);
    await file.create(recursive: true);
    return file;
  }
// ---------------------------------------------------
  Future<File> writeBytesOnFile({@required File file, @required ByteData byteData}) async {
    File _file;

    if (file != null && byteData != null){
      final Uint8List _uInts = getUint8ListFromByteData(byteData);
      _file = await writeUint8ListOnFile(file: file, uint8list: _uInts);
    }

    return _file;
  }
// -----------------------------------------------------------------------------

  /// PICKER ASSET

// ---------------------------------------------------
  Future<Asset> getPickerAssetFromURL(String url) async {
    File _file = await getFileFromURL(url);
    Asset _asset;

    ImageSize imageSize = await ImageSize.superImageSize(_file);
    //
    //
    _asset = Asset(
      // identifier
      _file.fileNameWithExtension,
      // _name
      _file.fileNameWithExtension,
      // _originalWidth
      imageSize.width.toInt(),
      // _originalHeight
      imageSize.height.toInt(),
    );
    //
    //   // ByteData _byteData = await _file.get(asset.originalWidth, asset.originalHeight, quality: 100);
    //   //
    //   // String _name = TextMod.trimTextAfterLastSpecialCharacter(asset.name, '.');
    //   //
    //   // print('====================================================================================== asset name is : ${asset.runtimeType}');
    //   //
    //   // final _tempFile = File('${(await getTemporaryDirectory()).path}/${_name}');
    //   // await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
    //   // await _tempFile.create(recursive: true);
    //
    //   // File _file = _tempFile;
    //
    return _asset;
    //
  }
// ---------------------------------------------------
  Asset getOnlyAssetFromDynamic(dynamic input){
    Asset _asset;
    if(ObjectChecker.objectIsAsset(input) == true){
      _asset = input;
    }

    return _asset;
  }
// ---------------------------------------------------
  List<Asset> getOnlyAssetsFromDynamics(List<dynamic> inputs){
    List<Asset> _assets = <Asset>[];

    if (Mapper.canLoopList(inputs)){

      for (dynamic x in inputs){
        _assets.add(getOnlyAssetFromDynamic(x));
      }

    }

    return _assets;
  }
// -----------------------------------------------------------------------------

  /// ui.Image

// ---------------------------------------------------
  Future<ui.Image> getUiImageFromUint8List(Uint8List uInt) async {
    ui.Image _decodedImage;

    if(uInt != null){
      _decodedImage= await decodeImageFromList(uInt);
    }

    return _decodedImage;
  }
// ---------------------------------------------------
  Future<ui.Image> getUiImageFromIntList(List<int> img) async {

    final Completer<ui.Image> completer = new Completer<ui.Image>();

    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }
// -----------------------------------------------------------------------------

  /// uInt8List

// ---------------------------------------------------
  Uint8List getUint8ListFromByteData(ByteData byteData){
    final Uint8List _uInts = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return _uInts;
  }
// ---------------------------------------------------
  Future<Uint8List> getUint8ListFromFile(File file) async {
    final Uint8List _uInt = await file.readAsBytes();
    return _uInt;
  }
// ---------------------------------------------------
  Future<List<Uint8List>> getUint8ListsFromFiles(List<File> files) async {
    List<Uint8List> _screenShots = <Uint8List>[];

    if (Mapper.canLoopList(files)){
      for (File file in files){
        final Uint8List _uInt = await getUint8ListFromFile(file);
        _screenShots.add(_uInt);
      }
    }

    return _screenShots;
  }
// ---------------------------------------------------
  /// TAMAM
  Future<Uint8List> getUint8ListFromLocalRasterAsset({@required String asset, @required int width}) async {
    final ByteData _byteData = await rootBundle.load(asset);


    final ui.Codec _codec = await ui.instantiateImageCodec(_byteData.buffer.asUint8List(), targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _result = (await _fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    return _result;
  }
// ---------------------------------------------------
  Future<Uint8List> getUint8ListFromRasterURL(int width, int height, String urlAsset) async {

  final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
  final Canvas _canvas = Canvas(_pictureRecorder);
  final Paint _paint = Paint()..color = Colors.transparent;
  const Radius _radius = const Radius.circular(20.0);

  _canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, width.toDouble(), height.toDouble()),
        topLeft: _radius,
        topRight: _radius,
        bottomLeft: _radius,
        bottomRight: _radius,
      ),
      _paint
  );

  final ByteData _detail = await rootBundle.load(urlAsset);
  final ui.Image _imaged = await getUiImageFromIntList(new Uint8List.view(_detail.buffer));

  _canvas.drawImage(_imaged, const Offset(0, 0), Paint());

  final ui.Image _img = await _pictureRecorder.endRecording().toImage(width, height);
  final ByteData _data = await _img.toByteData(format: ui.ImageByteFormat.png);

  return _data.buffer.asUint8List();
}
// -----------------------------------------------------------------------------

  /// Base64

// ---------------------------------------------------
  Future<String> getBase64FromFileOrURL(dynamic image) async {

    File _file;

    bool _isFile = ObjectChecker.objectIsFile(image);
    // bool _isString = ObjectChecker.objectIsString(image);

    if (_isFile == true){
      _file = image;
    } else {
      _file = await getFileFromURL(image);
    }

    final List<int> imageBytes = _file.readAsBytesSync();

    final String _base64Image = base64Encode(imageBytes);

    /*

        Uint8List _bytesImage;

        String _imgString = 'iVBORw0KGgoAAAANSUhEUg.....';

        _bytesImage = Base64Decoder().convert(_imgString);

        Image.memory(_bytesImage)

     */


    return _base64Image;
  }
// -----------------------------------------------------------------------------

  /// BitmapDescriptor

// ---------------------------------------------------
  Future<BitmapDescriptor> getBitmapFromSVG({
    @required BuildContext context,
    @required String assetName,
  }) async {
    // Read SVG file as String
    String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
    double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
// ---------------------------------------------------
  Future<BitmapDescriptor> getBitmapFromPNG({String pngPic = Iconz.FlyerPinPNG}) async {
    final BitmapDescriptor _marker = await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, pngPic);
    return _marker;
  }
// -----------------------------------------------------------------------------

  /// BOX FIT

// ---------------------------------------------------
  BoxFit concludeBoxFitOld(Asset asset){
    BoxFit _fit = asset.isPortrait ? BoxFit.fitHeight : BoxFit.fitWidth;
    return _fit;
  }
// ---------------------------------------------------
  BoxFit concludeBoxFit({
    @required double picWidth,
    @required double picHeight,
    @required double viewWidth,
    @required double viewHeight,
  }){
    BoxFit _boxFit;

    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    // double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

    // double _fittedImageWidth = flyerBoxWidth; // for info only
    final double _fittedImageHeight = (viewWidth * picHeight) / picWidth;

    final double _heightAllowingFitHeight = (Ratioz.slideFitWidthLimit/100) * viewHeight;

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
// ---------------------------------------------------
  BoxFit concludeBoxFitForAsset({
    @required Asset asset,
    @required double flyerBoxWidth,
  }){
    BoxFit _boxFit;

    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    final double _originalImageWidth = asset.originalWidth.toDouble();
    final double _originalImageHeight= asset.originalHeight.toDouble();
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    /// slide aspect ratio : 1 / 1.74 ~= 0.575
    final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;

    _boxFit = concludeBoxFit(
      picWidth: _originalImageWidth,
      picHeight: _originalImageHeight,
      viewWidth: flyerBoxWidth,
      viewHeight: _flyerZoneHeight,
    );

    return _boxFit;
  }
// ---------------------------------------------------
  List<BoxFit> concludeBoxesFitsForAssets({
    @required List<Asset> assets,
    @required double flyerBoxWidth,
  }){
    List<BoxFit> _fits = <BoxFit>[];

    for (Asset asset in assets){

      /// straigh forward solution,, bas ezzay,, I'm Rage7 and I can't just let it go keda,,
      // if(asset.isPortrait){
      //   _fits.add(BoxFit.fitHeight);
      // } else {
      //   _fits.add(BoxFit.fitWidth);
      // }

      /// boss ba2a
      final BoxFit _fit = concludeBoxFitForAsset(asset: asset, flyerBoxWidth: flyerBoxWidth);

      _fits.add(_fit);
    }

    return _fits;
  }
// -----------------------------------------------------------------------------

  /// CropAspectRatioPreset

// ---------------------------------------------------
  List<CropAspectRatioPreset> getAndroidCropAspectRatioPresets(){
    const List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
    ];
    return _androidRatios;
  }
// ---------------------------------------------------
  List<CropAspectRatioPreset> getIOSCropAspectRatioPresets(){
    const List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
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

  /// CHECKERS

// ---------------------------------------------------
  bool slideBlurIsOn({
    @required dynamic pic,
    @required ImageSize imageSize,
    @required BoxFit boxFit,
    @required double flyerBoxWidth
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

    bool _imageSizeIsValid;

    if (
        imageSize == null ||
        imageSize.width == null ||
        imageSize.height == null ||
        imageSize.width <= 0 ||
        imageSize.height <= 0
    ){
      _imageSizeIsValid = false;
    }
    else {
      _imageSizeIsValid = true;
    }


    if(_imageSizeIsValid == true){

      /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
      final int _originalImageWidth = imageSize.width.toInt();
      final int _originalImageHeight= imageSize.height.toInt();
      final double _originalImageRatio = _originalImageWidth / _originalImageHeight
      ;
      /// slide aspect ratio : 1 / 1.74 ~= 0.575
      final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;
      const double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

      double _fittedImageWidth;
      double _fittedImageHeight;

      /// if fit width
      if (boxFit == BoxFit.fitWidth){
        _fittedImageWidth = flyerBoxWidth;
        _fittedImageHeight= flyerBoxWidth / _originalImageRatio;
      }

      /// if fit height
      else {
        _fittedImageWidth = _flyerZoneHeight * _originalImageRatio;
        _fittedImageHeight= _flyerZoneHeight;
      }

      final double _fittedImageRatio = _fittedImageWidth / _fittedImageHeight;


      /// so
      /// if _originalImageRatio < 0.575 image is narrower than slide,
      /// if ratio > 0.575 image is wider than slide
      const double _errorPercentage = Ratioz.slideFitWidthLimit; // ~= max limit from flyer width => flyerBoxWidth * 90%
      const double _maxRatioForBlur = _slideRatio / (_errorPercentage / 100);
      const double _minRatioForBlur = _slideRatio * (_errorPercentage / 100);

      /// so if narrower more than 10% or wider more than 10%, blur should be active and boxFit shouldn't be cover
      if(_minRatioForBlur > _fittedImageRatio || _fittedImageRatio > _maxRatioForBlur){
        _blurIsOn = true;
      }

      else {
        _blurIsOn = false;
      }

    // File _file = pic;
      // print('A - pic : ${_file?.fileNameWithExtension?.toString()}');
      // print('B - ratio : $_fittedImageRatio = W:$_fittedImageWidth / H:$_fittedImageHeight');
      // print('C - Fit : $boxFit');
      // print('C - blur : $_blurIsOn');

    }

    return _blurIsOn;
}
// ---------------------------------------------------
  bool picturesURLsAreTheSame({
    @required List<String> urlsA,
    @required List<String> urlsB,
  }){
    bool _areTheSame = true;

    if (urlsA == null && urlsB != null){
      _areTheSame = false;
    }

    else if (urlsA != null && urlsB == null){
      _areTheSame = false;
    }

    else if (urlsA.length != urlsB.length){
      _areTheSame = false;
    }

    else {
      for (int i =0; i< urlsA.length; i++){
        if (urlsA[i] != urlsB[i]){
          _areTheSame = false;
          break;
        }
      }
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------

  /// IMAGE QUALITY

// ---------------------------------------------------
  int concludeImageQuality(PicType picType){
    switch (picType){
      case PicType.userPic      :  return  100   ;  break;
      case PicType.authorPic    :  return  100   ;  break;
      case PicType.bzLogo       :  return  100   ;  break;
      case PicType.slideHighRes :  return  100  ;  break;
      case PicType.slideLowRes  :  return  80   ;  break;
      case PicType.dum          :  return  100  ;  break;
      case PicType.askPic       :  return  100  ;  break;
      case PicType.notiBanner   :  return  100  ; break;
      default : return   100;
    }
  }
// ---------------------------------------------------
  double concludeImageMaxWidth(PicType picType){
    switch (picType){
      case PicType.userPic      :  return  150   ;  break;
      case PicType.authorPic    :  return  150   ;  break;
      case PicType.bzLogo       :  return  150   ;  break;
      case PicType.slideHighRes :  return  1000  ;  break;
      case PicType.slideLowRes  :  return  150   ;  break;
      case PicType.dum          :  return  null  ;  break;
      case PicType.askPic       :  return  null  ;  break;
      default : return   200;
    }
  }
// -----------------------------------------------------------------------------

