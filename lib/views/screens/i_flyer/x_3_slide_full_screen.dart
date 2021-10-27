import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SlideFullScreen extends StatelessWidget {
  final dynamic image;
  final ImageSize imageSize;

  SlideFullScreen({
    @required this.image,
    @required this.imageSize,
  });

  @override
  Widget build(BuildContext context) {

    print('Building full screen with width : ${imageSize.width} : height : ${imageSize.height} ');

    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Non,
      sky: Sky.Black,
      appBarRowWidgets: <Widget>[

      ],
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
            child: Imagers.superImageWidget(
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




