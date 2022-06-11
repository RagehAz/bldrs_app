import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/bz_profile/appbar/bz_credits_counter.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_pages.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/f_my_bz_screen_controller.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class MyBzScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MyBzScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  State<MyBzScreen> createState() => _MyBzScreenState();
/// --------------------------------------------------------------------------
}

class _MyBzScreenState extends State<MyBzScreen> with SingleTickerProviderStateMixin {
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
  /// PAGE TITLE
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

  @override
  Widget build(BuildContext context) {

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(context: context, listen: true);
    final double _screenHeight = superScreenHeightWithoutSafeArea(context);

    return MainLayout(
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: _pageTitle,
      loading: ValueNotifier(false),
      index: _tabIndex,
      swipeDirection: _swipeDirection,
      numberOfStrips: BzModel.bzTabsList.length,
      canGoBack: false,
      onBack: (){

        if (_isExpanded.value == false){
          Nav.goBack(context);
        }
        else {
          _isExpanded.value = false;
        }

      },
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
          MyBzScreenPages(
            screenHeight: _screenHeight,
            tabController: _tabController,
          ),

          /// PYRAMIDS NAVIGATOR
          OPyramids(
            isExpanded: _isExpanded,
            onExpansion: onTriggerExpansion,
            onRowTap: onRowTap,
            tabIndex: _tabIndex,
          ),

        ],
      ),
    );

  }

}
