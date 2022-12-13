import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout_view.dart';
import 'package:bldrs/b_views/z_components/pyramids/super_pyramids.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
    this.appBarType = AppBarType.basic,
    this.onSearchCancelled,
    this.searchHintVerse,
    this.onSearchChanged,
    this.searchController,
    this.onSearchSubmit,
    this.globalKey,
    this.abovePyramidsChild,
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

    _pageTitleVerse = Verse(
      text: widget.navModels[0].titleVerse.text,
      translate: widget.navModels[0].titleVerse.translate,
      notifier: ValueNotifier(widget.navModels[0].titleVerse.text),
    );

    _initializeTabs();

  }
  // --------------------
  @override
  void dispose() {
    _isExpanded.dispose();
    _tabController.dispose();
    _progressBarModel.dispose();
    _pageTitleVerse.notifier.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// TABS

  // --------------------
  /// PROGRESS BAR MODEL : ( INDEX - SWIPE DIRECTION - NUMBER OF SLIDES )
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  // --------------------
  void _initializeTabs(){

    if (Mapper.checkCanLoopList(widget.navModels) == true){

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
            numberOfStrips: widget.navModels.length,
          ),
      );

      // blog('should go now to tab : ${widget.initialIndex}');
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

        ProgressBarModel.onSwipe(
          context: context,
          newIndex: _tabController.index,
          progressBarModel: _progressBarModel,
        );

        setNotifier(
          notifier: _pageTitleVerse.notifier,
          mounted: mounted,
          value: widget.navModels[_progressBarModel.value.index].titleVerse.text,
        );

      });

    }

  }
  // --------------------
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
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      globalKey: widget.globalKey,
      skyType: SkyType.black,
      appBarType: widget.appBarType,
      pageTitleVerse: _pageTitleVerse,
      loading: ValueNotifier(false),
      progressBarModel: _progressBarModel,
      canGoBack: widget.canGoBack,
      appBarRowWidgets: widget.appBarRowWidgets,
      searchController: widget.searchController,
      searchHintVerse: widget.searchHintVerse,
      onSearchChanged: widget.onSearchChanged,
      onSearchSubmit: widget.onSearchSubmit,
      onSearchCancelled: widget.onSearchCancelled,
      onBack: () async {

        if (_isExpanded.value == false){
          if (widget.onBack != null){
            await widget.onBack();
          }
          await Nav.goBack(
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

          /// ABOVE PYRAMIDS CHILD
          if (widget.abovePyramidsChild != null)
            ValueListenableBuilder(
              valueListenable: _isExpanded,
              builder: (_, bool isExpanded, Widget child){

                if (isExpanded == true){
                  return const SizedBox();
                }

                else {
                  return WidgetFader(
                    fadeType: FadeType.fadeIn,
                    curve: Curves.elasticInOut,
                    duration: const Duration(milliseconds: 800),
                    child: child,
                  );
                }

              },
              child: widget.abovePyramidsChild,
            ),

        ],
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
