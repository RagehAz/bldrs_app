import 'package:bldrs/z_components/images/bldrs_image.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:flutter/material.dart';
import 'package:basics/components/super_image/super_image.dart';
import 'package:basics/mediator/models/dimension_model.dart';

class SlideFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideFullScreen({
    required this.image,
    required this.imageSize,
    required this.filter,
    this.title,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic image;
  final Dimensions imageSize;
  final Verse? title;
  final ImageFilterModel? filter;
  /// --------------------------------------------------------------------------
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
              picWidth: imageSize.width ?? 0,
              picHeight: imageSize.height ?? 0,
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
