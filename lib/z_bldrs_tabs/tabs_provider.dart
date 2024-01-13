import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/z_bldrs_tabs/bldrs_tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
/// => TAMAM
// final TabsProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
class TabsProvider extends ChangeNotifier {
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
    final TabsProvider _uiProvider = Provider.of<TabsProvider>(context, listen: false);
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

    _tabBarController!.addListener(() {

      // TabsProvider.proSetCurrentTab(
      //   context: context,
      //   tab: BldrsTab.home,
      //   notify: true,
      // );

    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proDisposeTabBarController(){
    final TabsProvider _uiProvider = Provider.of<TabsProvider>(getMainContext(), listen: false);
    _uiProvider._tabBarController?.dispose();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TabController? proGetTabController({
    required BuildContext context,
    required bool listen,
  }){
    final TabsProvider _uiProvider = Provider.of<TabsProvider>(context, listen: listen);
    return _uiProvider.tabBarController;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetTabBarController({
    required BuildContext context,
    required TabController controller,
    required bool notify,
  }) {
    final TabsProvider _uiProvider = Provider.of<TabsProvider>(context, listen: false);
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
    final TabsProvider _uiProvider = Provider.of<TabsProvider>(context, listen: false);
    _uiProvider.setCurrentTab(
      tab: tab,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentTab({
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
}
// -----------------------------------------------------------------------------
