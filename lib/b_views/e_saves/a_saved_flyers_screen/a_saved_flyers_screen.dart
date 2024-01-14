import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/x_saves_screen_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreen({
    this.selectionMode = false,
    super.key
  });
  /// --------------------
  final bool selectionMode;
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// super.build(context);
    // --------------------
    DynamicRouter.blogGo('SavedFlyersScreen');
    // --------------------
    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      skyType: SkyType.grey,
      pyramidsAreOn: true,
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
        onFlyerNotFound: (String flyerID) => autoRemoveSavedFlyerThatIsNotFound(
          flyerID: flyerID,
        ),
        numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 3,
        gridType: FlyerGridType.zoomable,
        gridHeight: Scale.screenHeight(context),
        gridWidth: Scale.screenWidth(context),
        zGridController: _zGridController,
        bottomPadding: Ratioz.horizon,
        hasResponsiveSideMargin: true,
        // showAddFlyerButton: false,
        // scrollDirection: Axis.vertical,
      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
