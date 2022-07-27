import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/cropping_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropping/image_cropping.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image_editor/image_editor.dart';


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

  /// PICK IMAGE FROM GALLERY

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
// -----------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

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

  /// CROP IMAGE

// ---------------------------------------
  static Future<File> takeImageThenCropA({
    @required BuildContext context,
}) async {

    final File _file = await pickSingleImage(
      context: context,
    );

    File _output;

    if (_file != null){

      ImageCropping.cropImage(
        context: context,
        imageBytes: await _file.readAsBytes(),
        onImageDoneListener: (dynamic data) async {
          blog('data is : ${data.runtimeType} : $data');
          _output = await Filers.getFileFromUint8List(uInt8List: data, fileName: _file.fileNameWithExtension);
        },
        customAspectRatios: <CropAspectRatio>[],
        imageEdgeInsets: EdgeInsets.zero,
        isConstrain: false,
        makeDarkerOutside: false,
        onImageEndLoading: (){
          blog('ImageEndLoading');
        },
        onImageStartLoading: (){
          blog('ImageStartLoading');
        },
        rootNavigator: true,
        squareCircleSize: 0,
        selectedImageRatio: CropAspectRatio.free(),
        visibleOtherAspectRatios: true,
        squareBorderWidth: 2,
        squareCircleColor: Colorz.black255,
        defaultTextColor: Colorz.white255,
        selectedTextColor: Colorz.yellow255,
        colorForWhiteSpace: Colorz.black255,
      );

    }

    return _output;
}
// ---------------------------------------
  static Future<File> takeImageThenCropB({
    @required BuildContext context,
  }) async {

    final File _file = await pickSingleImage(
      context: context,
    );

    File _output;

    if (_file != null){

      final editorOption = ImageEditorOption();
      editorOption.addOption(const FlipOption());
      // editorOption.addOption(ClipOption(width: null, height: null));
      editorOption.addOption(const RotateOption(0));
      // editorOption.addOption(); // and other option.

      editorOption.outputFormat = const OutputFormat.png(88);

      final Uint8List _uInt8List = await ImageEditor.editImage(
        image: await Floaters.getUint8ListFromFile(_file),
        imageEditorOption: editorOption,
      );

      _output = await Filers.getFileFromUint8List(
          uInt8List: _uInt8List,
          fileName: _file.fileNameWithExtension,
      );

    }

    return _output;
  }
// ---------------------------------------
  static Future<List<File>> takeImagesThenCropAll({
    @required BuildContext context,
  }) async {

    final List<File> _files = await pickMultipleImages(
      context: context,
      maxAssets: 5,
    );

    List<File> _output;

    if (Mapper.checkCanLoopList(_files) == true){

      _output = await Nav.goToNewScreen(
          context: context,
          screen: CroppingScreen(
            files: _files,
            filesName: 'bob',
          ),
      );

    }

    return _output;
  }
// ---------------------------------------
/*
Future<File> cropImageByImageCropper({
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

        toolbarTitle: 'Crop Image', //'Crop flyer Aspect Ratio 1:${Ratioz.xxflyerZoneHeight}',
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
