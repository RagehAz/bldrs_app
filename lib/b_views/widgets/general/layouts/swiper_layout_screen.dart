import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/widgets/general/layouts/night_sky.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/progress_bar.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/f_helpers/drafters/animators.dart' as Animators;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  int _pageIndex = 0;
  Sliders.SwipeDirection _swipeDirection = Sliders.SwipeDirection.freeze;
  void _onHorizontalSlideSwipe(int newIndex) {
    // blog('flyer onPageChanged oldIndex: ${_superFlyer.currentSlideIndex}, newIndex: $newIndex, _draft.numberOfSlides: ${_superFlyer.numberOfSlides}');
    final Sliders.SwipeDirection _direction = Animators.getSwipeDirection(
      newIndex: newIndex,
      oldIndex: _pageIndex,
    );

    /// A - if Keyboard is active
    if (keyboardIsOn(context) == true) {
      blog('KEYBOARD IS ACTIVE');

      /// B - when direction is going next
      if (_direction == Sliders.SwipeDirection.next) {
        blog('going next');
        FocusScope.of(context).nextFocus();
        setState(() {
          _swipeDirection = _direction;
          _pageIndex = newIndex;
        });
      }

      /// B - when direction is going back
      else if (_direction == Sliders.SwipeDirection.back) {
        blog('going back');
        FocusScope.of(context).previousFocus();
        setState(() {
          _swipeDirection = _direction;
          _pageIndex = newIndex;
        });
      }

      /// B = when direction is freezing
      else {
        blog('going no where');
        setState(() {
          _swipeDirection = _direction;
          _pageIndex = newIndex;
        });
      }
    }

    /// A - if keyboard is not active
    else {
      // blog('KEYBOARD IS NOT ACTIVE');
      setState(() {
        _swipeDirection = _direction;
        _pageIndex = newIndex;
      });
    }
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
      appBarType: AppBarType.basic,
      pageTitle: _title,
      // appBarBackButton: true,
      // layoutWidget: Swiper(
      //   physics: const BouncingScrollPhysics(),
      //   pagination: const SwiperPagination(
      //     builder: DotSwiperPaginationBuilder(
      //       color: Colorz.white255,
      //       activeColor: Colorz.yellow255,
      //       activeSize: 8,
      //       size: 4,
      //       space: 2,
      //     ),
      //     alignment: Alignment.topCenter,
      //     margin: EdgeInsets.only(
      //         top: 54,
      //         right: Ratioz.appBarMargin * 2,
      //         left: Ratioz.appBarMargin * 2),
      //   ),
      //   itemWidth: _screenWidth, // in-effective
      //   itemHeight: _pageHeight, // in-effective
      //   containerWidth: _screenWidth, // in-effective
      //   containerHeight: _pageHeight,
      //   // control: new SwiperControl(),
      //   // transformer: ,
      //   onIndexChanged: (int index) {
      //     setState(() {
      //       _title = widget.swiperPages[index]['title'];
      //     });
      //   },
      //   fade: 0.1,
      //   controller: _swiperController,
      //   duration: 600,
      //   curve: Curves.easeInOutCirc,
      //   scale: 0.6,
      //   itemCount: widget.swiperPages.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       width: _screenWidth,
      //       height: _pageHeight,
      //       alignment: Alignment.topCenter,
      //       child: Column(
      //         children: <Widget>[
      //           const Stratosphere(),
      //           SizedBox(
      //             width: _screenWidth,
      //             height: _pageHeight,
      //             child: widget.swiperPages[index]['widget'],
      //           ),
      //         ],
      //       ),
      //     );
      //   },
      // ),

      layoutWidget: Stack(

        children: <Widget>[

          ProgressBar(
            flyerBoxWidth: _screenWidth,
            index: _pageIndex,
            numberOfSlides: widget.swiperPages.length,
            numberOfStrips: widget.swiperPages.length,
            swipeDirection: _swipeDirection,
            opacity: 1,
            margins: const EdgeInsets.only(top: Ratioz.stratosphere - Ratioz.appBarMargin - 2),
            loading: false,
          ),

          PageView.builder(
              physics: const BouncingScrollPhysics(),
              onPageChanged: _onHorizontalSlideSwipe,
              itemCount: widget.swiperPages.length,
              itemBuilder: (_, index){

                return Container(
                    key: PageStorageKey<String>(widget.swiperPages[index]['title']),
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
                    )
                );

              }
          ),

        ],

      ),


    );
  }
}
