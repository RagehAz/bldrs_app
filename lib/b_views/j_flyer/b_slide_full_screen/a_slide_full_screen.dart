import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/single_slide/cc_zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/artworks/pyramids.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class SlideFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideFullScreen({
    @required this.image,
    @required this.imageSize,
    this.title,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic image;
  final Dimensions imageSize;
  final Verse title;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    return MainLayout(
      pageTitleVerse: title,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.white,
      appBarRowWidgets: const <Widget>[],
      layoutWidget: Container(
        width: _screenWidth,
        height: _screenHeight,
        // color: Colorz.Yellow50,
        alignment: Alignment.center,
        child: ZoomablePicture(
          // onTap: null,
          isOn: true,
          isFullScreen: true,
          autoShrink: false,
          child: SuperImage(
            pic: image,
            boxFit: Dimensions.concludeBoxFit(
              viewWidth: _screenWidth,
              viewHeight: _screenHeight,
              picWidth: imageSize.width,
              picHeight: imageSize.height,
            ),
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context),
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
