
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

import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
/// => TAMAM
class BldrsPicMaker {
  // --------------------------------------------------------------------------

  const BldrsPicMaker();

  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> pickAndCropSinglePic({
    @required BuildContext context,
    @required bool cropAfterPick,
    @required double aspectRatio,
    double resizeToWidth,
    AssetEntity selectedAsset,
  }) async {

    final Uint8List _bytes = await PicMaker.pickAndCropSinglePic(
      context: context,
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      resizeToWidth: resizeToWidth,
      selectedAsset: selectedAsset,
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      confirmText: Verse.transBake(context, 'phid_crop'),
    );

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> pickAndCropMultiplePics({
    @required BuildContext context,
    @required double aspectRatio,
    @required bool cropAfterPick,
    double resizeToWidth,
    int maxAssets = 10,
    List<AssetEntity> selectedAssets,
  }) async {

    final List<Uint8List> _bytes = await PicMaker.pickAndCropMultiplePics(
      context: context,
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      resizeToWidth: resizeToWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      confirmText: Verse.transBake(context, 'phid_crop'),
    );

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> cropPic({
    @required BuildContext context,
    @required Uint8List bytes,
    @required double aspectRatio,
  }) async {

    final Uint8List _bytes = await PicMaker.cropPic(
      context: context,
      bytes: bytes,
      confirmText: Verse.transBake(context, 'phid_crop'),
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      aspectRatio: aspectRatio,
    );

    return _bytes;
  }
  // -----------------------------------------------------------------------------
}
