import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
// import 'package:basics/ldb/ldb_viewer/ldb_viewer_screen.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/c_user_pages/b_my_saves_page/saves_screen_controllers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    this.appBarType = AppBarType.basic,
    super.key
  });
  /// --------------------
  final bool selectionMode;
  final AppBarType appBarType;
  /// --------------------
  @override
  _SavedFlyersScreenState createState() => _SavedFlyersScreenState();
  /// --------------------
  static Future<FlyerModel?> pickFlyer() async {

    final List<FlyerModel>? _selectedFlyers = await BldrsNav.goToNewScreen(
      screen: const SavedFlyersScreen(
        selectionMode: true,
      ),
    );

    if (Lister.checkCanLoop(_selectedFlyers) == true){
      return _selectedFlyers!.first;
    }
    else {
      return null;
    }

  }
  /// --------------------
  static Future<List<FlyerModel>> pickFlyers() async {

    final List<FlyerModel>? _selectedFlyers = await BldrsNav.goToNewScreen(
      screen: const SavedFlyersScreen(
        selectionMode: true,
      ),
    );

    return _selectedFlyers ?? [];

  }
  /// --------------------------------------------------------------------------
}

class _SavedFlyersScreenState extends State<SavedFlyersScreen> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  /*
   with AutomaticKeepAliveClientMixin<SavedFlyersScreen>
   @override
   bool get wantKeepAlive => true;
   */
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  late ZGridController _zGridController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _zGridController = ZGridController.initialize(
      vsync: this,
      scrollController: _scrollController,
    );
    super.initState();
  }
  // --------------------
  @override
  void dispose() {
    /// SCROLL_CONTROLLER_IS_DISPOSED_IN_ZOOMABLE_GRID_CONTROLLER
    // _scrollController.dispose(); // so do not dispose here, kept for reference
    _zGridController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onBack() async {

    final bool _flyerIsOpen = UiProvider.proGetLayoutIsVisible(
      context: getMainContext(),
      listen: false,
    );

    /// CLOSE FLYER
    if (_flyerIsOpen == false) {
      await zoomOutFlyer(
        context: context,
        mounted: true,
        controller: _zGridController,
      );
    }

    else if (widget.selectionMode == true) {
      /// shall pass selected flyers through flyers provider
      await Nav.goBack(
        context: context,
        invoker: '_passSelectedFlyersBack',
        passedData: Provider.of<FlyersProvider>(getMainContext(), listen: false).selectedFlyers,
      );
    }

    else {
      await Nav.goBack(
        context: context,
        invoker: '_onBack',
      );
    }

  }
  // --------------------
  Future<void> _onMissingFlyerTap(String? flyerID) async {

    if (flyerID != null){

      final bool _go = await Dialogs.confirmProceed(
        titleVerse: getVerse('phid_delete_flyer'),
        yesVerse: getVerse('phid_delete'),
        noVerse: getVerse('phid_cancel'),
      );

      if (_go == true){

        await removeMissingSavedFlyer(
          flyerID: flyerID,
        );

      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// super.build(context);
    // --------------------
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    // --------------------
    return MainLayout(
      canSwipeBack: widget.appBarType != AppBarType.non,
      canGoBack: widget.appBarType != AppBarType.non,
      appBarType: widget.appBarType,
      title: const Verse(
        id: 'phid_savedFlyers',
        translate: true,
      ),
      onBack: _onBack,
      listenToHideLayout: true,
      child: FlyersGrid(
        screenName: 'SavedFlyersGrid',
        scrollController: _scrollController,
        selectionMode: widget.selectionMode,
        onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
          flyer: flyer,
        ),
        flyersIDs: _userModel?.savedFlyers?.all,
        onMissingFlyerTap: _onMissingFlyerTap,
        numberOfColumnsOrRows: Scale.isLandScape(getMainContext()) == true ? 4 : 3,
        gridType: FlyerGridType.zoomable,
        gridHeight: Scale.screenHeight(getMainContext()),
        gridWidth: Scale.screenWidth(getMainContext()),
        zGridController: _zGridController,
        bottomPadding: MirageModel.mirageInsets2.bottom,
        topPadding: widget.appBarType == AppBarType.non ? Ratioz.appBarMargin : Ratioz.stratosphere,
        hasResponsiveSideMargin: true,
        // showAddFlyerButton: false,
        // scrollDirection: Axis.vertical,
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
