import 'dart:typed_data';

import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

// // -----------------------------------------------------------------------------
// /*
// /// GIF THING
// // check this
// // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// // https://pub.dev/packages/file_picker
// // Container(
// //   width: 200,
// //   height: 200,
// //   margin: EdgeInsets.all(30),
// //   color: Colorz.BloodTest,
// //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// // ),
//  */

/// => TAMAM
class BldrsPicMaker {
  // --------------------------------------------------------------------------

  const BldrsPicMaker();

  // -----------------------------------------------------------------------------

  /// MAKERS

  // --------------------
  ///
  static Future<PicModel?> makePic({
    required PicMakerType picMakerType,
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressionQuality,
    required double finalWidth,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    PicModel? _output;
    Uint8List? _bytes;

    if(picMakerType == PicMakerType.galleryImage){
      _bytes = await _pickAndCropSinglePic(
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        finalWidth: finalWidth,
        compressionQuality: compressionQuality,
        onlyCompress: Standards.onlyCompressOnResizing,
        // selectedAsset:
      );
    }

    else if (picMakerType == PicMakerType.cameraImage){
      _bytes = await _shootAndCropCameraPic(
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        finalWidth: finalWidth,
        compressionQuality: compressionQuality,
        onlyCompress: Standards.onlyCompressOnResizing,
      );
    }

    if (_bytes != null){

      _output = await PicModel.combinePicModel(
        ownersIDs: ownersIDs,
        name: name,
        bytes: _bytes,
        compressionQuality: compressionQuality,
        picMakerType: picMakerType,
        assignPath: assignPath,
      );

    }

    return _output;
  }
  // --------------------
  ///
  static Future<List<PicModel>> makePics({
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressionQuality,
    required double finalWidth,
    required String Function(int index) assignPath,
    required List<String> ownersIDs,
    required String groupName,
    required int maxAssets,
  }) async {

    final List<PicModel> _output = [];

    final List<Uint8List> _bytezz = await _pickAndCropMultiplePics(
      aspectRatio: aspectRatio,
      cropAfterPick: cropAfterPick,
      finalWidth: finalWidth,
      compressionQuality: compressionQuality,
      onlyCompress: Standards.onlyCompressOnResizing,
      maxAssets: maxAssets,
      // selectedAssets:
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){

      for (int i = 0; i < _bytezz.length; i++){

        final Uint8List bytes = _bytezz[i];

        final PicModel? _picModel = await PicModel.combinePicModel(
          ownersIDs: ownersIDs,
          name: '${groupName}_$i',
          bytes: bytes,
          compressionQuality: compressionQuality,
          picMakerType: PicMakerType.galleryImage,
          assignPath: assignPath(i),
        );

        if (_picModel != null){
          _output.add(_picModel);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PICKERS - SHOOTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _pickAndCropSinglePic({
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressionQuality,
    required bool onlyCompress,
    double? finalWidth,
    AssetEntity? selectedAsset,
  }) async {

    final Uint8List? _bytes = await PicMaker.pickAndCropSinglePic(
      context: getMainContext(),
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      finalWidth: finalWidth,
      selectedAsset: selectedAsset,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      confirmText: Verse.transBake('phid_continue')!,
      onlyCompress: onlyCompress,
      compressionQuality: compressionQuality,
    );

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> _pickAndCropMultiplePics({
    required double aspectRatio,
    required bool cropAfterPick,
    required int compressionQuality,
    required bool onlyCompress,
    double? finalWidth,
    int maxAssets = 10,
    List<AssetEntity>? selectedAssets,
  }) async {

    final List<Uint8List> _bytes = await PicMaker.pickAndCropMultiplePics(
      context: getMainContext(),
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      finalWidth: finalWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      confirmText: Verse.transBake('phid_continue')!,
      selectedAssets: selectedAssets,
      maxAssets: maxAssets,
      compressionQuality: compressionQuality,
      onlyCompress: onlyCompress,
    );

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> _shootAndCropCameraPic({
    required double aspectRatio,
    required bool cropAfterPick,
    required int compressionQuality,
    required bool onlyCompress,
    required double finalWidth,
  }) async {

    final Uint8List? _bytes = await PicMaker.shootAndCropCameraPic(
      context: getMainContext(),
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      finalWidth: finalWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      onlyCompress: onlyCompress,
      compressionQuality: compressionQuality,
      confirmText: Verse.transBake('phid_continue')!,
    );

    return _bytes;
  }
  // -----------------------------------------------------------------------------

  /// CROPPERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> cropPic({
    required Uint8List? bytes,
    required double aspectRatio,
  }) async {

    final Uint8List? _bytes = await PicMaker.cropPic(
      context: getMainContext(),
      bytes: bytes,
      confirmText: Verse.transBake('phid_continue')!,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      aspectRatio: aspectRatio,
    );

    return _bytes;
  }
  // -----------------------------------------------------------------------------
}
