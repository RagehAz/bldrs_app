import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/z_components/images/cc_zoomable_pic.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:super_image/super_image.dart';
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
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    // --------------------
    return MainLayout(
      title: title,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.black,
      pyramidType: PyramidType.white,
      appBarRowWidgets: const <Widget>[],
      child: Container(
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
            fit: Dimensions.concludeBoxFit(
              viewWidth: _screenWidth,
              viewHeight: _screenHeight,
              picWidth: imageSize.width,
              picHeight: imageSize.height,
            ),
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
