import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
enum PicType {
  userPic,
  authorPic,
  bzLogo,
  slideHighRes,
  slideLowRes,
  dum,
  askPic,
  notiBanner,
}

class Imagers {

  Imagers();

// -----------------------------------------------------------------

  /// PHONE GALLERY

// ---------------------------------------
  static Future<List<File>> pickMultipleImages({
    @required BuildContext context,
    @required int maxAssets,
    List<AssetEntity> selectedAssets,
  }) async {

    final List<AssetEntity> pickedAssets = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(

        /// ASSETS SELECTION
        maxAssets: maxAssets,
        selectedAssets: selectedAssets,

        /// ASSETS TYPE
        requestType: RequestType.image,

        // /// GRID AND SIZING
        // gridCount: 4,
        // gridThumbnailSize: defaultAssetGridPreviewSize,
        // pageSize: defaultAssetsPerPage,
        // pathThumbnailSize: defaultPathThumbnailSize,
        // previewThumbnailSize: ThumbnailSize.square(50),
        // shouldRevertGrid: false,
        //
        // /// THEME
        // pickerTheme: ThemeData.dark(),
        // textDelegate: const AssetPickerTextDelegate(),
        // themeColor: Colorz.bloodTest,
        //
        // /// SCROLLING
        // keepScrollOffset: false,
        // specialItemPosition: SpecialItemPosition.none,
        //
        // /// PERMISSION
        // limitedPermissionOverlayPredicate: (PermissionState permissionState){
        //   blog('pickMultipleImages : permissionState : $permissionState');
        //   return true;
        // },
        //
        // /// LOADING
        // loadingIndicatorBuilder: (BuildContext context, bool loading){
        //   return Loading(loading: loading);
        // },
        //
        // /// ASSET NAME
        // pathNameBuilder: (AssetPathEntity assetPathEntity){
        //   blog('assetPathEntity : $assetPathEntity');
        //   return 'Fuck you';
        // },
        // sortPathDelegate: SortPathDelegate.common,
        //
        // /// WHO THE FUCK ARE YOU
        // selectPredicate: (BuildContext xxx, AssetEntity assetEntity, bool wtf) async {
        //   blog('pickMultipleImages : ${assetEntity.id} : wtf : $wtf');
        //   return wtf;
        // },
        // specialItemBuilder: (BuildContext xyz, AssetPathEntity assetPathEntity, int number){
        //   return Container();
        // },
        // specialPickerType: SpecialPickerType.wechatMoment,
        //
        // filterOptions: FilterOptionGroup(
        //   audioOption: const FilterOption(
        //     durationConstraint: DurationConstraint(
        //       allowNullable: false,
        //       max: const Duration(days: 1),
        //       min: Duration.zero,
        //     ),
        //     needTitle: true,
        //     sizeConstraint: SizeConstraint(
        //       maxHeight: 100000,
        //       minHeight: 0,
        //       ignoreSize: true,
        //       maxWidth: 100000,
        //       minWidth: 0,
        //     ),
        //   ),
        //   containsEmptyAlbum: true,
        //   containsLivePhotos: true,
        //   containsPathModified: true,
        //   createTimeCond: DateTimeCond(
        //     ignore: true,
        //     min: DateTime.now(),
        //     max: DateTime.now(),
        //   ),
        //   imageOption: FilterOption(
        //     sizeConstraint: SizeConstraint(
        //       maxHeight: 100000,
        //       minHeight: 0,
        //       ignoreSize: true,
        //       maxWidth: 100000,
        //       minWidth: 0,
        //     ),
        //     needTitle: true,
        //     durationConstraint: DurationConstraint(
        //       allowNullable: false,
        //       max: const Duration(days: 1),
        //       min: Duration.zero,
        //     ),
        //   ),
        //   onlyLivePhotos: false,
        //   orders: <OrderOption>[
        //     OrderOption(
        //       asc: false,
        //       type: OrderOptionType.createDate,
        //     ),
        //   ],
        //     updateTimeCond: DateTimeCond(
        //     ignore: true,
        //     min: 0,
        //     max: ,
        //   ),
        //   videoOption: FilterOption(
        //     sizeConstraint: SizeConstraint(
        //       maxHeight: 100000,
        //       minHeight: 0,
        //       ignoreSize: true,
        //       maxWidth: 100000,
        //       minWidth: 0,
        //     ),
        //   ),
        // ),

      ),
    );

    final List<File> _output = <File>[];

    if (Mapper.checkCanLoopList(pickedAssets) == true){

      for (final AssetEntity asset in pickedAssets){
        final File _file = await asset.file;
        _output.add(_file);
      }

    }

    return _output;
  }

  static Future<File> takeCameraImage({
  @required BuildContext context,
}) async {

    final AssetEntity entity = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: const CameraPickerConfig(

        // cameraQuarterTurns: 0,
        // enableAudio: true,
        // enableExposureControlOnPoint: true,
        // enablePinchToZoom: true,
        // enablePullToZoomInRecord: true,
        // enableScaledPreview: true,
        // enableSetExposure: true,
        // enableRecording: false,
        // enableTapRecording: false,
        // shouldAutoPreviewVideo: false,
        // onlyEnableRecording: false,
        // shouldDeletePreviewFile: false,
        // imageFormatGroup: ImageFormatGroup.unknown,
        // lockCaptureOrientation: DeviceOrientation.portraitUp,
        // maximumRecordingDuration: const Duration(seconds: 15),
        // preferredLensDirection: CameraLensDirection.back,
        // resolutionPreset: ResolutionPreset.max,
        // textDelegate: CameraPickerTextDelegate(),
        // theme: ThemeData.dark(),

        // onError: (Object object, StackTrace trace){
        //   blog('onError : $object : trace : $trace');
        // },
        //
        // foregroundBuilder: (BuildContext ctx, CameraController cameraController){
        //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController?.cameraId}');
        //   return Container();
        // },
        //
        // onEntitySaving: (BuildContext xxx, CameraPickerViewType cameraPickerViewType, File file) async {
        //   blog('onEntitySaving : cameraPickerViewType : ${cameraPickerViewType.name} : file : ${file.path}');
        // },
        //
        // onXFileCaptured: (XFile xFile, CameraPickerViewType cameraPickerViewType){
        //   blog('onXFileCaptured : cameraPickerViewType : ${cameraPickerViewType.name} : xFile : ${xFile.path}');
        //   return true;
        // },
        //
        // previewTransformBuilder: (BuildContext xyz, CameraController cameraController, Widget widget){
        //   blog('onXFileCaptured : cameraController.cameraId : ${cameraController.cameraId}');
        //   return Container();
        // },

      ),
    );

    final File _file = await entity?.file;

    return _file;
  }
// -----------------------------------------------------------------

  /// OLD - IMAGE PICKER

// ---------------------------------------
/*
Future<File> takeGalleryPicture({
  @required PicType picType,
}) async {

  final ImagePicker _picker = ImagePicker();
  File _result;

  final XFile _imageFile = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  if (_imageFile != null) {
    _result = createFileFromXFile(_imageFile);
  }

  return _result;
}
 */
// ---------------------------------------
/*
Future<File> takeCameraPicture({
  @required PicType picType,
}) async {

  final ImagePicker _picker = ImagePicker();

  final XFile _imageFile = await _picker.pickImage(
    source: ImageSource.camera,
    imageQuality: concludeImageQuality(picType),
    maxWidth: concludeImageMaxWidth(picType),
    // maxHeight: concludeImageMaxHeight(picType)
  );

  return _imageFile != null ?
  createFileFromXFile(_imageFile)
      :
  null;

}
 */
// ---------------------------------------
/*
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
      maxImages: Standards.getMaxSlidesCount(bzAccountType: accountType),
      enableCamera: true,
      selectedAssets: images ?? <Asset>[],
      cupertinoOptions: const CupertinoOptions(
        takePhotoIcon: 'Take photo',
        doneButtonTitle: 'Done',
      ),
      materialOptions: const MaterialOptions(
        actionBarColor: '#13244b',
        actionBarTitle: 'Select Images',//superPhrase(context, 'phid_choose'),
        allViewTitle: 'All Photos',
        useDetailsView: false,
        selectCircleStrokeColor: '#ffc000',
        startInAllView: true,
        textOnNothingSelected: 'Nothing is Fucking Selected',
        statusBarColor: '#000000', // the app status bar
        lightStatusBar: false,
        // actionBarTitleColor: "#13244b", // page title color, White is Default
        autoCloseOnSelectionLimit: false,
        selectionLimitReachedText: "Can't add more Images !",
        // unknown impact
        // backButtonDrawable: 'wtf is this backButtonDrawable',
        // okButtonDrawable: 'dunno okButtonDrawable',
      ),
    );
  }

  on Exception catch (e) {
    _error = e.toString();

    if (_error != 'The user has cancelled the selection') {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'Error',
        body: _error,
      );
    }
  }

  /// If the widget was removed from the tree while the asynchronous platform
  /// message was in flight, we want to discard the reply rather than calling
  /// setState to update our non-existent appearance.
  if (!mounted) {
    return null;
  }

  else {
    return _resultList;
  }

}
 */
// -----------------------------------------------------------------

  /// IMAGE MODIFIERS

// ---------------------------------------
/*
Future<File> cropImage({
  @required BuildContext context,
  @required File file,
}) async {

  /// flyer ratio is : (1 x 1.74)
  const double _flyerHeightRatio = Ratioz.xxflyerZoneHeight; // 1.74
  const double _maxWidth = 1000;

  final CroppedFile _croppedFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    aspectRatio: const CropAspectRatio(
        ratioX: 1,
        ratioY: Ratioz.xxflyerZoneHeight,
    ),
    aspectRatioPresets: Platform.isAndroid ?
    getAndroidCropAspectRatioPresets()
        :
    getIOSCropAspectRatioPresets(),
    maxWidth: _maxWidth.toInt(),
    compressFormat: ImageCompressFormat.jpg,

    /// TASK : need to test png vs jpg storage sizes on firebase
    compressQuality: 100, // max
    cropStyle: CropStyle.rectangle,
    maxHeight: (_maxWidth * _flyerHeightRatio).toInt(),
    uiSettings: <PlatformUiSettings>[

      AndroidUiSettings(
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,

        statusBarColor: Colorz.black255,
        backgroundColor: Colorz.black230,
        dimmedLayerColor: Colorz.black200,

        toolbarTitle:
        'Crop Image', //'Crop flyer Aspect Ratio 1:${Ratioz.xxflyerZoneHeight}',
        toolbarColor: Colorz.black255,
        toolbarWidgetColor:
        Colorz.white255, // color of : cancel, title, confirm widgets

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

    ],

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

  if (_croppedFile == null) {
    return null;
  } else {
    return File(_croppedFile.path);
  }
}
 */
// -----------------------------------------------------------------

  /// FILE CREATORS

// ---------------------------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */
// ---------------------------------------
  ///
  static Future<File> createNewEmptyFile({
    @required String fileName,
    bool useTemporaryDirectory = false,
  }) async {

    final String _filePath = await _createNewFilePath(
      fileName: fileName,
      useTemporaryDirectory: useTemporaryDirectory,
    );

    final File _file = File(_filePath);

    return _file;
  }
// -----------------------------------------------------------------

  /// FILE PATH

// ---------------------------------------
  ///
  static Future<String> _createNewFilePath({
    @required String fileName,
    bool useTemporaryDirectory = false,
  }) async {

    final Directory _appDocDir = useTemporaryDirectory ?
    await getTemporaryDirectory()
        :
    await getApplicationDocumentsDirectory();

    final String _appDocPath = _appDocDir.path;
    final String _filePath = '$_appDocPath/$fileName';
    return _filePath;
  }
// ---------------------------------------
  ///
  static String getFileNameFromFile(File file){
    final String _path = file.path;
    final String _fileName = TextMod.removeTextBeforeLastSpecialCharacter(_path, '/');
    return _fileName;
  }
// -----------------------------------------------------------------
  /// TAMAM
  static Future<File> getFileFromLocalRasterAsset({
    @required BuildContext context,
    @required String localAsset,
    int width = 100,
  }) async {

    File _file;
    final String _asset = ObjectChecker.objectIsSVG(localAsset) ? Iconz.bldrsAppIcon : localAsset;

    await tryAndCatch(
        context: context,
        methodName: 'getFileFromLocalRasterAsset',
        functions: () async {
          // blog('0. removing [assets/] from input image path');
          final String _pathTrimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
            string: _asset,
            numberOfCharacters: 7,
          );
          // blog('1. starting getting image from assets');
          // final ByteData _byteData = await rootBundle.load('assets/$_pathTrimmed');
          // blog('2. we got byteData and creating the File aho');
          final String _fileName = TextMod.getFileNameFromAsset(_pathTrimmed);
          // final File _tempFile = await getEmptyFile(_fileNae);
          // blog('3. we created the FILE and will overwrite image data as bytes');
          // final File _finalFile = await writeBytesOnFile(file: _tempFile, byteData: _byteData);
          // _tempFile.delete(recursive: true);
          //
          // _file = _finalFile;
          //
          // blog('4. file is ${_file.path}');

          final Uint8List _uInt = await getUint8ListFromLocalRasterAsset(asset: _asset, width: width);

          _file = await getFileFromUint8List(uInt8List: _uInt, fileName: _fileName);
        });

    return _file;
  }
// ---------------------------------------
  static Future<File> getFileFromUint8List({
    @required Uint8List uInt8List,
    @required String fileName,
  }) async {

    final File _file = await createNewEmptyFile(
      fileName: fileName,
    );

    final File _result = await writeUint8ListOnFile(
      uint8list: uInt8List,
      file: _file,
    );

    return _result;
  }
// ---------------------------------------
  static Future<File> getFileFromURL(String imageUrl) async {
    /// generate random number.
    final Random _rng = Random();

    /// get temporary directory of device.
    final Directory _tempDir = await getTemporaryDirectory();

    /// get temporary path from temporary directory.
    final String _tempPath = _tempDir.path;

    /// create a new file in temporary path with random file name.
    final File _file = File('$_tempPath${(_rng.nextInt(100)).toString()}.png');

    /// call http.get method and pass imageUrl into it to get response.
    final Uri _imageUri = Uri.parse(imageUrl);
    final http.Response _response = await http.get(_imageUri);

    /// write bodyBytes received in response to file.
    await _file.writeAsBytes(_response.bodyBytes);

    /// now return the file which is created with random name in
    /// temporary directory and image bytes from response is written to // that file.
    return _file;
  }
// ---------------------------------------
/*
Future<File> getFileFromPickerAsset(Asset asset) async {
  final ByteData _byteData = await asset.getThumbByteData(
      asset.originalWidth, asset.originalHeight
  );

  final String _name = TextMod.removeTextAfterLastSpecialCharacter(asset.name, '.');

  blog('== asset name is : ${asset.runtimeType}');

  final File _tempFile = File('${(await getTemporaryDirectory()).path}/$_name');
  await _tempFile.writeAsBytes(_byteData.buffer.asUint8List(_byteData.offsetInBytes, _byteData.lengthInBytes));
  await _tempFile.create(recursive: true);

  final File _file = _tempFile;

  return _file;
}
 */
// ---------------------------------------
/*
Future<List<File>> getFilesFromPickerAssets(List<Asset> assets) async {
  final List<File> _files = <File>[];

  if (Mapper.checkCanLoopList(assets)) {
    for (final Asset asset in assets) {
      final File _file = await getFileFromPickerAsset(asset);
      _files.add(_file);
    }
  }

  return _files;
}
 */
// ---------------------------------------
  static Future<File> getFileFromDynamic(dynamic pic) async {
    File _file;

    if (pic != null) {
      if (ObjectChecker.objectIsFile(pic) == true) {
        _file = pic;
      }
      // else if (ObjectChecker.objectIsAsset(pic) == true) {
      //   _file = await getFileFromPickerAsset(pic);
      // }
      else if (ObjectChecker.objectIsURL(pic) == true) {
        _file = await getFileFromURL(pic);
      }
      else if (ObjectChecker.objectIsJPGorPNG(pic) == true) {
        // _file = await getFile
      }
    }

    return _file;
  }
// ---------------------------------------
  static Future<File> getFilerFromBase64(String base64) async {
    final Uint8List _fileAgainAsInt = base64Decode(base64);
    // await null;

    final File _fileAgain = await getFileFromUint8List(
      uInt8List: _fileAgainAsInt,
      fileName: '${Numeric.createUniqueID()}',
    );

    return _fileAgain;
  }
// -----------------------------------------------------------------

  /// FILE WRITING

// ---------------------------------------
  static Future<File> writeUint8ListOnFile({
    @required File file,
    @required Uint8List uint8list,
  }) async {
    await file.writeAsBytes(uint8list);
    await file.create(recursive: true);
    return file;
  }

// ---------------------------------------
  static Future<File> writeBytesOnFile({
    @required File file,
    @required ByteData byteData,
  }) async {
    File _file;

    if (file != null && byteData != null) {
      final Uint8List _uInts = getUint8ListFromByteData(byteData);
      _file = await writeUint8ListOnFile(file: file, uint8list: _uInts);
    }

    return _file;
  }
// -----------------------------------------------------------------

  /// ASSET

// ---------------------------------------
/*
Future<Asset> getPickerAssetFromURL(String url) async {
  final File _file = await getFileFromURL(url);

  final ImageSize imageSize = await ImageSize.superImageSize(_file);
  //
  //
  final Asset _asset = Asset(
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
  //   // blog('====================================================================================== asset name is : ${asset.runtimeType}');
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
 */
// ---------------------------------------
/*
Asset getOnlyAssetFromDynamic(dynamic input) {
  Asset _asset;
  if (ObjectChecker.objectIsAsset(input) == true) {
    _asset = input;
  }

  return _asset;
}
 */
// ---------------------------------------
/*
List<Asset> getOnlyAssetsFromDynamics(List<dynamic> inputs) {
  final List<Asset> _assets = <Asset>[];

  if (Mapper.checkCanLoopList(inputs)) {
    for (final dynamic x in inputs) {
      _assets.add(getOnlyAssetFromDynamic(x));
    }
  }

  return _assets;
}
 */
// ---------------------------------------
/*
Future<void> blogAsset({
  @required Asset asset,
  bool blogDeviceData = true,
  bool blogGPSData = true,
  bool blogExifData = true,
}) async {

  final Metadata _metadata = await asset.metadata;

  final DeviceMetadata _deviceMetadata = _metadata.device;
  final GpsMetadata _gpsMetadata = _metadata.gps;
  final ExifMetadata _exifMetaData = _metadata.exif;

  blog('BLOGGING ASSET ------------------------------------------------------- START');
  blog('asset ID : ${asset.identifier}');
  blog('asset name : ${asset.name}');
  blog('asset is Landscape : ${asset.isLandscape}');
  blog('asset width : ${asset.originalWidth}');
  blog('asset height : ${asset.originalHeight}');

  if (blogDeviceData == true){
    blog('DEVICE META DATA ------------------------------------------------');
    blog('body serial number : ${_deviceMetadata.bodySerialNumber}');
    blog('camera owner name : ${_deviceMetadata.cameraOwnerName}');
    blog('lens make : ${_deviceMetadata.lensMake}');
    blog('lens model : ${_deviceMetadata.lensModel}');
    blog('lens serial number : ${_deviceMetadata.lensSerialNumber}');
    blog('lens specifications : ${_deviceMetadata.lensSpecification}');
    blog('make : ${_deviceMetadata.make}');
    blog('maker note : ${_deviceMetadata.makerNote}');
    blog('model : ${_deviceMetadata.model}');
    blog('software : ${_deviceMetadata.software}');
  }

  if (blogGPSData == true){
    blog('GPS META DATA ------------------------------------------------');
    blog('gpsVersionID : ${_gpsMetadata.gpsVersionID}');
    blog('gpsLatitudeRef : ${_gpsMetadata.gpsLatitudeRef}');
    blog('gpsLatitude : ${_gpsMetadata.gpsLatitude}');
    blog('gpsLongitudeRef : ${_gpsMetadata.gpsLongitudeRef}');
    blog('gpsLongitude : ${_gpsMetadata.gpsLongitude}');
    blog('gpsAltitudeRef : ${_gpsMetadata.gpsAltitudeRef}');
    blog('gpsAltitude : ${_gpsMetadata.gpsAltitude}');
    blog('gpsTimeStamp : ${_gpsMetadata.gpsTimeStamp}');
    blog('gpsSatellites : ${_gpsMetadata.gpsSatellites}');
    blog('gpsStatus : ${_gpsMetadata.gpsStatus}');
    blog('gpsMeasureMode : ${_gpsMetadata.gpsMeasureMode}');
    blog('gpsDOP : ${_gpsMetadata.gpsDOP}');
    blog('gpsSpeedRef : ${_gpsMetadata.gpsSpeedRef}');
    blog('gpsSpeed : ${_gpsMetadata.gpsSpeed}');
    blog('gpsTrackRef : ${_gpsMetadata.gpsTrackRef}');
    blog('gpsTrack : ${_gpsMetadata.gpsTrack}');
    blog('gpsImgDirectionRef : ${_gpsMetadata.gpsImgDirectionRef}');
    blog('gpsImgDirection : ${_gpsMetadata.gpsImgDirection}');
    blog('gpsMapDatum : ${_gpsMetadata.gpsMapDatum}');
    blog('gpsDestLatitudeRef : ${_gpsMetadata.gpsDestLatitudeRef}');
    blog('gpsDestLatitude : ${_gpsMetadata.gpsDestLatitude}');
    blog('gpsDestLongitudeRef : ${_gpsMetadata.gpsDestLongitudeRef}');
    blog('gpsDestLongitude : ${_gpsMetadata.gpsDestLongitude}');
    blog('gpsDestBearingRef : ${_gpsMetadata.gpsDestBearingRef}');
    blog('gpsDestBearing : ${_gpsMetadata.gpsDestBearing}');
    blog('gpsDestDistanceRef : ${_gpsMetadata.gpsDestDistanceRef}');
    blog('gpsDestDistance : ${_gpsMetadata.gpsDestDistance}');
    blog('gpsProcessingMethod : ${_gpsMetadata.gpsProcessingMethod}');
    blog('gpsAreaInformation : ${_gpsMetadata.gpsAreaInformation}');
    blog('gpsDateStamp : ${_gpsMetadata.gpsDateStamp}');
    blog('gpsDifferential : ${_gpsMetadata.gpsDifferential}');
    blog('gpsHPositioningError : ${_gpsMetadata.gpsHPositioningError}');
    blog('interoperabilityIndex : ${_gpsMetadata.interoperabilityIndex}');
  }

  if (blogExifData == true){
    blog('GPS META DATA ------------------------------------------------');
    blog('imageWidth : ${_exifMetaData.imageWidth}');
    blog('imageLength : ${_exifMetaData.imageLength}');
    blog('bitsPerSample : ${_exifMetaData.bitsPerSample}');
    blog('compression : ${_exifMetaData.compression}');
    blog('photometricInterpretation : ${_exifMetaData.photometricInterpretation}');
    blog('orientation : ${_exifMetaData.orientation}');
    blog('samplesPerPixel : ${_exifMetaData.samplesPerPixel}');
    blog('planarConfiguration : ${_exifMetaData.planarConfiguration}');
    blog('ycbCrSubSampling : ${_exifMetaData.ycbCrSubSampling}');
    blog('ycbCrPositioning : ${_exifMetaData.ycbCrPositioning}');
    blog('xResolution : ${_exifMetaData.xResolution}');
    blog('yResolution : ${_exifMetaData.yResolution}');
    blog('resolutionUnit : ${_exifMetaData.resolutionUnit}');
    blog('stripOffsets : ${_exifMetaData.stripOffsets}');
    blog('rowsPerStrip : ${_exifMetaData.rowsPerStrip}');
    blog('stripByteCounts : ${_exifMetaData.stripByteCounts}');
    blog('jpegInterchangeFormat : ${_exifMetaData.jpegInterchangeFormat}');
    blog('jpegInterchangeFormatLength : ${_exifMetaData.jpegInterchangeFormatLength}');
    blog('transferFunction : ${_exifMetaData.transferFunction}');
    blog('whitePoint : ${_exifMetaData.whitePoint}');
    blog('primaryChromaticities : ${_exifMetaData.primaryChromaticities}');
    blog('ycbCrCoefficients : ${_exifMetaData.ycbCrCoefficients}');
    blog('referenceBlackWhite : ${_exifMetaData.referenceBlackWhite}');
    blog('dateTime : ${_exifMetaData.dateTime}');
    blog('imageDescription : ${_exifMetaData.imageDescription}');
    blog('artist : ${_exifMetaData.artist}');
    blog('copyright : ${_exifMetaData.copyright}');
    blog('exifVersion : ${_exifMetaData.exifVersion}');
    blog('flashpixVersion : ${_exifMetaData.flashpixVersion}');
    blog('colorSpace : ${_exifMetaData.colorSpace}');
    blog('gamma : ${_exifMetaData.gamma}');
    blog('pixelXDimension : ${_exifMetaData.pixelXDimension}');
    blog('pixelYDimension : ${_exifMetaData.pixelYDimension}');
    blog('componentsConfiguration : ${_exifMetaData.componentsConfiguration}');
    blog('compressedBitsPerPixel : ${_exifMetaData.compressedBitsPerPixel}');
    blog('userComment : ${_exifMetaData.userComment}');
    blog('relatedSoundFile : ${_exifMetaData.relatedSoundFile}');
    blog('dateTimeOriginal : ${_exifMetaData.dateTimeOriginal}');
    blog('dateTimeDigitized : ${_exifMetaData.dateTimeDigitized}');
    blog('subSecTime : ${_exifMetaData.subSecTime}');
    blog('subSecTimeOriginal : ${_exifMetaData.subSecTimeOriginal}');
    blog('subSecTimeDigitized : ${_exifMetaData.subSecTimeDigitized}');
    blog('exposureTime : ${_exifMetaData.exposureTime}');
    blog('fNumber : ${_exifMetaData.fNumber}');
    blog('exposureProgram : ${_exifMetaData.exposureProgram}');
    blog('spectralSensitivity : ${_exifMetaData.spectralSensitivity}');
    blog('photographicSensitivity : ${_exifMetaData.photographicSensitivity}');
    blog('oecf : ${_exifMetaData.oecf}');
    blog('sensitivityType : ${_exifMetaData.sensitivityType}');
    blog('standardOutputSensitivity : ${_exifMetaData.standardOutputSensitivity}');
    blog('recommendedExposureIndex : ${_exifMetaData.recommendedExposureIndex}');
    blog('isoSpeed : ${_exifMetaData.isoSpeed}');
    blog('isoSpeedLatitudeyyy : ${_exifMetaData.isoSpeedLatitudeyyy}');
    blog('isoSpeedLatitudezzz : ${_exifMetaData.isoSpeedLatitudezzz}');
    blog('shutterSpeedValue : ${_exifMetaData.shutterSpeedValue}');
    blog('apertureValue : ${_exifMetaData.apertureValue}');
    blog('brightnessValue : ${_exifMetaData.brightnessValue}');
    blog('exposureBiasValue : ${_exifMetaData.exposureBiasValue}');
    blog('maxApertureValue : ${_exifMetaData.maxApertureValue}');
    blog('subjectDistance : ${_exifMetaData.subjectDistance}');
    blog('meteringMode : ${_exifMetaData.meteringMode}');
    blog('lightSource : ${_exifMetaData.lightSource}');
    blog('flash : ${_exifMetaData.flash}');
    blog('subjectArea : ${_exifMetaData.subjectArea}');
    blog('focalLength : ${_exifMetaData.focalLength}');
    blog('flashEnergy : ${_exifMetaData.flashEnergy}');
    blog('spatialFrequencyResponse : ${_exifMetaData.spatialFrequencyResponse}');
    blog('focalPlaneXResolution : ${_exifMetaData.focalPlaneXResolution}');
    blog('focalPlaneYResolution : ${_exifMetaData.focalPlaneYResolution}');
    blog('focalPlaneResolutionUnit : ${_exifMetaData.focalPlaneResolutionUnit}');
    blog('subjectLocation : ${_exifMetaData.subjectLocation}');
    blog('exposureIndex : ${_exifMetaData.exposureIndex}');
    blog('sensingMethod : ${_exifMetaData.sensingMethod}');
    blog('fileSource : ${_exifMetaData.fileSource}');
    blog('sceneType : ${_exifMetaData.sceneType}');
    blog('cfaPattern : ${_exifMetaData.cfaPattern}');
    blog('customRendered : ${_exifMetaData.customRendered}');
    blog('exposureMode : ${_exifMetaData.exposureMode}');
    blog('whiteBalance : ${_exifMetaData.whiteBalance}');
    blog('digitalZoomRatio : ${_exifMetaData.digitalZoomRatio}');
    blog('focalLengthIn35mmFilm : ${_exifMetaData.focalLengthIn35mmFilm}');
    blog('sceneCaptureType : ${_exifMetaData.sceneCaptureType}');
    blog('gainControl : ${_exifMetaData.gainControl}');
    blog('contrast : ${_exifMetaData.contrast}');
    blog('saturation : ${_exifMetaData.saturation}');
    blog('sharpness : ${_exifMetaData.sharpness}');
    blog('deviceSettingDescription : ${_exifMetaData.deviceSettingDescription}');
    blog('subjectDistanceRange : ${_exifMetaData.subjectDistanceRange}');
    blog('imageUniqueID : ${_exifMetaData.imageUniqueID}');
  }

  blog('BLOGGING ASSET ------------------------------------------------------- END');
}
 */
// -----------------------------------------------------------------

  /// ui.Image

// ---------------------------------------
  static Future<ui.Image> getUiImageFromUint8List(Uint8List uInt) async {
    ui.Image _decodedImage;

    if (uInt != null) {
      _decodedImage = await decodeImageFromList(uInt);
    }

    return _decodedImage;
  }
// ---------------------------------------
  static Future<ui.Image> getUiImageFromIntList(List<int> img) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();

    ui.decodeImageFromList(img, completer.complete);

    return completer.future;
  }
// -----------------------------------------------------------------

  /// uInt8List

// ---------------------------------------
  static Uint8List getUint8ListFromByteData(ByteData byteData) {
    final Uint8List _uInts = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return _uInts;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> getUint8ListFromFile(File file) async {
    final Uint8List _uInt = await file.readAsBytes();
    return _uInt;
  }
// ---------------------------------------
  static Future<List<Uint8List>> getUint8ListsFromFiles(List<File> files) async {
    final List<Uint8List> _screenShots = <Uint8List>[];

    if (Mapper.checkCanLoopList(files)) {
      for (final File file in files) {
        final Uint8List _uInt = await getUint8ListFromFile(file);
        _screenShots.add(_uInt);
      }
    }

    return _screenShots;
  }
// ---------------------------------------
  /// TAMAM
  static Future<Uint8List> getUint8ListFromLocalRasterAsset({
    @required String asset,
    @required int width
  }) async {
    final ByteData _byteData = await rootBundle.load(asset);

    final ui.Codec _codec = await ui.instantiateImageCodec(
        _byteData.buffer.asUint8List(),
        targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _result =
    (await _fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
    return _result;
  }
// ---------------------------------------
  static Future<Uint8List> getUint8ListFromRasterURL(int width, int height, String urlAsset) async {
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final Canvas _canvas = Canvas(_pictureRecorder);
    final Paint _paint = Paint()..color = Colors.transparent;
    const Radius _radius = Radius.circular(20);

    _canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
          topLeft: _radius,
          topRight: _radius,
          bottomLeft: _radius,
          bottomRight: _radius,
        ),
        _paint);

    final ByteData _detail = await rootBundle.load(urlAsset);
    final ui.Image _imaged =
    await getUiImageFromIntList(Uint8List.view(_detail.buffer));

    _canvas.drawImage(_imaged, Offset.zero, Paint());

    final ui.Image _img =
    await _pictureRecorder.endRecording().toImage(width, height);
    final ByteData _data = await _img.toByteData(format: ui.ImageByteFormat.png);

    return _data.buffer.asUint8List();
  }
// -----------------------------------------------------------------

  /// Base64

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getBase64FromFileOrURL(dynamic image) async {
    File _file;

    final bool _isFile = ObjectChecker.objectIsFile(image);
    // bool _isString = ObjectChecker.objectIsString(image);

    if (_isFile == true) {
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
// -----------------------------------------------------------------

  /// BitmapDescriptor

// ---------------------------------------
  static Future<BitmapDescriptor> getBitmapFromSVG({
    @required BuildContext context,
    @required String assetName,
  }) async {
    // Read SVG file as String
    final String svgString =
    await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    final MediaQueryData queryData = MediaQuery.of(context);
    final double devicePixelRatio = queryData.devicePixelRatio;
    final double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    final double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    final ui.Picture picture =
    svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

// ---------------------------------------
  static Future<BitmapDescriptor> getBitmapFromPNG({
    String pngPic = Iconz.flyerPinPNG,
  }) async {
    final BitmapDescriptor _marker =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, pngPic);
    return _marker;
  }

  /// CropAspectRatioPreset

// ---------------------------------------
/*
List<CropAspectRatioPreset> getAndroidCropAspectRatioPresets() {
  const List<CropAspectRatioPreset> _androidRatios = <CropAspectRatioPreset>[
    CropAspectRatioPreset.square,
    CropAspectRatioPreset.ratio3x2,
    CropAspectRatioPreset.original,
    CropAspectRatioPreset.ratio4x3,
  ];
  return _androidRatios;
}
// ---------------------------------------
List<CropAspectRatioPreset> getIOSCropAspectRatioPresets() {
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
 */
// -----------------------------------------------------------------

  /// CHECKERS

// ---------------------------------------
  static bool slideBlurIsOn({
    @required dynamic pic,
    @required ImageSize imageSize,
    @required BoxFit boxFit,
    @required double flyerBoxWidth,
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

    if (imageSize == null ||
        imageSize.width == null ||
        imageSize.height == null ||
        imageSize.width <= 0 ||
        imageSize.height <= 0) {
      _imageSizeIsValid = false;
    } else {
      _imageSizeIsValid = true;
    }

    if (_imageSizeIsValid == true) {
      /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
      final int _originalImageWidth = imageSize.width.toInt();
      final int _originalImageHeight = imageSize.height.toInt();
      final double _originalImageRatio =
          _originalImageWidth / _originalImageHeight;

      /// slide aspect ratio : 1 / 1.74 ~= 0.575
      final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;
      const double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

      double _fittedImageWidth;
      double _fittedImageHeight;

      /// if fit width
      if (boxFit == BoxFit.fitWidth) {
        _fittedImageWidth = flyerBoxWidth;
        _fittedImageHeight = flyerBoxWidth / _originalImageRatio;
      }

      /// if fit height
      else {
        _fittedImageWidth = _flyerZoneHeight * _originalImageRatio;
        _fittedImageHeight = _flyerZoneHeight;
      }

      final double _fittedImageRatio = _fittedImageWidth / _fittedImageHeight;

      /// so
      /// if _originalImageRatio < 0.575 image is narrower than slide,
      /// if ratio > 0.575 image is wider than slide
      const double _errorPercentage = Ratioz
          .slideFitWidthLimit; // ~= max limit from flyer width => flyerBoxWidth * 90%
      const double _maxRatioForBlur = _slideRatio / (_errorPercentage / 100);
      const double _minRatioForBlur = _slideRatio * (_errorPercentage / 100);

      /// so if narrower more than 10% or wider more than 10%, blur should be active and boxFit shouldn't be cover
      if (_minRatioForBlur > _fittedImageRatio ||
          _fittedImageRatio > _maxRatioForBlur) {
        _blurIsOn = true;
      } else {
        _blurIsOn = false;
      }

      // File _file = pic;
      // blog('A - pic : ${_file?.fileNameWithExtension?.toString()}');
      // blog('B - ratio : $_fittedImageRatio = W:$_fittedImageWidth / H:$_fittedImageHeight');
      // blog('C - Fit : $boxFit');
      // blog('C - blur : $_blurIsOn');

    }

    return _blurIsOn;
  }
// ---------------------------------------
  static bool picturesURLsAreIdentical({
    @required List<String> urls1,
    @required List<String> urls2,
  }) {
    bool _areIdentical = true;

    if (urls1 == null && urls2 != null) {
      _areIdentical = false;
    }

    else if (urls1 != null && urls2 == null) {
      _areIdentical = false;
    }

    else if (urls1.length != urls2.length) {
      _areIdentical = false;
    }

    else {
      for (int i = 0; i < urls1.length; i++) {
        if (urls1[i] != urls2[i]) {
          _areIdentical = false;
          break;
        }
      }
    }

    return _areIdentical;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> localAssetExists(dynamic asset) async {
    bool _isFound = false;

    if (asset is String){
      if (TextChecker.stringIsNotEmpty(asset) == true){

        final ByteData _bytes = await rootBundle.load(asset).catchError((Object error){

          // blog('LocalAssetChecker : _checkAsset : error : ${error.toString()}');

          if (error == null){
            _isFound = true;
          }{
            _isFound = false;
          }

        },);

        _isFound = _bytes != null;

      }
    }

    return _isFound;
  }
// ---------------------------------------
  /// not tested
  static bool checkPicsAreIdentical({
    @required dynamic pic1,
    @required dynamic pic2,
  }){
    bool _identical = false;

    if (pic1 != null && pic2 != null){

      if (pic1.runtimeType == pic2.runtimeType){

        final bool _isURL = ObjectChecker.objectIsURL(pic1);
        final bool _isFile = ObjectChecker.objectIsFile(pic1);
        // final bool _isAsset = ObjectChecker.objectIsAsset(pic1);

        if (_isURL == true){
          final String _a = pic1;
          final String _b = pic2;
          _identical = _a == _b;
        }

        else if (_isFile == true){
          final File _a = pic1;
          final File _b = pic2;
          _identical = _a.path == _b.path; // TASK : NEED CONFIRMATION
        }

        // else if (_isAsset == true){
        //   final Asset _a = pic1;
        //   final Asset _b = pic2;
        //   _identical = _a.identifier == _b.identifier; // TASK : NEED CONFIRMATION
        // }

      }

    }

    return _identical;
  }
// -----------------------------------------------------------------

  /// IMAGE QUALITY

// ---------------------------------------
  static int concludeImageQuality(PicType picType) {
    switch (picType) {
      case PicType.userPic:
        return 100;
        break;
      case PicType.authorPic:
        return 100;
        break;
      case PicType.bzLogo:
        return 100;
        break;
      case PicType.slideHighRes:
        return 100;
        break;
      case PicType.slideLowRes:
        return 80;
        break;
      case PicType.dum:
        return 100;
        break;
      case PicType.askPic:
        return 100;
        break;
      case PicType.notiBanner:
        return 100;
        break;
      default:
        return 100;
    }
  }
// ---------------------------------------
  static double concludeImageMaxWidth(PicType picType) {
    switch (picType) {
      case PicType.userPic:
        return 150;
        break;
      case PicType.authorPic:
        return 150;
        break;
      case PicType.bzLogo:
        return 150;
        break;
      case PicType.slideHighRes:
        return 1000;
        break;
      case PicType.slideLowRes:
        return 150;
        break;
      case PicType.dum:
        return 150;
        break;
      case PicType.askPic:
        return 150;
        break;
      default:
        return 200;
    }
  }
// -----------------------------------------------------------------
}
