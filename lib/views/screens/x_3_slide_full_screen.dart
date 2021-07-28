import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_parts/zoomable_pic.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class SlideFullScreen extends StatelessWidget {
  final dynamic image;

  SlideFullScreen({
    @required this.image,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('Building full screen with : ${image.toString()} --------------------------------- ');

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);

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
              fit: BoxFit.cover,
              width: Scale.superScreenWidth(context).toInt(),
              height: Scale.superScreenHeight(context).toInt(),
            ),
          ),
        ),

    );
  }
}




