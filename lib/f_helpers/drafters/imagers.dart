import 'dart:async';
import 'dart:io';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/b_views/z_components/cropper/cropping_screen.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';


enum ImagePickerType {
  cameraImage,
  galleryImage,
}

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

  const Imagers();

// -----------------------------------------------------------------

  /// PICK IMAGE FROM GALLERY

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> pickAndCropSingleImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required bool isFlyerRatio,
    double resizeToWidth,
    AssetEntity selectedAsset,
  }) async {

    FileModel _fileModel;

    final List<AssetEntity> _assets = selectedAsset == null ?
    <AssetEntity>[]
        :
    <AssetEntity>[selectedAsset];

    final List<FileModel> _fileModels = await pickAndCropMultipleImages(
      context: context,
      maxAssets: 1,
      selectedAssets: _assets,
      cropAfterPick: cropAfterPick,
      isFlyerRatio: isFlyerRatio,
      resizeToWidth: resizeToWidth,
    );

    if (Mapper.checkCanLoopList(_fileModels) == true){
      _fileModel = _fileModels.first;
    }

    return _fileModel;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> pickAndCropMultipleImages({
    @required BuildContext context,
    @required bool isFlyerRatio,
    @required bool cropAfterPick,
    double resizeToWidth,
    int maxAssets = 10,
    List<AssetEntity> selectedAssets,
  }) async {

    /// PICK
    List<FileModel> _fileModels = await _pickMultipleImages(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
    );

    /// CROP
    if (cropAfterPick == true && Mapper.checkCanLoopList(_fileModels) == true){
      _fileModels = await cropImages(
        context: context,
        pickedFileModels: _fileModels,
        isFlyerRatio: isFlyerRatio,
      );
    }

    /// RESIZE
    if (resizeToWidth != null && Mapper.checkCanLoopList(_fileModels) == true){
      _fileModels = await resizeImages(
          inputFileModels: _fileModels,
          resizeToWidth: resizeToWidth,
          isFlyerRatio: isFlyerRatio,
      );
    }

    return _fileModels;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> _pickMultipleImages({
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

    final List<FileModel> _output = <FileModel>[];

    if (Mapper.checkCanLoopList(pickedAssets) == true){

      for (final AssetEntity asset in pickedAssets){

        final File _file = await asset.file;

        final FileModel _fileModel = FileModel(
          size: Filers.getFileSize(_file),
          fileName: Filers.getFileNameFromFile(file: _file, withExtension: false),
          file: _file,
          url: null,
        );

        _output.add(_fileModel);
      }

    }

    return _output;
  }
// -----------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> shootAndCropCameraImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required bool isFlyerRatio,
    double resizeToWidth,
  }) async {

    FileModel _output;

    /// SHOOT
    final FileModel _fileModel = await _shootCameraImage(
      context: context,
    );

    /// CROP - RESIZE
    if (_fileModel != null){

      List<FileModel> _outputFiles = <FileModel>[_fileModel];

      /// CROP
      if (cropAfterPick == true){
        _outputFiles = await cropImages(
          context: context,
          pickedFileModels: _outputFiles,
          isFlyerRatio: isFlyerRatio,
        );
      }

      /// RESIZE
      if (resizeToWidth != null){
        _outputFiles = await resizeImages(
          inputFileModels: _outputFiles,
          resizeToWidth: resizeToWidth,
          isFlyerRatio: isFlyerRatio,
        );
      }

      /// ASSIGN THE FILE
      if (Mapper.checkCanLoopList(_outputFiles) == true){
        _output = _outputFiles.first;
      }

    }

    return _output;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> _shootCameraImage({
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

    final FileModel _fileModel = FileModel(
      size: Filers.getFileSize(_file),
      fileName: Filers.getFileNameFromFile(file: _file, withExtension: false),
      file: _file,
      url: null,
    );

    return _fileModel;
  }
// -----------------------------------------------------------------

  /// CROP IMAGE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> cropImage({
    @required BuildContext context,
    @required FileModel pickedFile,
    @required bool isFlyerRatio,
}) async {

    FileModel _fileModel;

    final List<FileModel> _fileModels = await cropImages(
      context: context,
      pickedFileModels: <FileModel>[pickedFile],
      isFlyerRatio: isFlyerRatio,
    );

    if (Mapper.checkCanLoopList(_fileModels) == true){
      _fileModel = _fileModels.first;
    }

    return _fileModel;
}
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> cropImages({
    @required BuildContext context,
    @required List<FileModel> pickedFileModels,
    @required bool isFlyerRatio,
  }) async {

    List<FileModel> _fileModels = <FileModel>[];

    if (Mapper.checkCanLoopList(pickedFileModels) == true){

      _fileModels = await Nav.goToNewScreen(
        context: context,
        screen: CroppingScreen(
          fileModels: pickedFileModels,
          aspectRatio: isFlyerRatio == true ? 1 / Ratioz.xxflyerZoneHeight : 1,
        ),
      );

    }

    return _fileModels;
  }
// -----------------------------------------------------------------

  /// RESIZE IMAGE

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> resizeImages({
    @required List<FileModel> inputFileModels,
    @required double resizeToWidth,
    @required bool isFlyerRatio,
  }) async {

    List<FileModel> _fileModels = <FileModel>[];

    if (Mapper.checkCanLoopList(inputFileModels) == true){

      final List<File> _files = await Filers.resizeImages(
        files: FileModel.getFilesFromModels(inputFileModels),
        aspectRatio: isFlyerRatio == true ? 1 / Ratioz.xxflyerZoneHeight : 1,
        finalWidth: resizeToWidth,
      );

      if (Mapper.checkCanLoopList(_files) == true){
        _fileModels = FileModel.createModelsByNewFiles(_files);
      }

    }

    return _fileModels;
  }
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
// -------------------------------------
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
// -----------------------------------------------------------------

  /// IMAGE QUALITY

// ---------------------------------------
  /*
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
   */
// -----------------------------------------------------------------
}
