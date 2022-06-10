import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_credits_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/bz_obelisk.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/obelisk_layout/obelisk_pages.dart';
import 'package:flutter/material.dart';

class ObeliskLayout extends StatefulWidget {

  const ObeliskLayout({
    Key key
  }) : super(key: key);

  @override
  State<ObeliskLayout> createState() => _ObeliskLayoutState();
}

class _ObeliskLayoutState extends State<ObeliskLayout> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  TabController _tabController;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _tabController = TabController(
      vsync: this,
      length: BzModel.bzPagesTabsTitlesInEnglishOnly.length,
    );

    _pageTitle = ValueNotifier(getTabTitle(0));

    _tabController.animation.addListener((){

      onChangeMyBzScreenTabIndexWhileAnimation(
        context: context,
        tabController: _tabController,
      );

      onHorizontalSlideSwipe(
        context: context,
        newIndex: _tabController.index,
        currentSlideIndex: _tabIndex,
        swipeDirection: _swipeDirection,
      );

      _pageTitle.value = getTabTitle(_tabIndex.value);

    });

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _isExpanded.dispose();
    _pageController.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  final PageController _pageController = PageController();
// -----------------------------------------------------------------------------
  void onTriggerExpansion(){
    _isExpanded.value = !_isExpanded.value;
  }
// -----------------------------------------------------------------------------
  /// TAB INDEX
  final ValueNotifier<int> _tabIndex = ValueNotifier(0);
  ValueNotifier<String> _pageTitle;
  /// SWIPE DIRECTION
  final ValueNotifier<Sliders.SwipeDirection> _swipeDirection = ValueNotifier(Sliders.SwipeDirection.next); /// tamam disposed
// -------------------------------------------
  Future<void> onRowTap(BzTab bzTab) async {

    onHorizontalSlideSwipe(
      context: context,
      newIndex: BzModel.getBzTabIndex(bzTab),
      currentSlideIndex: _tabIndex,
      swipeDirection: _swipeDirection,
    );

    _tabController.animateTo(_tabIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
    );

    _pageTitle.value = getTabTitle(_tabIndex.value);

  }
// -----------------------------------------------------------------------------
  String getTabTitle(int index){
    final BzTab _bzTab = BzModel.bzTabsList[_tabIndex.value];
    final String _tabTitle = BzModel.translateBzTab(_bzTab);
    return _tabTitle;
  }
// -----------------------------------------------------------------------------
  bool pyramidBig = false;

  @override
  Widget build(BuildContext context) {

    final double _screenHeight = superScreenHeightWithoutSafeArea(context);
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);

    return MainLayout(
      // pyramidType: PyramidType.yellow,
      // pyramidsAreOn: false,
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: _pageTitle,
      appBarRowWidgets: <Widget>[

        const Expander(),

        BzCreditsCounter(
          width: Ratioz.appBarButtonSize * 1.4,
          slidesCredit: Numeric.formatNumToCounterCaliber(context, 1234),
          ankhsCredit: Numeric.formatNumToCounterCaliber(context, 123),
        ),


        BzLogo(
          width: 40,
          image: _bzModel.logo,
          margins: const EdgeInsets.symmetric(horizontal: 5),
          corners: superBorderAll(context, Ratioz.appBarCorner - 5),
        ),

      ],
      layoutWidget: Stack(
        children: <Widget>[

          /// PAGES
          ObeliskPages(
            screenHeight: _screenHeight,
            tabController: _tabController,
          ),

          /// PROGRESS BAR
          ValueListenableBuilder(
              valueListenable: _tabIndex,
              builder: (_, int index, Widget child){

                return ValueListenableBuilder(
                    valueListenable: _swipeDirection,
                    builder: (_, Sliders.SwipeDirection direction, Widget childB){

                      return StaticProgressBar(
                        flyerBoxWidth: superScreenWidth(context),
                        numberOfSlides: BzModel.bzTabsList.length,
                        index: index,
                        opacity: 1,
                        swipeDirection: direction,
                        loading: false,
                        margins: EdgeInsets.only(
                            top: BldrsAppBar.height(context, AppBarType.basic) + Ratioz.appBarMargin + Ratioz.appBarPadding,
                        ),
                      );

                    }
                );

              }
          ),

          /// SINGLE PYRAMID
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 17 * 0.7),
              child: AnimatedScale(
                scale: pyramidBig == true ? 8 : 1,
                duration: const Duration(milliseconds: 500),
                curve: pyramidBig == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
                alignment: Alignment.bottomRight,
                child: const Opacity(
                  opacity: 1,
                  child: SuperImage(
                    width: 143.1 * 0.7,
                    height: 66.4 * 0.7,
                    pic: Iconz.pyramid,
                    boxFit: BoxFit.fitWidth,
                    iconColor: Colorz.black230,
                    // scale: 1,
                  ),
                ),
              ),
            ),
          ),

          /// OBELISK
          BzObelisk(
              isExpanded: _isExpanded,
              onTriggerExpansion: onTriggerExpansion,
              onRowTap: onRowTap,
              tabIndex: _tabIndex,
          ),

          /// PYRAMIDS
          ValueListenableBuilder(
              valueListenable: _isExpanded,
              builder: (_, bool expanded, Widget child){

                return Positioned(
                  bottom: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 17 * 0.7),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 500),
                      curve: expanded == true ?  Curves.easeOutQuart : Curves.easeOutQuart,
                      scale: expanded == true ? 0.95 : 1,
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){

                          blog('a77aa');

                          _isExpanded.value = !_isExpanded.value;
                          setState(() {
                            pyramidBig = !pyramidBig;
                          });

                        },
                        child: const SuperImage(
                          width: 256 * 0.7,
                          height: 80 * 0.7,
                          pic: Iconz.pyramidsYellowClean,
                          boxFit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                );

              }
          ),


        ],
      ),
    );

  }

}
