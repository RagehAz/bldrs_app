import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/unfinished_night_sky.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/slides_controller.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/nav_model.dart';
import 'package:bldrs/x_dashboard/a_modules/a_test_labs/specialized_labs/new_navigators/obelisk_layout_view.dart';
import 'package:flutter/material.dart';

class ObeliskLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayout({
    @required this.navModels,
    this.appBarRowWidgets,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final List<NavModel> navModels;
  /// --------------------------------------------------------------------------
  @override
  _ObeliskLayoutState createState() => _ObeliskLayoutState();
/// --------------------------------------------------------------------------
}

class _ObeliskLayoutState extends State<ObeliskLayout> with SingleTickerProviderStateMixin {
// -----------------------------------------------------------------------------
  TabController _tabController;
// -----------------------------------------------------------------------------
  @override
  void initState() {

    _pageTitle = ValueNotifier(widget.navModels[0].title);

    _initializeTabs();

    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _isExpanded.dispose();
    _tabController.dispose();
    _swipeDirection.dispose();
    _tabIndex.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// TABS

// -------------------------------------
  /// TAB INDEX
  ValueNotifier<int> _tabIndex;
// -------------------------------------
  /// SWIPE DIRECTION
  ValueNotifier<Sliders.SwipeDirection> _swipeDirection; /// tamam disposed
// -------------------------------------
  void _initializeTabs(){

    if (checkCanLoopList(widget.navModels) == true){

      _tabIndex = ValueNotifier(0);
      _swipeDirection = ValueNotifier(Sliders.SwipeDirection.next);

      _tabController = TabController(
        vsync: this,
        length: widget.navModels.length,
      );

      _tabController.animation.addListener((){

        final int _indexFromAnimation = (_tabController.animation.value).round();

        final String _newTab = widget.navModels[_indexFromAnimation].title;
        final String _previousTab = widget.navModels[_tabController.index].title;


        if (_newTab != _previousTab){
          // blog('index is $index');
          // _uiProvider.setCurrentBzTab(_newTab);
          _tabController.animateTo(_indexFromAnimation,
              curve: Curves.easeIn,
              duration: Ratioz.duration150ms
          );
        }

        onHorizontalSlideSwipe(
          context: context,
          newIndex: _tabController.index,
          currentSlideIndex: _tabIndex,
          swipeDirection: _swipeDirection,
        );

        _pageTitle.value = widget.navModels[_tabIndex.value].title;

      });

    }

  }
// -----------------------------------------------------------------------------
  void slideToTab({
    @required int tabIndex,
    @required bool animate,
  }) {

    // onHorizontalSlideSwipe(
    //   context: context,
    //   newIndex: tabIndex,
    //   currentSlideIndex: _tabIndex,
    //   swipeDirection: _swipeDirection,
    // );
    //
    // if (animate == true){
    //   _tabController.animateTo(_tabIndex.value,
    //     duration: const Duration(milliseconds: 500),
    //     curve: Curves.easeOutExpo,
    //   );
    // }

    onHorizontalSlideSwipe(
      context: context,
      newIndex: tabIndex,
      currentSlideIndex: _tabIndex,
      swipeDirection: _swipeDirection,
    );

    _tabController.animateTo(_tabIndex.value,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
    );


    _pageTitle.value = widget.navModels[tabIndex].title;

  }
// -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

// -------------------------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
// -------------------------------------
  void onTriggerExpansion(){
    _isExpanded.value = !_isExpanded.value;
  }
// -----------------------------------------------------------------------------
  /// PAGE TITLE
  ValueNotifier<String> _pageTitle;
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      zoneButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitle: _pageTitle,
      loading: ValueNotifier(false),
      index: _tabIndex,
      swipeDirection: _swipeDirection,
      numberOfStrips: widget.navModels.length,
      canGoBack: false,
      appBarRowWidgets: widget.appBarRowWidgets,
      onBack: (){

        if (_isExpanded.value == false){
          Nav.goBack(context);
        }
        else {
          _isExpanded.value = false;
        }

      },
      layoutWidget: Stack(
        children: <Widget>[

          /// VIEWS
          ObeliskLayoutView(
            tabController: _tabController,
            children: NavModel.getScreens(widget.navModels),
          ),

          /// PYRAMIDS NAVIGATOR
          SuperPyramids(
            isExpanded: _isExpanded,
            onExpansion: onTriggerExpansion,
            onRowTap: (int index) => slideToTab(
              tabIndex: index,
              animate: true,
            ),
            tabIndex: _tabIndex,
            navModels: widget.navModels,
          ),

        ],
      ),
    );

  }
}
