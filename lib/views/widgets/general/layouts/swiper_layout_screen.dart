import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperLayoutScreen extends StatefulWidget {
  /// this receives a map like this
  /// {
  /// 'title' : 'page title here',
  /// 'widget' : pageWidgetInsideFullScreenContainer
  /// }
  final List<Map<String, dynamic>> swiperPages;
  final SkyType sky;

  const SwiperLayoutScreen({
    @required this. swiperPages,
    this.sky = SkyType.Night,
    Key key,
  }) : super(key: key);

  @override
  _SwiperLayoutScreenState createState() => _SwiperLayoutScreenState();
}

class _SwiperLayoutScreenState extends State<SwiperLayoutScreen> {
  SwiperController _swiperController;
  String _title;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _title = Mapper.canLoopList(widget.swiperPages) ? widget.swiperPages[0]['title'] : '...';

    _swiperController = new SwiperController();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    final double _pageHeight = _screenHeight - Ratioz.stratosphere;

    return MainLayout(
      skyType: widget.sky,
      appBarType: AppBarType.Basic,
      pageTitle: _title,
      pyramids: Iconz.DvBlankSVG,
      // appBarBackButton: true,
      layoutWidget: Swiper(
        physics: const BouncingScrollPhysics(),
        autoplay: false,
        pagination: const SwiperPagination(
          builder: const DotSwiperPaginationBuilder(
            color: Colorz.white255,
            activeColor: Colorz.yellow255,
            activeSize: 8,
            size: 4,
            space: 2,
          ),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 54, right: Ratioz.appBarMargin * 2, left: Ratioz.appBarMargin * 2),
        ),
        layout: SwiperLayout.DEFAULT,
        itemWidth: _screenWidth, // in-effective
        itemHeight: _pageHeight, // in-effective
        containerWidth: _screenWidth, // in-effective
        containerHeight: _pageHeight, // in-effective
        loop: true,
        outer: false,
        // control: new SwiperControl(),
        // transformer: ,
        onIndexChanged: (index){
          setState(() {
            _title = widget.swiperPages[index]['title'];
          });
        },
        fade: 0.1,
        controller: _swiperController,
        duration: 600,
        viewportFraction: 1,
        curve: Curves.easeInOutCirc,
        scale: 0.6,
        itemCount: widget.swiperPages.length,
        itemBuilder: (BuildContext context, int index) {

          return

            Container(
              width: _screenWidth,
              height: _pageHeight,
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[

                  const Stratosphere(),

                  Container(
                    width: _screenWidth,
                    height: _pageHeight,
                    child: widget.swiperPages[index]['widget'],
                  ),

                ],
              ),
            );

        },
      ),
    );
  }
}
