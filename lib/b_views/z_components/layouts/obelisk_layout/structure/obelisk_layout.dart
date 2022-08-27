import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout_view.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/super_pyramids.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/xx_slides_controllers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/nav_model.dart';
import 'package:flutter/material.dart';

class ObeliskLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayout({
    @required this.navModels,
    @required this.canGoBack,
    this.appBarRowWidgets,
    this.initiallyExpanded = false,
    this.initialIndex = 0,
    this.onBack,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final List<NavModel> navModels;
  final bool initiallyExpanded;
  final int initialIndex;
  final Function onBack;
  final bool canGoBack;
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
    super.initState();

    _pageTitle = ValueNotifier(widget.navModels[0].title);

    _initializeTabs();

  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _isExpanded.dispose();
    _tabController.dispose();
    _progressBarModel.dispose();
    _pageTitle.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------

  /// TABS

// -------------------------------------
  /// PROGRESS BAR MODEL : ( INDEX - SWIPE DIRECTION - NUMBER OF SLIDES )
  ValueNotifier<ProgressBarModel> _progressBarModel;
// -------------------------------------
  void _initializeTabs(){

    if (Mapper.checkCanLoopList(widget.navModels) == true){

      _isExpanded = ValueNotifier(widget.initiallyExpanded);

      final ProgressBarModel _initialProgModel = ProgressBarModel(
          swipeDirection: SwipeDirection.next,
          index: widget.initialIndex,
          numberOfStrips: widget.navModels.length,
      );
      _progressBarModel = ValueNotifier(_initialProgModel);

      _tabController = TabController(
        vsync: this,
        length: widget.navModels.length,
        initialIndex: widget.initialIndex,
        animationDuration: const Duration(milliseconds: 250),
      );

      _tabController.animation.addListener((){

        onChangeTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        );

        onHorizontalSlideSwipe(
          context: context,
          newIndex: _tabController.index,
          progressBarModel: _progressBarModel,
        );

        _pageTitle.value = widget.navModels[_progressBarModel.value.index].title;


      });

    }

  }
// -----------------------------------------------------------------------------
  void onChangeTabIndexWhileAnimation({
    @required BuildContext context,
    @required TabController tabController,
  }){

    if (tabController.indexIsChanging == false) {

      final int _indexFromAnimation = (tabController.animation.value).round();

      // blog('tabController.animation.value : ${tabController.animation.value}');

      final String _newTab = widget.navModels[_indexFromAnimation].title;
      final String _oldTab = widget.navModels[_progressBarModel.value.index].title;

      /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
      if (_newTab != _oldTab){

        // _uiProvider.setCurrentUserTab(_newTab);
        tabController.animateTo(_indexFromAnimation,
            curve: Curves.easeIn,
            duration: Ratioz.duration150ms
        );
      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> onRowTap(int index) async {

    blog('yel3an deen om index : $index : _pageTitle.value : ${_pageTitle.value}');

    _pageTitle.value = widget.navModels[index].title;

    blog('yel3an deen om index : $index : _pageTitle.value : ${_pageTitle.value}');


    onHorizontalSlideSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
    );

    _tabController.animateTo(_progressBarModel.value.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
    );

    // _tabController.animateTo(index);

  }
// -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

// -------------------------------------
  ValueNotifier<bool> _isExpanded;
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
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      appBarType: AppBarType.basic,
      pageTitleVerse: _pageTitle,
      loading: ValueNotifier(false),
      progressBarModel: _progressBarModel,
      canGoBack: widget.canGoBack,
      appBarRowWidgets: widget.appBarRowWidgets,
      onBack: (){

        if (_isExpanded.value == false){
          if (widget.onBack != null){
            widget.onBack();
          }
          Nav.goBack(
            context: context,
            invoker: 'ObeliskLayout.onBack',
          );

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
            onRowTap: onRowTap,
            progressBarModel: _progressBarModel,
            navModels: widget.navModels,
          ),

        ],
      ),
    );

  }
}
