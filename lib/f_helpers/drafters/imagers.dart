import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/b_views/z_components/cropper/cropping_screen.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'package:image/image.dart' as img;

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
  static Future<File> pickAndCropSingleImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required bool isFlyerRatio,
    double resizeToWidth,
    AssetEntity selectAsset,
  }) async {

    File _file;

    final List<AssetEntity> _assets = selectAsset == null ?
    <AssetEntity>[]
        :
    <AssetEntity>[selectAsset];

    final List<File> _files = await pickAndCropMultipleImages(
      context: context,
      maxAssets: 1,
      selectedAssets: _assets,
      cropAfterPick: cropAfterPick,
      isFlyerRatio: isFlyerRatio,
      resizeToWidth: resizeToWidth,
    );

    if (Mapper.checkCanLoopList(_files) == true){
      _file = _files.first;
    }

    return _file;
  }
// ---------------------------------------
  static Future<List<File>> pickAndCropMultipleImages({
    @required BuildContext context,
    @required bool isFlyerRatio,
    @required bool cropAfterPick,
    double resizeToWidth,
    int maxAssets = 10,
    List<AssetEntity> selectedAssets,
  }) async {

    List<File> _files = await _pickMultipleImages(
      context: context,
      maxAssets: maxAssets,
      cropAfterPick: cropAfterPick,
      selectedAssets: selectedAssets,
    );

    if (cropAfterPick == true && Mapper.checkCanLoopList(_files) == true){
      _files = await cropImages(
        context: context,
        pickedFiles: _files,
        isFlyerRatio: isFlyerRatio,
        resizeToWidth: resizeToWidth,
      );
    }

    return _files;
  }
// ---------------------------------------
  static Future<List<File>> _pickMultipleImages({
    @required BuildContext context,
    @required int maxAssets,
    @required bool cropAfterPick,
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
  static Future<File> shootAndCropCameraImage({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required bool isFlyerRatio,
    double resizeToWidth,
  }) async {

    File _file = await _shootCameraImage(
      context: context,
    );

    if (cropAfterPick == true && _file != null){

      final List<File> _files = await cropImages(
        context: context,
        pickedFiles: <File>[_file],
        isFlyerRatio: isFlyerRatio,
        resizeToWidth: resizeToWidth,
      );

      if (Mapper.checkCanLoopList(_files) == true){
        _file = _files.first;
      }

    }

    return _file;
  }
// -----------------------------------------------------------------
  static Future<File> _shootCameraImage({
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
  static Future<File> cropImage({
    @required BuildContext context,
    @required File pickedFile,
    @required bool isFlyerRatio,
    double resizeToWidth,
}) async {

    File _file;

    final List<File> _files = await cropImages(
      context: context,
      pickedFiles: <File>[pickedFile],
      isFlyerRatio: isFlyerRatio,
      resizeToWidth: resizeToWidth,
    );

    if (Mapper.checkCanLoopList(_files) == true){
      _file = _files.first;
    }

    return _file;
}
// ---------------------------------------
  static Future<List<File>> cropImages({
    @required BuildContext context,
    @required List<File> pickedFiles,
    @required bool isFlyerRatio,
    double resizeToWidth,
  }) async {

    List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(pickedFiles) == true){

      _files = await Nav.goToNewScreen(
        context: context,
        screen: CroppingScreen(
          files: pickedFiles,
          filesName: 'bob',
          aspectRatio: isFlyerRatio == true ? 1 / Ratioz.xxflyerZoneHeight : 1,
        ),
      );

    }

    if (Mapper.checkCanLoopList(_files) == true){
      _files = await resizeImages(
        files: _files,
        aspectRatio: isFlyerRatio == true ? 1 / Ratioz.xxflyerZoneHeight : 1,
        finalWidth: resizeToWidth,
      );
    }

    return _files;
  }
// -----------------------------------------------------------------

  /// CROP IMAGE

// ---------------------------------------
  static Future<File> resizeImage({
    @required File file,
    /// image width will be resized to this final width
    @required double finalWidth,
    @required double aspectRatio,
  }) async {

    File _output;

    if (file != null){

      final Uint8List uint = await Floaters.getUint8ListFromFile(file);
      final img.Image _image = img.decodeImage(uint);

      final img.Image _resized = img.copyResize(
        _image,
        width: finalWidth.floor(),
        height: (aspectRatio * finalWidth.floor()).floor(),
        interpolation: img.Interpolation.average,
      );

      /// ENCONDED IMAGE
      final Uint8List _asJpegEncoded = img.encodeJpg(_resized, quality: 80);

      _output = await Filers.transformUint8ListToFile(
        uInt8List: _asJpegEncoded,
        fileName: Filers.getFileNameFromFile(file: file),
      );

    }

    return _output;
  }
// ---------------------------------------
  static Future<List<File>> resizeImages({
    @required List<File> files,
    @required double aspectRatio,
    @required double finalWidth,
  }) async {
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(files) == true){

      await Future.wait(<Future>[

        ...List.generate(files.length, (index) async {

          final File _file = await resizeImage(
            file: files[index],
            aspectRatio: aspectRatio,
            finalWidth: finalWidth ?? 500,
          );

          if (_file != null){
            _files.add(_file);
          }

        }),

      ]);

    }

    return _files;

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
