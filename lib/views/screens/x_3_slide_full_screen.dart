import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
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

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Non,
      sky: Sky.Black,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget:
      Center(
        child: Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          alignment: Alignment.center,
          child: ZoomablePicture(
            onTap: null,
            isOn: true,
            isFullScreen: true,
            autoShrink: false,
            child: Imagers.superImageWidget(
              image,
              fit: BoxFit.fitWidth,
              width: Scale.superScreenWidth(context).toInt(),
              height: Scale.superScreenHeight(context).toInt(),
            ),
          ),
        ),
      ),
    );
  }
}




