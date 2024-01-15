import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabs.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
/// => TAMAM
// final TabsProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class HomeProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// TAB BAR CONTROLLER

  // --------------------
  TabController? _tabBarController;
  TabController? get tabBarController => _tabBarController;
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proInitializeTabBarController({
    required BuildContext context,
    required TickerProvider vsync,
  }){
    final HomeProvider _uiProvider = Provider.of<HomeProvider>(context, listen: false);
    _uiProvider._initializeTabBarController(
      context: context,
      vsync: vsync,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _initializeTabBarController({
    required BuildContext context,
    required TickerProvider vsync,
  }){

    _tabBarController = TabController(
      length: BldrsTabs.allTabs.length,
      vsync: vsync,
    );

    // _tabBarController!.addListener(() {

      // TabsProvider.proSetCurrentTab(
      //   context: context,
      //   tab: BldrsTab.home,
      //   notify: true,
      // );

    // });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proDisposeTabBarController(){
    final HomeProvider _uiProvider = Provider.of<HomeProvider>(getMainContext(), listen: false);
    _uiProvider._tabBarController?.dispose();
    _uiProvider._tabBarController = null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TabController? proGetTabController({
    required BuildContext context,
    required bool listen,
  }){
    final HomeProvider _uiProvider = Provider.of<HomeProvider>(context, listen: listen);
    return _uiProvider.tabBarController;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetTabBarController({
    required BuildContext context,
    required TabController controller,
    required bool notify,
  }) {
    final HomeProvider _uiProvider = Provider.of<HomeProvider>(context, listen: false);
    _uiProvider._setTabBarController(
      controller: controller,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setTabBarController({
    required TabController controller,
    required bool notify,
  }){

    if (_tabBarController != controller) {
      _tabBarController = controller;

      if (notify == true) {
        notifyListeners();
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// CURRENT TAB

  // --------------------
  BldrsTab _currentTab = BldrsTab.home;
  BldrsTab get currentTab => _currentTab;
  // --------------------
  /// TASK : TEST ME
  static void proSetCurrentTab({
    required BuildContext context,
    required BldrsTab tab,
    required bool notify,
  }) {
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: false);
    _pro._setCurrentTab(
      tab: tab,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCurrentTab({
    required BldrsTab tab,
    required bool notify,
  }){

    if (_currentTab != tab) {
      _currentTab = tab;

      if (notify == true) {
        notifyListeners();
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// HOME GRID

  // --------------------
  PaginationController? _homePaginationController;
  ZGridController? _homeGridController;
  // --------------------
  void _initializeHomeGrid({
    required TickerProvider vsync,
    required bool mounted,
  }){


    _homePaginationController ??= PaginationController.initialize(
      mounted: mounted,
      addExtraMapsAtEnd: true,
    );

    _homeGridController ??= ZGridController.initialize(
      vsync: vsync,
      scrollController: _homePaginationController?.scrollController,
    );

  }
  // --------------------
  void _disposeHomeGrid(){
    _homePaginationController?.dispose();
    _homePaginationController = null;
    _homeGridController?.dispose();
    _homeGridController = null;
  }
  // --------------------
  static void proInitializeHomeGrid({
    required TickerProvider vsync,
    required bool mounted,
  }){
    final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
    _pro._initializeHomeGrid(
      mounted: mounted,
      vsync: vsync,
    );
  }
  // --------------------
  static void proDisposeHomeGrid(){
    final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
    _pro._disposeHomeGrid();
  }
  // --------------------
  static PaginationController? proGetHomePaginationController({
    required BuildContext context,
    required bool listen,
  }){
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: listen);
    return _pro._homePaginationController;
  }
  // --------------------
  static ZGridController? proGetHomeZGridController({
    required BuildContext context,
    required bool listen,
  }){
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: listen);
    return _pro._homeGridController;
  }
  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
