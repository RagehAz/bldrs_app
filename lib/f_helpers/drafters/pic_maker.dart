import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/z_components/cropper/cropping_screen.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// -----------------------------------------------------------------------------
/*
/// GIF THING
// check this
// https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// https://pub.dev/packages/file_picker
// Container(
//   width: 200,
//   height: 200,
//   margin: EdgeInsets.all(30),
//   color: Colorz.BloodTest,
//   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// ),
 */
// -----------------------------------------------------------------------------

enum PicMakerType {
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

class PicMaker {
  // -----------------------------------------------------------------------------

  const PicMaker();

  // -----------------------------------------------------------------------------

  /// PICK IMAGE FROM GALLERY

  // --------------------
  ///
  static Future<Uint8List> pickAndCropSinglePic({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required double aspectRatio,
    double resizeToWidth,
    AssetEntity selectedAsset,
  }) async {

    Uint8List _bytes;

    final List<AssetEntity> _assets = selectedAsset == null ?
    <AssetEntity>[]
        :
    <AssetEntity>[selectedAsset];

    final List<Uint8List> _bytezz = await pickAndCropMultiplePics(
      context: context,
      maxAssets: 1,
      selectedAssets: _assets,
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      resizeToWidth: resizeToWidth,
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){
      _bytes = _bytezz.first;
    }

    return _bytes;
  }
  // --------------------
  ///
  static Future<List<Uint8List>> pickAndCropMultiplePics({
    @required BuildContext context,
    @required double aspectRatio,
    @required bool cropAfterPick,
    double resizeToWidth,
    int maxAssets = 10,
    List<AssetEntity> selectedAssets,
  }) async {

    /// PICK
    List<Uint8List> _bytezz = await _pickMultiplePics(
      context: context,
      maxAssets: maxAssets,
      selectedAssets: selectedAssets,
    );

    /// CROP
    if (cropAfterPick == true && Mapper.checkCanLoopList(_bytezz) == true){
      _bytezz = await cropPics(
        context: context,
        bytezz: _bytezz,
        aspectRatio: aspectRatio,

      );
    }

    /// RESIZE
    if (resizeToWidth != null && Mapper.checkCanLoopList(_bytezz) == true){
      _bytezz = await resizePics(
        bytezz: _bytezz,
        resizeToWidth: resizeToWidth,
        // isFlyerRatio: isFlyerRatio,
      );
    }

    return _bytezz;
  }
  // --------------------
  ///
  static Future<List<Uint8List>> _pickMultiplePics({
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

    final List<Uint8List> _output = <Uint8List>[];

    if (Mapper.checkCanLoopList(pickedAssets) == true){

      for (final AssetEntity asset in pickedAssets){

        final Uint8List _bytes = await Floaters.getUint8ListFromFile(await asset.file);

        _output.add(_bytes);
      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// TAKE IMAGE FROM CAMERA

  // --------------------
  ///
  static Future<Uint8List> shootAndCropCameraPic({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required double aspectRatio,
    double resizeToWidth,
  }) async {

    Uint8List _output;

    /// SHOOT
    final Uint8List _bytes = await _shootCameraPic(
      context: context,
    );

    /// CROP - RESIZE
    if (_bytes != null){

      List<Uint8List> _bytezz = <Uint8List>[_bytes];

      /// CROP
      if (cropAfterPick == true){
        _bytezz = await cropPics(
          context: context,
          bytezz: _bytezz,
          aspectRatio: aspectRatio,
        );
      }

      /// RESIZE
      if (resizeToWidth != null){
        _bytezz = await resizePics(
          bytezz: _bytezz,
          resizeToWidth: resizeToWidth,
        );
      }

      /// ASSIGN THE FILE
      if (Mapper.checkCanLoopList(_bytezz) == true){
        _output = _bytezz.first;
      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<Uint8List> _shootCameraPic({
    @required BuildContext context,
  }) async {

    final AssetEntity entity = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: CameraPickerConfig(

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
        textDelegate: Localizer.appIsArabic(context) == true ?
        const ArabicCameraPickerTextDelegate()
        :
        const EnglishCameraPickerTextDelegate(),

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

    if (entity == null){
      return null;
    }
    else {
      final File _file = await entity?.file;
      final Uint8List _bytes = await Floaters.getUint8ListFromFile(_file);
      return _bytes;
    }

  }
  // -----------------------------------------------------------------------------

  /// CROP IMAGE

  // --------------------
  ///
  static Future<Uint8List> cropPic({
    @required BuildContext context,
    @required Uint8List bytes,
    @required double aspectRatio,
  }) async {
    Uint8List _bytes;

    final List<Uint8List> _bytezz = await cropPics(
      context: context,
      bytezz: <Uint8List>[bytes],
      aspectRatio: aspectRatio,
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){
      _bytes = _bytezz.first;
    }

    return _bytes;
  }
  // --------------------
  ///
  static Future<List<Uint8List>> cropPics({
    @required BuildContext context,
    @required List<Uint8List> bytezz,
    @required double aspectRatio,
  }) async {

    List<Uint8List> _bytezz = <Uint8List>[];

    if (Mapper.checkCanLoopList(bytezz) == true){

      _bytezz = await Nav.goToNewScreen(
        context: context,
        screen: CroppingScreen(
          bytezz: bytezz,
          aspectRatio: aspectRatio,
        ),
      );

    }

    return _bytezz;
  }
  // -----------------------------------------------------------------------------

  /// RESIZE

  // --------------------
  ///
  static Future<Uint8List> resizePic({
    @required Uint8List bytes,
    /// image width will be resized to this final width
    @required double finalWidth,
  }) async {

    blog('resizeImage : START');

    Uint8List _output = bytes;

    if (bytes != null){

      img.Image _imgImage = await Floaters.getImgImageFromUint8List(bytes);

      /// only resize if final width is smaller than original
      if (finalWidth < _imgImage.width){

        final double _aspectRatio = await Dimensions.getPicAspectRatio(bytes);

        _imgImage = Floaters.resizeImgImage(
          imgImage: _imgImage,
          width: finalWidth.floor(),
          height: Dimensions.getHeightByAspectRatio(
              aspectRatio: _aspectRatio,
              width: finalWidth
          ).floor(),
        );

        _output = Floaters.getUint8ListFromImgImage(_imgImage);
      }

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<Uint8List>> resizePics({
    @required List<Uint8List> bytezz,
    @required double resizeToWidth,
  }) async {
    final List<Uint8List> _output = <Uint8List>[];

    if (Mapper.checkCanLoopList(bytezz) == true){

      for (final Uint8List bytes in bytezz){

        final Uint8List _resized = await resizePic(
          bytes: bytes,
          finalWidth: resizeToWidth,
        );

        _output.add(_resized);

      }

    }

    return _output;

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

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

      /// FILE
      else if (pic is File){
        final File _file = pic;
        _isEmpty = TextCheck.isEmpty(_file.path);
      }

      /// STRING
      else if (pic is String){
        _isEmpty = TextCheck.isEmpty(pic);
      }

      /// BYTES
      else if (ObjectCheck.objectIsUint8List(pic) == true){
        final Uint8List _uInts = pic;
        _isEmpty = _uInts.isEmpty;
      }

      else if (pic is PicModel){
        final PicModel picModel = pic;
        _isEmpty = Mapper.checkCanLoopList(picModel.bytes) == false;
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

/// Text delegate implements with Arabic.
class ArabicCameraPickerTextDelegate extends CameraPickerTextDelegate {
  const ArabicCameraPickerTextDelegate();

  @override
  String get languageCode => 'ar';

  @override
  String get confirm => 'تأكيد';

  @override
  String get shootingTips => 'اضغط للتصوير';

  @override
  String get shootingWithRecordingTips =>
      'اضغط لتصوير صورة، و اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingOnlyRecordingTips => 'اضغط طويلا لتسجيل فيديو';

  @override
  String get shootingTapRecordingTips => 'اضغط لتسجيل فيديو';

  @override
  String get loadFailed => 'فشلت عميلة التحميل';

  @override
  String get loading => 'جاري التحميل ...';

  @override
  String get saving => 'جاري الحفظ ...';

  @override
  String get sActionManuallyFocusHint => 'تعديل البؤرة يدويا';

  @override
  String get sActionPreviewHint => 'عرض';

  @override
  String get sActionRecordHint => 'تسجيل';

  @override
  String get sActionShootHint => 'صور صورة';

  @override
  String get sActionShootingButtonTooltip => 'زر التصوير';

  @override
  String get sActionStopRecordingHint => 'إيقاف التسجيل';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value){
    if (value == CameraLensDirection.back){
      return 'الكاميرا الخلفية';
    }
    else if (value == CameraLensDirection.front){
      return 'الكاميرا الأمامية';
    }
    else {
      return 'الكاميرا';
    }
  }

  @override
  String sCameraPreviewLabel(CameraLensDirection value) {
    if (value == null) {
      return null;
    }
    if (sCameraLensDirectionLabel(value) == CameraLensDirection.front.name){
      return 'عرض الكاميرا الأمامية';
    }
    else if (sCameraLensDirectionLabel(value) == CameraLensDirection.back.name){
      return 'عرض الكاميرا الخلفية';
    }
    else {
      return 'عرض الكاميرا';
    }

  }

  @override
  String sFlashModeLabel(FlashMode mode){

    if (mode == FlashMode.always){
      return 'فلاش مستمر';
    }
    else if (mode == FlashMode.auto){
      return 'فلاش أوتوماتيكي';
    }
    else if (mode == FlashMode.off){
      return 'بدون فلاش';
    }
    else if (mode == FlashMode.torch){
      return 'فلاش متقطع';
    }
    else {
      return 'فلاش';
    }
  }

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value){

    if (value == CameraLensDirection.back){
      return 'التحويل للكاميرا الخلفية';
    }
    else if (value == CameraLensDirection.front){
      return 'التحويل للكاميرا الأمامية';
    }
    else {
      return 'تحويل الكاميرا';
    }

  }

}
