import 'package:widget_fader/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout_view.dart';
import 'package:bldrs/b_views/z_components/pyramids/super_pyramids.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class ObeliskLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayout({
    @required this.navModels,
    @required this.canGoBack,
    this.appBarRowWidgets,
    this.initiallyExpanded = false,
    this.initialIndex = 0,
    this.onBack,
    this.appBarType = AppBarType.basic,
    this.onSearchCancelled,
    this.searchHintVerse,
    this.onSearchChanged,
    this.searchController,
    this.onSearchSubmit,
    this.globalKey,
    this.abovePyramidsChild,
    this.searchView,
    this.isSearching,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> appBarRowWidgets;
  final List<NavModel> navModels;
  final bool initiallyExpanded;
  final int initialIndex;
  final Function onBack;
  final bool canGoBack;
  final AppBarType appBarType;

  final Function onSearchCancelled;
  final Verse searchHintVerse;
  final ValueChanged<String> onSearchChanged;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchSubmit;
  final GlobalKey globalKey;
  final Widget abovePyramidsChild;
  final Widget searchView;
  final ValueNotifier<bool> isSearching;
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

    if (Mapper.checkCanLoopList(widget.navModels) == true){
      _pageTitleVerse = Verse(
        text: widget.navModels[0].titleVerse.text,
        translate: widget.navModels[0].titleVerse.translate,
        notifier: ValueNotifier(widget.navModels[0].titleVerse.text),
      );
    }
    else {
      _pageTitleVerse = const Verse(
        text: 'phid_keywords',
        translate: true,
      );
    }


    _initializeTabs();

  }
  // --------------------
  @override
  void dispose() {
    _isExpanded.dispose();
    _tabController.dispose();
    _progressBarModel.dispose();
    _pageTitleVerse.notifier?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// TABS

  // --------------------
  /// PROGRESS BAR MODEL : ( INDEX - SWIPE DIRECTION - NUMBER OF SLIDES )
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeTabs(){

      setNotifier(
          notifier: _isExpanded,
          mounted: mounted,
          value: widget.initiallyExpanded,
      );

      setNotifier(
          notifier: _progressBarModel,
          mounted: mounted,
          value: ProgressBarModel(
            swipeDirection: SwipeDirection.next,
            index: widget.initialIndex,
            numberOfStrips: widget.navModels.length ?? 1,
          ),
      );

      // blog('should go now to tab : ${widget.initialIndex}');
      _tabController = TabController(
        vsync: this,
        length: widget.navModels.length ?? 1,
        initialIndex: widget.initialIndex,
        animationDuration: const Duration(milliseconds: 250),
      );

      _tabController.animation.addListener((){

        onChangeTabIndexWhileAnimation(
          context: context,
          tabController: _tabController,
        );

        ProgressBarModel.onSwipe(
          context: context,
          newIndex: _tabController.index,
          progressBarModel: _progressBarModel,
          mounted: mounted,
        );

        setNotifier(
          notifier: _pageTitleVerse.notifier,
          mounted: mounted,
          value: widget.navModels[_progressBarModel.value.index].titleVerse.text,
        );

      });


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onChangeTabIndexWhileAnimation({
    @required BuildContext context,
    @required TabController tabController,
  }){

    if (tabController.indexIsChanging == false) {

      final int _indexFromAnimation = (tabController.animation.value).round();

      // blog('tabController.animation.value : ${tabController.animation.value}');

      final Verse _newTab = widget.navModels[_indexFromAnimation].titleVerse;
      final Verse _oldTab = widget.navModels[_progressBarModel.value.index].titleVerse;

      /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
      if (_newTab.text != _oldTab.text){

        // _uiProvider.setCurrentUserTab(_newTab);
        tabController.animateTo(_indexFromAnimation,
            curve: Curves.easeIn,
            duration: Ratioz.duration150ms
        );
      }

    }

  }
  // --------------------
  Future<void> onRowTap(int index) async {

    setNotifier(
        notifier: _pageTitleVerse.notifier,
        mounted: mounted,
        value: widget.navModels[index].titleVerse.text,
    );

    blog('onRowTap index : $index : _pageTitle.value : ${_pageTitleVerse.notifier.value}');

    ProgressBarModel.onSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
      mounted: mounted,
    );

    _tabController.animateTo(_progressBarModel.value.index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
    );

  }
  // -----------------------------------------------------------------------------

  /// PYRAMID EXPANSION

  // --------------------
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  // --------------------
  /// TESTED : WORKS PERFECT
  void onTriggerExpansion(){
    setNotifier(
        notifier: _isExpanded,
        mounted: mounted,
        value: !_isExpanded.value
    );
  }
  // --------------------
  /// PAGE TITLE
  Verse _pageTitleVerse;
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onBack() async {

    /// WHEN PYRAMIDS EXPANDED
    if (_isExpanded.value == true){
      setNotifier(notifier: _isExpanded, mounted: mounted, value: false);
    }

    /// WHEN PYRAMIDS COLLAPSED
    else {

      /// ON BACK IS NOT DEFINED
      if (widget.onBack == null){
        await Nav.goBack(
          context: context,
          invoker: 'ObeliskLayout.onBack',
        );
      }

      /// BACK IS DEFINED
      else {
        await widget.onBack();
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _normalView = _NormalView(
      progressBarModel: _progressBarModel,
      isExpanded: _isExpanded,
      navModels: widget.navModels,
      onRowTap: onRowTap,
      onTriggerExpansion: onTriggerExpansion,
      tabController: _tabController,
      mounted: mounted,
      abovePyramidsChild: widget.abovePyramidsChild,
    );

    return MainLayout(
      globalKey: widget.globalKey,
      skyType: SkyType.black,
      appBarType: widget.appBarType,
      title: _pageTitleVerse,
      loading: ValueNotifier(false),
      progressBarModel: _progressBarModel,
      canGoBack: widget.canGoBack,
      appBarRowWidgets: widget.appBarRowWidgets,
      searchController: widget.searchController,
      searchHintVerse: widget.searchHintVerse,
      onSearchChanged: widget.onSearchChanged,
      onSearchSubmit: widget.onSearchSubmit,
      onSearchCancelled: widget.onSearchCancelled,
      onBack: _onBack,
      child: widget.searchView == null || widget.isSearching == null?
      _normalView
          :
          ValueListenableBuilder(
            valueListenable: widget.isSearching,
            child: _normalView,
            builder: (_, bool isSearching, Widget normalView){

              if (isSearching == true){
                return widget.searchView;
              }

              else {
                return normalView;
              }

            },
          ),

    );

  }
  // -----------------------------------------------------------------------------
}

class _NormalView extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _NormalView({
    @required this.tabController,
    @required this.navModels,
    @required this.isExpanded,
    @required this.onTriggerExpansion,
    @required this.onRowTap,
    @required this.progressBarModel,
    @required this.abovePyramidsChild,
    @required this.mounted,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final TabController tabController;
  final List<NavModel> navModels;
  final ValueNotifier<bool> isExpanded;
  final Function onTriggerExpansion;
  final ValueChanged<int> onRowTap;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final Widget abovePyramidsChild;
  final bool mounted;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[

        /// VIEWS
        ObeliskLayoutView(
          tabController: tabController,
          children: NavModel.getScreens(navModels),
        ),

        /// PYRAMIDS NAVIGATOR
        SuperPyramids(
          isExpanded: isExpanded,
          onExpansion: onTriggerExpansion,
          onRowTap: onRowTap,
          progressBarModel: progressBarModel,
          navModels: navModels,
          mounted: mounted,
        ),

        /// ABOVE PYRAMIDS CHILD
        if (abovePyramidsChild != null)
          ValueListenableBuilder(
            valueListenable: isExpanded,
            builder: (_, bool _isExpanded, Widget child){

              return WidgetFader(
                fadeType: _isExpanded == true ? FadeType.fadeOut : FadeType.fadeIn,
                curve: _isExpanded == true ? Curves.easeInExpo : Curves.elasticInOut,
                duration: Duration(milliseconds: _isExpanded == true ? 50 : 800),
                ignorePointer: _isExpanded,
                child: child,
              );

            },
            child: abovePyramidsChild,
          ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
