import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/c_slides/zoomable_pic.dart';
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
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic image;
  final ImageSize imageSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    return MainLayout(
      pageTitleVerse: const Verse(
        text: 'phid_flyerSlides',
        translate: true,
      ),
      pyramidsAreOn: true,
      appBarType: AppBarType.non,
      skyType: SkyType.black,
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
            boxFit: ImageSize.concludeBoxFit(
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
