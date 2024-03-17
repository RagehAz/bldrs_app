import 'dart:io';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/bldrs_keys.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/mediator/models/dimension_model.dart';

class PicFullScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PicFullScreen({
    required this.image,
    required this.dimensions,
    required this.filter,
    this.title,
    super.key
  });
  // --------------------
  final dynamic image;
  final Dimensions? dimensions;
  final Verse? title;
  final ImageFilterModel? filter;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> openURL({
    required String? url,
    required String? title,
  }) async {

    await BldrsNav.goToNewScreen(
      screen: PicFullScreen(
        image: url,
        dimensions:
        const Dimensions(
          width: 0, //_pic?.meta?.width,
          height: 0, //_pic?.meta?.height,
        ),
        filter: ImageFilterModel.noFilter(),
        title: Verse.plain(title),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> openStealUrlTheOpen({
    required String? url,
    required String? title,
  }) async {

    final MediaModel? _pic = await PicProtocols.stealInternetPic(
      url: url,
      ownersIDs: [BldrsKeys.ragehID],
      picName: '$url',
      uploadPath: 'x',
    );

    await openPicModel(
      pic: _pic,
      title: title,
    );

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> openPicModel({
    required MediaModel? pic,
    required String? title,
  }) async {

    await BldrsNav.goToNewScreen(
      screen: PicFullScreen(
        image: pic?.file,
        dimensions: Dimensions(
          width: pic?.meta?.width,
          height: pic?.meta?.height,
        ),
        filter: ImageFilterModel.noFilter(),
        title: Verse.plain(title),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> openFile({
    required File? file,
    required String? title,
  }) async {

    final Dimensions? _dims = await DimensionsGetter.fromFile(
      file: file,
    );


    await BldrsNav.goToNewScreen(
      screen: PicFullScreen(
        image: file,
        dimensions: _dims,
        filter: ImageFilterModel.noFilter(),
        title: Verse.plain(title),
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByStoragePath({
    required String? path,
    required String? title,
  }) async {

    final MediaModel? _pic = await PicProtocols.fetchPic(path);

    await openPicModel(
      pic: _pic,
      title: title,
    );

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      title: title,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      // skyType: SkyType.black,
      pyramidType: PyramidType.white,
      appBarRowWidgets: const <Widget>[],
      child: Container(
        width: _screenWidth,
        height: _screenHeight,
        // color: Colorz.Yellow50,
        alignment: Alignment.center,
        child: ZoomableImage(
          // onTap: null,
          // canZoom: true,
          isFullScreen: true,
          autoShrink: false,
          child: BldrsImage(
            pic: image,
            fit: Dimensions.concludeBoxFit(
              viewWidth: _screenWidth,
              viewHeight: _screenHeight,
              picWidth: dimensions?.width ?? 0,
              picHeight: dimensions?.height ?? 0,
            ),
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            // filterModel: filter,
            // canUseFilter: false, // filter != null,
            // loading: false,
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
