import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/zoomable_pic.dart';
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

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.PyramidzYellow,
      appBarType: AppBarType.Non,
      sky: Sky.Black,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget:
      GestureDetector(
        onTap: () => Nav.goBack(context),
        child: Center(
          child: Container(
            width: Scale.superScreenWidth(context),
            height: Scale.superScreenHeight(context),
            alignment: Alignment.center,
            child: ZoomablePicture(
              child: Imagers.superImageWidget(
                image,
                fit: BoxFit.fitWidth,
                width: Scale.superScreenWidth(context).toInt(),
                height: Scale.superScreenHeight(context).toInt(),
              ),
              isOn: true,
            ),
          ),
        ),
      ),
    );
  }
}




