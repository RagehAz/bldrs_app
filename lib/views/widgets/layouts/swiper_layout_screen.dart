import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperLayoutScreen extends StatefulWidget {
  /// this recieves a map like this
  /// {
  /// 'title' : 'page title here',
  /// 'widget' : pageWidgetInsideFullScreenContainer
  /// }
  final List<Map<String, dynamic>> swiperPages;
  final Sky sky;

  SwiperLayoutScreen({
    @required this. swiperPages,
    this.sky = Sky.Night,
  });

  @override
  _SwiperLayoutScreenState createState() => _SwiperLayoutScreenState();
}

class _SwiperLayoutScreenState extends State<SwiperLayoutScreen> {
  SwiperController _swiperController;
  String _title;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _title = widget.swiperPages[0]['title'];

    _swiperController = new SwiperController();
    super.initState();
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
    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    double _itemWidth = _screenWidth;
    double _itemHeight = _screenHeight;
// -----------------------------------------------------------------------------

    return MainLayout(
      sky: widget.sky,
      appBarType: AppBarType.Basic,
      pageTitle: _title,
      pyramids: Iconz.DvBlankSVG,
      // appBarBackButton: true,
      layoutWidget: Swiper(
        autoplay: false,
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colorz.White255,
            activeColor: Colorz.Yellow255,
            activeSize: 8,
            size: 4,
            space: 2,
          ),
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 54, right: Ratioz.appBarMargin * 2, left: Ratioz.appBarMargin * 2),
        ),
        layout: SwiperLayout.DEFAULT,
        itemWidth: _itemWidth,
        itemHeight: _itemHeight,
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

            Column(
              children: <Widget>[

                Stratosphere(),

                Container(
                  width: _screenWidth,
                  height: _screenHeight - Ratioz.stratosphere - 24,
                  child: widget.swiperPages[index]['widget'],
                ),

              ],
            );

        },
      ),
    );
  }
}
