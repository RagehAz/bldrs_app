import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/c_slides/zoomable_pic.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    blog('Building full screen with width : ${imageSize.width} : height : ${imageSize.height} ');

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    return MainLayout(
      pageTitle: 'Create flyers',
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
            boxFit: Imagers.concludeBoxFit(
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
  }
}
