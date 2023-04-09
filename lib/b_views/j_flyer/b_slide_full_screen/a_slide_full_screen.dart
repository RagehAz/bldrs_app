import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:mediators/mediators.dart';
import 'package:bldrs/b_views/z_components/pyramids/pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:scale/scale.dart';
import 'package:flutter/material.dart';
import 'package:super_image/super_image.dart';

class SlideFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlideFullScreen({
    @required this.image,
    @required this.imageSize,
    @required this.filter,
    this.title,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic image;
  final Dimensions imageSize;
  final Verse title;
  final ImageFilterModel filter;
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
        child: ZoomableImage(
          // onTap: null,
          // canZoom: true,
          isFullScreen: true,
          autoShrink: false,
          child: SuperFilteredImage(
            pic: image,
            boxFit: Dimensions.concludeBoxFit(
              viewWidth: _screenWidth,
              viewHeight: _screenHeight,
              picWidth: imageSize.width,
              picHeight: imageSize.height,
            ),
            width: Scale.screenWidth(context),
            height: Scale.screenHeight(context),
            filterModel: filter,
            canUseFilter: false, // filter != null,
          ),
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
