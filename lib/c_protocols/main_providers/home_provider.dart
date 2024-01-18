import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/tabbing/bldrs_tabs.dart';
import 'package:bldrs/z_components/layouts/mirage/mirage.dart';
import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
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
      length: BldrsTabber.allTabs.length,
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

  /// MIRAGES

  // --------------------
  List<MirageModel> _mirages = [];
  List<MirageModel> get mirages => _mirages;
  // --------------------
  static List<MirageModel> proGetMirages({
    required BuildContext context,
    required bool listen,
  }){
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: listen);
    return _pro.mirages;
  }
  // --------------------
  static MirageModel proGetMirageByIndex({
    required BuildContext context,
    required bool listen,
    required int index,
  }){
    final List<MirageModel> _mirages = proGetMirages(context: context, listen: listen);
    return _mirages[index];
  }
  // --------------------
  static void proInitializeMirages(){
    final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
    final MirageModel _mirageX0 = MirageModel.initialize(index: 0,height: Pyramids.khafreHeight * 1.1, controlPyramid: true);
    final MirageModel _mirageX1 = MirageModel.initialize(index: 1,height: Pyramids.khafreHeight * 2.2);
    final MirageModel _mirageX2 = MirageModel.initialize(index: 2,height: Pyramids.khafreHeight * 3.3);
    final MirageModel _mirageX3 = MirageModel.initialize(index: 3,height: Pyramids.khafreHeight * 4.4);
    final MirageModel _mirageX4 = MirageModel.initialize(index: 4,height: Pyramids.khafreHeight * 5.5);
    _pro._mirages = [_mirageX0, _mirageX1, _mirageX2, _mirageX3, _mirageX4];
  }
  // --------------------
  static void proDisposeMirages(){
    final HomeProvider _pro = Provider.of<HomeProvider>(getMainContext(), listen: false);
    MirageModel.disposeMirages(
      models: _pro.mirages,
    );
  }
  // --------------------
  static void proSelectMirageButton({
    required int mirageIndex,
    required bool mounted,
    required String button,
  }){

    final MirageModel _mirage = proGetMirageByIndex(
        context: getMainContext(),
        listen: false,
        index: mirageIndex,
    );

    _mirage.selectButton(
      button: button,
      mounted: mounted,
    );

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

  /// MY ACTIVE BZ

  // --------------------
  BzModel? _myActiveBz;
  BzModel? get myActiveBz => _myActiveBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel? proGetActiveBzModel({
    required BuildContext context,
    required bool listen,
  }) {
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: listen,);
    return _pro.myActiveBz;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetActiveBzByID({
    required String? bzID,
    required BuildContext context,
    required bool notify,
  }) async {

    if (TextCheck.isEmpty(bzID) == false){

      final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(context: context, listen: false);

      if (Stringer.checkStringsContainString(strings: _myBzzIDs, string: bzID) == true){

        final BzModel? _bzModel = await BzProtocols.fetchBz(bzID: bzID);

        proSetActiveBzModel(
          notify: notify,
          context: context,
          bzModel: _bzModel,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proSetActiveBzModel({
    required BzModel? bzModel,
    required BuildContext context,
    required bool notify,
  }) {
    final HomeProvider _pro = Provider.of<HomeProvider>(context, listen: false);
    _pro._setActiveBz(
      bzModel: bzModel,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setActiveBz({
    required BzModel? bzModel,
    required bool notify,
  }) {

    if (_myActiveBz != bzModel){
      _myActiveBz = bzModel;
      if (notify == true){
        notifyListeners();
      }
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void proClearActiveBz({
    required bool notify,
  }){
    proSetActiveBzModel(
      context: getMainContext(),
      bzModel: null,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
