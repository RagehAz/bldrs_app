import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperLayoutScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SwiperLayoutScreen({
    @required this.swiperPages,
    this.sky = SkyType.night,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SkyType sky;

  /// this receives a map like this
  /// {
  /// 'title' : 'page title here',
  /// 'widget' : pageWidgetInsideFullScreenContainer
  /// }
  final List<Map<String, dynamic>> swiperPages;

  /// --------------------------------------------------------------------------
  @override
  _SwiperLayoutScreenState createState() => _SwiperLayoutScreenState();

  /// --------------------------------------------------------------------------
}

class _SwiperLayoutScreenState extends State<SwiperLayoutScreen> {
  SwiperController _swiperController;
  String _title;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _title = Mapper.canLoopList(widget.swiperPages)
        ? widget.swiperPages[0]['title']
        : '...';

    _swiperController = SwiperController();
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
    final double _screenHeight =
        Scale.superScreenHeightWithoutSafeArea(context);
// -----------------------------------------------------------------------------
    final double _pageHeight = _screenHeight - Ratioz.stratosphere;

    return MainLayout(
      skyType: widget.sky,
      appBarType: AppBarType.basic,
      pageTitle: _title,
      pyramids: Iconz.dvBlankSVG,
      // appBarBackButton: true,
      layoutWidget: Swiper(
        physics: const BouncingScrollPhysics(),
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colorz.white255,
            activeColor: Colorz.yellow255,
            activeSize: 8,
            size: 4,
            space: 2,
          ),
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(
              top: 54,
              right: Ratioz.appBarMargin * 2,
              left: Ratioz.appBarMargin * 2),
        ),
        itemWidth: _screenWidth, // in-effective
        itemHeight: _pageHeight, // in-effective
        containerWidth: _screenWidth, // in-effective
        containerHeight: _pageHeight,
        // control: new SwiperControl(),
        // transformer: ,
        onIndexChanged: (int index) {
          setState(() {
            _title = widget.swiperPages[index]['title'];
          });
        },
        fade: 0.1,
        controller: _swiperController,
        duration: 600,
        curve: Curves.easeInOutCirc,
        scale: 0.6,
        itemCount: widget.swiperPages.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: _screenWidth,
            height: _pageHeight,
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                const Stratosphere(),
                SizedBox(
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
