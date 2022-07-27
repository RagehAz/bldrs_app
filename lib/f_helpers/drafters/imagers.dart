import 'dart:async';
import 'dart:io';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
// -----------------------------------------------------------------

  Imagers();

// -----------------------------------------------------------------

  /// PHONE GALLERY

// ---------------------------------------
  static Future<File> pickSingleImage({
    @required BuildContext context,
    AssetEntity selectAsset,
  }) async {

    File _file;

    final List<AssetEntity> _assets = selectAsset == null ?
    <AssetEntity>[]
        :
    <AssetEntity>[selectAsset];

    final List<File> _files = await pickMultipleImages(
      context: context,
      maxAssets: 1,
      selectedAssets: _assets,
    );

    if (Mapper.checkCanLoopList(_files) == true){
      _file = _files.first;
    }

    return _file;
  }
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
// ---------------------------------------
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

// -----------------------------------------------------------------

  /// FILE WRITING


  /// ASSET


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
      case PicType.userPic:return 100;break;
      case PicType.authorPic:return 100;break;
      case PicType.bzLogo:return 100;break;
      case PicType.slideHighRes:return 100;break;
      case PicType.slideLowRes:return 80;break;
      case PicType.dum:return 100;break;
      case PicType.askPic:return 100;break;
      case PicType.notiBanner:return 100;break;
      default:return 100;
    }
  }
// ---------------------------------------
  static double concludeImageMaxWidth(PicType picType) {
    switch (picType) {
      case PicType.userPic:return 150;break;
      case PicType.authorPic:return 150;break;
      case PicType.bzLogo:return 150;break;
      case PicType.slideHighRes:return 1000;break;
      case PicType.slideLowRes:return 150;break;
      case PicType.dum:return 150;break;
      case PicType.askPic:return 150;break;
      default:return 200;
    }
  }
// -----------------------------------------------------------------
}
