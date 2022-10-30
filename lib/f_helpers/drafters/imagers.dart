import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/b_views/z_components/cropper/cropping_screen.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  // -----------------------------------------------------------------------------

  const Imagers();

  // -----------------------------------------------------------------------------

  /// PICK IMAGE FROM GALLERY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> pickAndCropSingleImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required double aspectRatio,
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
      aspectRatio: aspectRatio,
      resizeToWidth: resizeToWidth,
    );

    if (Mapper.checkCanLoopList(_fileModels) == true){
      _fileModel = _fileModels.first;
    }

    return _fileModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> pickAndCropMultipleImages({
    @required BuildContext context,
    @required double aspectRatio,
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
        aspectRatio: aspectRatio,

      );
    }

    /// RESIZE
    if (resizeToWidth != null && Mapper.checkCanLoopList(_fileModels) == true){
      _fileModels = await resizeImages(
        inputFileModels: _fileModels,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    return _fileModels;
  }
  // --------------------
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
        //   return const SizedBox();;
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
          size: Filers.getFileSizeInMb(_file),
          fileName: Filers.getFileNameFromFile(file: _file, withExtension: false),
          file: _file,
          // url: null,
        );

        _output.add(_fileModel);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> shootAndCropCameraImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required double aspectRatio,
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
          aspectRatio: aspectRatio,
        );
      }

      /// RESIZE
      if (resizeToWidth != null){
        _outputFiles = await resizeImages(
          inputFileModels: _outputFiles,
          resizeToWidth: resizeToWidth,
        );
      }

      /// ASSIGN THE FILE
      if (Mapper.checkCanLoopList(_outputFiles) == true){
        _output = _outputFiles.first;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> _shootCameraImage({
    @required BuildContext context,
  }) async {

    final AssetEntity entity = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: const CameraPickerConfig(

        /// TURNS - ORIENTATION
        // cameraQuarterTurns: 0, // DEFAULT
        // lockCaptureOrientation: DeviceOrientation.portraitUp, // DEFAULT

        /// AUDIO
        // enableAudio: true, // DEFAULT

        /// EXPOSURE
        // enableExposureControlOnPoint: true, // DEFAULT
        // enableSetExposure: true, // DEFAULT

        /// ZOOMING
        // enablePinchToZoom: true, // DEFAULT
        // enablePullToZoomInRecord: true, // DEFAULT

        /// PREVIEW
        // enableScaledPreview: true, // DEFAULT
        // shouldAutoPreviewVideo: false, // DEFAULT
        // shouldDeletePreviewFile: false, // DEFAULT

        /// VIDEO
        // enableRecording: false, // DEFAULT
        // enableTapRecording: false, // DEFAULT
        // onlyEnableRecording: false, // DEFAULT
        // maximumRecordingDuration: const Duration(seconds: 15), // DEFAULT

        /// FORMAT
        // imageFormatGroup: ImageFormatGroup.unknown, // DEFAULT
        // resolutionPreset: ResolutionPreset.max, // DEFAULT

        /// CAMERA
        // preferredLensDirection: CameraLensDirection.back, // DEFAULT

        /// THEME - TEXTS
        textDelegate: EnglishCameraPickerTextDelegate(), /// TASK : DO ARABIC CAMERA PICKER TEXT DELEGATE
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

    return FileModel(
      size: Filers.getFileSizeInMb(_file),
      fileName: Filers.getFileNameFromFile(file: _file, withExtension: false),
      file: _file,
      // url: null,
    );
  }
  // -----------------------------------------------------------------------------

  /// CROP IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> cropImage({
    @required BuildContext context,
    @required FileModel pickedFile,
    @required double aspectRatio,
  }) async {

    FileModel _fileModel;

    final List<FileModel> _fileModels = await cropImages(
      context: context,
      pickedFileModels: <FileModel>[pickedFile],
      aspectRatio: aspectRatio,
    );

    if (Mapper.checkCanLoopList(_fileModels) == true){
      _fileModel = _fileModels.first;
    }

    return _fileModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> cropImages({
    @required BuildContext context,
    @required List<FileModel> pickedFileModels,
    @required double aspectRatio,
  }) async {

    List<FileModel> _fileModels = <FileModel>[];

    if (Mapper.checkCanLoopList(pickedFileModels) == true){

      _fileModels = await Nav.goToNewScreen(
        context: context,
        screen: CroppingScreen(
          fileModels: pickedFileModels,
          aspectRatio: aspectRatio,
        ),
      );

    }

    return _fileModels;
  }
  // -----------------------------------------------------------------------------

  /// RESIZE IMAGE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FileModel>> resizeImages({
    @required List<FileModel> inputFileModels,
    @required double resizeToWidth,
    // @required bool isFlyerRatio,
  }) async {

    List<FileModel> _fileModels = <FileModel>[];

    if (Mapper.checkCanLoopList(inputFileModels) == true){

      final List<File> _files = await Filers.resizeImages(
        files: FileModel.getFilesFromModels(inputFileModels),
        // aspectRatio: isFlyerRatio == true ? FlyerDim.flyerAspectRatio : 1,
        finalWidth: resizeToWidth,
      );

      if (Mapper.checkCanLoopList(_files) == true){
        _fileModels = FileModel.createModelsByNewFiles(_files);
      }

    }

    return _fileModels;
  }
  // --------------------
  ///
  static Future<FileModel> resizeImage({
    @required FileModel fileModel,
    @required double resizeToWidth,
  }) async {
    FileModel _output;

    if (fileModel != null){

      final List<FileModel> _resized = await resizeImages(
          inputFileModels: <FileModel>[fileModel],
          resizeToWidth: resizeToWidth
      );

      _output = _resized.first;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicsAreIdentical({
    @required dynamic pic1,
    @required dynamic pic2,
  }){
    bool _identical = false;

    if (pic1 == null && pic2 == null){
      _identical = true;
    }
    else if (pic1 != null && pic2 != null){

      if (pic1.runtimeType == pic2.runtimeType){

        if (pic1 is String){
          _identical = pic1 == pic2;
        }
        else if (ObjectCheck.objectIsFile(pic1) == true){
          _identical = Filers.checkFilesAreIdentical(file1: pic1, file2: pic2);
        }
        else if (pic1 is FileModel){
          _identical = FileModel.checkFileModelsAreIdentical(model1: pic1, model2: pic2);
        }

      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPicIsEmpty(dynamic pic){
    bool _isEmpty = true;

    if (pic != null){

      if (ObjectCheck.isAbsoluteURL(pic) == true){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      else if (pic is File){
        final File _file = pic;
        _isEmpty = TextCheck.isEmpty(_file.path);
      }

      else if (pic is FileModel){
        _isEmpty = FileModel.checkModelIsEmpty(pic);
      }
      else if (pic is String){
        _isEmpty = TextCheck.isEmpty(pic);
      }
      else if (ObjectCheck.objectIsUint8List(pic) == true){
        final Uint8List _uInts = pic;
        _isEmpty = _uInts.isEmpty;
      }

    }

    return _isEmpty;
  }
  // -----------------------------------------------------------------------------

  /// IMAGE QUALITY

  // --------------------
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
  // --------------------
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
  // -----------------------------------------------------------------------------

  /// CIPHER

  // --------------------
  ///
  static String cipherPic({
    @required dynamic pic,
    @required bool toJSON,
  }){
    String _output;

    if (pic != null){

      /// TO JSON
      if (toJSON == true){

        /// PIC IS URL
        if (ObjectCheck.isAbsoluteURL(pic) == true){
          _output = pic;
        }
        /// PIC IS FILE MODEL
        else if (pic is FileModel){
          final FileModel fileModel = pic;
          _output = fileModel?.file?.path ?? fileModel?.url;
        }
        else if (ObjectCheck.objectIsFile(pic) == true){
          final File _file = pic;
          _output = _file.path;
        }

      }

      /// TO FIRE STORE
      else {

      }

    }

    return _output;
  }
  // --------------------
  /*
  static dynamic decipherPic({
    @required String pic,
    @required bool fromJSON,
  }){

  }
   */
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogPictureInfo(PictureInfo info){
    blog('blogPictureInfo : START');

    blog('x---');
    blog('info.size.height                   : ${info.size.height}');
    blog('info.size.width                    : ${info.size.width}');
    blog('info.size.aspectRatio              : ${info.size.aspectRatio}');
    blog('info.size.longestSide              : ${info.size.longestSide}');
    blog('info.size.shortestSide             : ${info.size.shortestSide}');
    blog('x---');
    blog('info.picture.approximateBytesUsed  : ${info.picture.approximateBytesUsed}');
    blog('x---');
    blog('info.size.isEmpty                  : ${info.size.isEmpty}');
    blog('info.size.isFinite                 : ${info.size.isFinite}');
    blog('info.size.isInfinite               : ${info.size.isInfinite}');
    blog('x---');
    blog('info.viewport.left                 : ${info.viewport.left}');
    blog('info.viewport.bottom               : ${info.viewport.bottom}');
    blog('info.viewport.right                : ${info.viewport.right}');
    blog('info.viewport.top                  : ${info.viewport.top}');
    blog('x---');
    blog('info.viewport.bottomLeft           : ${info.viewport.bottomLeft}');
    blog('info.viewport.bottomCenter         : ${info.viewport.bottomCenter}');
    blog('info.viewport.bottomRight          : ${info.viewport.bottomRight}');
    blog('info.viewport.centerLeft           : ${info.viewport.centerLeft}');
    blog('info.viewport.center               : ${info.viewport.center}');
    blog('info.viewport.centerRight          : ${info.viewport.centerRight}');
    blog('info.viewport.topLeft              : ${info.viewport.topLeft}');
    blog('info.viewport.topCenter            : ${info.viewport.topCenter}');
    blog('info.viewport.topRight             : ${info.viewport.topRight}');
    blog('x---');

    // info.size.flipped.
    blog('blogPictureInfo : END');
  }
  // -----------------------------------------------------------------------------
}
