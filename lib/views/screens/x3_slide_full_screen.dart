import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/zoomable_widget.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';


class ImageFullScreen extends StatelessWidget {
  final dynamic image;

  ImageFullScreen({
    @required this.image,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      pageTitle: 'Create flyers',
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Non,
      appBarRowWidgets: <Widget>[

      ],
      layoutWidget:
      Center(
        child: Container(
          width: Scale.superScreenWidth(context),
          height: Scale.superScreenHeight(context),
          child: ZoomableWidget(
              child: superImageWidget(image)
          ),
        ),
      ),
    );
  }
}


class DraftPictureScreen extends StatefulWidget {
  final List<dynamic> pictures;
  final int index;

  DraftPictureScreen({
    @required this.pictures,
    @required this.index,
  });

  @override
  _DraftPictureScreenState createState() => _DraftPictureScreenState();
}

class _DraftPictureScreenState extends State<DraftPictureScreen> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('draft picture screen');

    double _flyerSizeFactor = 1;
    double _flyerZoneWidth = Scale.superFlyerZoneWidth(context, _flyerSizeFactor);
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerZoneWidth);

    return MainLayout(
      pyramids: Iconz.DvBlankSVG,
      appBarType: AppBarType.Non,
      layoutWidget: PageView.builder(
          pageSnapping: true,
          controller: _pageController,
          itemCount: widget.pictures.length,
          itemBuilder: (ctx, i){

            return
              Center(
                child: FlyerZone(
                  flyerSizeFactor: _flyerSizeFactor,
                  tappingFlyerZone: (){},
                  onLongPress: (){},
                  stackWidgets: <Widget>[

                    superImageWidget(
                      widget.pictures[i],
                      width: _flyerZoneWidth.toInt(),
                      height: _flyerZoneHeight.toInt(),
                    ),

                  ],
                ),
              );

          }
      ),
    );
  }
}
