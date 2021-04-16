import 'package:bldrs/controllers/drafters/flyer_sliders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/streamerz.dart';
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/views/widgets/flyer/aflyer.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class SwiperScreen extends StatefulWidget {
  @override
  _SwiperScreenState createState() => _SwiperScreenState();
}

class _SwiperScreenState extends State<SwiperScreen> {
  String currentSection = 'Designs';
  bool sectionsListIsOn = false;
  SwiperController _swiperController;
  FlyerType _currentFlyerType;
// -----------------------------------------------------------------------------
@override
  void initState() {
  _swiperController = new SwiperController();
  _currentFlyerType = FlyerModel.flyerTypesList[0];
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  // void _chooseSection(String sectionName) {
  //   setState(() {
  //     currentSection = sectionName;
  //     sectionsListIsOn = false;
  //   });
  //   print(currentSection);
  // }
// -----------------------------------------------------------------------------
  void openSectionsList() {
    print(sectionsListIsOn);
    setState(() {
      sectionsListIsOn == false
          ? sectionsListIsOn = true
          : sectionsListIsOn = false;
    });
  }
// -----------------------------------------------------------------------------
  void _goToNextFlyer(){
    _swiperController.next(animation: true);
  }
// -----------------------------------------------------------------------------
  void _goToLastFlyer(){
    _swiperController.previous(animation: true);
  }
// -----------------------------------------------------------------------------
  void _swipeFlyer(SlidingDirection swipeDirection){

  if (swipeDirection == SlidingDirection.next){
    _goToNextFlyer();
  } else if (swipeDirection == SlidingDirection.back){
    _goToLastFlyer();
  }

  }
// -----------------------------------------------------------------------------
//   void _changePage(FlyerType flyerType){
//   setState(() {
//     _currentFlyerType = flyerType;
//   });
//   }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);
    double _flyerSizeFactor = 0.8;
// -----------------------------------------------------------------------------
    final FlyersProvider pro = Provider.of<FlyersProvider>(context, listen: false);
    final List<TinyFlyer> _allTinyFlyers = pro.getAllTinyFlyers;
// -----------------------------------------------------------------------------
    List<FlyerType> _flyerTypesList = FlyerModel.flyerTypesList;
// -----------------------------------------------------------------------------
    return MainLayout(
      sky: Sky.Night,
      appBarType: AppBarType.Basic,
      pageTitle: TextGenerator.flyerTypePluralStringer(context, _currentFlyerType),
      pyramids: Iconz.DvBlankSVG,
      appBarBackButton: true,
      layoutWidget: PageView.builder(
        itemCount: _flyerTypesList.length,
        dragStartBehavior: DragStartBehavior.down,
        onPageChanged: (index){
          // playSound(Soundz.NextFlyer);

          setState(() {
            _currentFlyerType = _flyerTypesList[index];
          });
        },
        allowImplicitScrolling: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){

          final List<TinyFlyer> _tinyFlyersOfType = pro.getTinyFlyersByFlyerType(_flyerTypesList[index]);

          return

            Container(
              width: _screenWidth,
              height: _screenHeight,
              child: Swiper(
                autoplay: false,
                pagination: new SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: Colorz.White,
                    activeColor: Colorz.Yellow,
                    activeSize: 8,
                    size: 4,
                    space: 2,
                  ),
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 54, right: Ratioz.ddAppBarMargin * 2, left: Ratioz.ddAppBarMargin * 2),
                ),
                layout: SwiperLayout.DEFAULT,
                itemWidth: superFlyerZoneWidth(context, _flyerSizeFactor),
                itemHeight: superFlyerZoneHeight(context, superFlyerZoneWidth(context, _flyerSizeFactor)),
                // control: new SwiperControl(),
                // transformer: ,
                fade: 0.1,
                controller: _swiperController,
                duration: 600,
                viewportFraction: 1,
                curve: Curves.easeInOutCirc,
                scale: 0.6,
                itemCount: _tinyFlyersOfType.length,
                itemBuilder: (BuildContext context, int index) {
                  return

                    Column(
                      children: <Widget>[

                        Stratosphere(),

                        flyerModelBuilder(
                            context: context,
                            tinyFlyer: _tinyFlyersOfType[index],
                            flyerSizeFactor: _flyerSizeFactor,
                            builder: (ctx, flyerModel){
                              return AFlyer(
                                flyer: flyerModel,
                                flyerSizeFactor: _flyerSizeFactor,
                                swipe: (swipeDirection) => _swipeFlyer(swipeDirection),
                              );
                            }
                            ),

                      ],
                    );

              },
            ),
          );

        },

      ),
    );
  }
}



