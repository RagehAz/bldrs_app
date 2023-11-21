// ignore_for_file: unused_element

import 'package:basics/animators/helpers/sliders.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:provider/provider.dart';
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/structure/obelisk_layout_view.dart';
import 'package:bldrs/b_views/z_components/layouts/pyramids/super_pyramids.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';

class ObeliskLayout extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ObeliskLayout({
    required this.navModels,
    required this.canGoBack,
    required this.appBarIcon,
    required this.canSwipeBack,
    this.appBarRowWidgets,
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
    this.zGridController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<Widget>? appBarRowWidgets;
  final List<NavModel>? navModels;
  final int initialIndex;
  final Function? onBack;
  final bool canGoBack;
  final AppBarType appBarType;
  final Function? onSearchCancelled;
  final Verse? searchHintVerse;
  final ValueChanged<String?>? onSearchChanged;
  final TextEditingController? searchController;
  final ValueChanged<String?>? onSearchSubmit;
  final GlobalKey? globalKey;
  final Widget? abovePyramidsChild;
  final Widget? searchView;
  final ValueNotifier<bool>? isSearching;
  final ZGridController? zGridController;
  final String? appBarIcon;
  final bool canSwipeBack;
  /// --------------------------------------------------------------------------
  @override
  _ObeliskLayoutState createState() => _ObeliskLayoutState();
  /// --------------------------------------------------------------------------
}

class _ObeliskLayoutState extends State<ObeliskLayout> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  late TabController _tabController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    if (Mapper.checkCanLoopList(widget.navModels) == true){
      _pageTitleVerse = Verse(
        id: widget.navModels![widget.initialIndex].titleVerse?.id,
        translate: widget.navModels![widget.initialIndex].titleVerse?.translate,
        notifier: ValueNotifier(widget.navModels![widget.initialIndex].titleVerse?.id),
      );
    }
    else {
      _pageTitleVerse = const Verse(
        id: 'phid_keywords',
        translate: true,
      );
    }


    _initializeTabs();

  }
  // --------------------
  @override
  void dispose() {
    _tabController.dispose();
    _progressBarModel.dispose();
    _pageTitleVerse?.notifier?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// TABS

  // --------------------
  /// PROGRESS BAR MODEL : ( INDEX - SWIPE DIRECTION - NUMBER OF SLIDES )
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeTabs(){

      setNotifier(
          notifier: _progressBarModel,
          mounted: mounted,
          value: ProgressBarModel(
            swipeDirection: SwipeDirection.next,
            index: widget.initialIndex,
            numberOfStrips: widget.navModels?.length ?? 1,

          ),
      );

      // blog('should go now to tab : ${widget.initialIndex}');
      _tabController = TabController(
        vsync: this,
        length: widget.navModels?.length ?? 1,
        initialIndex: widget.initialIndex,
        animationDuration: const Duration(milliseconds: 250),
      );

      _tabController.animation?.addListener((){

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
          notifier: _pageTitleVerse?.notifier,
          mounted: mounted,
          value: widget.navModels![_progressBarModel.value!.index].titleVerse?.id,
        );

      });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void onChangeTabIndexWhileAnimation({
    required BuildContext context,
    required TabController tabController,
  }){

    if (tabController.indexIsChanging == false) {

      final int _indexFromAnimation = tabController.animation?.value.round() ?? 0;

      // blog('tabController.animation.value : ${tabController.animation.value}');

      final Verse? _newTab = widget.navModels![_indexFromAnimation].titleVerse;
      final Verse? _oldTab = widget.navModels![_progressBarModel.value!.index].titleVerse;

      /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
      if (_newTab?.id != _oldTab?.id){

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
        notifier: _pageTitleVerse?.notifier,
        mounted: mounted,
        value: widget.navModels![index].titleVerse?.id,
    );

    // blog('onRowTap index : $index : _pageTitle.value : ${_pageTitleVerse?.notifier?.value}');
    //
    ProgressBarModel.onSwipe(
      context: context,
      newIndex: index,
      progressBarModel: _progressBarModel,
      mounted: mounted,
    );

    _tabController.animateTo(_progressBarModel.value?.index ?? 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutExpo,
    );

  }
  // --------------------
  /// PAGE TITLE
  Verse? _pageTitleVerse;
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onBack() async {

    if (widget.onBack == null) {

      /// WHEN PYRAMIDS EXPANDED
      if (UiProvider.proGetPyramidsAreExpanded(context: getMainContext(), listen: false) == true) {
        UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);
      }

      else {
        await Nav.goBack(
          context: context,
          invoker: 'ObeliskLayout.onBack',
        );
      }

    }

    else {
      await widget.onBack?.call();
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final Widget _normalView = _NormalView(
      progressBarModel: _progressBarModel,
      navModels: widget.navModels ?? [],
      onRowTap: onRowTap,
      tabController: _tabController,
      mounted: mounted,
      abovePyramidsChild: widget.abovePyramidsChild,
    );

    return MainLayout(
      canSwipeBack: widget.canSwipeBack,
      globalKey: widget.globalKey,
      skyType: SkyType.grey,
      appBarType: widget.appBarType,
      title: _pageTitleVerse,
      loading: ValueNotifier(false),
      progressBarModel: _progressBarModel,
      canGoBack: widget.canGoBack,
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: widget.appBarIcon,
          bigIcon: true,
          bubble: false,
          onTap: () async {
            await onRowTap(0);
          },
        ),

        ...?widget.appBarRowWidgets,

      ],
      searchController: widget.searchController,
      searchHintVerse: widget.searchHintVerse,
      onSearchChanged: widget.onSearchChanged,
      onSearchSubmit: widget.onSearchSubmit,
      onSearchCancelled: widget.onSearchCancelled,
      onBack: _onBack,
      listenToHideLayout: true,
      child: widget.searchView == null || widget.isSearching == null?
      _normalView
          :
          ValueListenableBuilder(
            valueListenable: widget.isSearching!,
            child: _normalView,
            builder: (_, bool isSearching, Widget? normalView){

              if (isSearching == true){
                return widget.searchView!;
              }

              else {
                return normalView!;
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
    required this.tabController,
    required this.navModels,
    required this.onRowTap,
    required this.progressBarModel,
    required this.abovePyramidsChild,
    required this.mounted,
    super.key
  });
  // -----------------------------------------------------------------------------
  final TabController tabController;
  final List<NavModel> navModels;
  final ValueChanged<int> onRowTap;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final Widget? abovePyramidsChild;
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
          onRowTap: onRowTap,
          progressBarModel: progressBarModel,
          navModels: navModels,
          mounted: mounted,
        ),

        /// ABOVE PYRAMIDS CHILD
        if (abovePyramidsChild != null)
          Selector<UiProvider, bool>(
            key: const ValueKey<String>('abovePyramidsChildIsNotNull'),
            selector: (_, UiProvider uiProvider) => uiProvider.pyramidsAreExpanded,
            builder: (_, bool expanded, Widget? child) {

              return WidgetFader(
                fadeType: expanded == true ? FadeType.fadeOut : FadeType.fadeIn,
                curve: expanded == true ? Curves.easeInExpo : Curves.elasticInOut,
                duration: Duration(milliseconds: expanded == true ? 50 : 800),
                ignorePointer: expanded,
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
