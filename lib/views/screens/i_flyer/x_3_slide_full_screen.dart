import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/general/images/super_image.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class SlideFullScreen extends StatelessWidget {
  final dynamic image;
  final ImageSize imageSize;

  const SlideFullScreen({
    @required this.image,
    @required this.imageSize,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('Building full screen with width : ${imageSize.width} : height : ${imageSize.height} ');

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Non,
      skyType: SkyType.Black,
      appBarRowWidgets: const <Widget>[],
      layoutWidget:

        Container(
          width: _screenWidth,
          height: _screenHeight,
          // color: Colorz.Yellow50,
          alignment: Alignment.center,
          child: ZoomablePicture(
            onTap: null,
            isOn: true,
            isFullScreen: true,
            autoShrink: false,
            child: SuperImage(
              image,
              fit: Imagers.concludeBoxFit(
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




