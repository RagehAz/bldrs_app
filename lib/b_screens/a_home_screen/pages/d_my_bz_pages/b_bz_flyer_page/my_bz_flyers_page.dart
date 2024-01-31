import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/d_my_bz_pages/b_bz_flyer_page/bz_flyers_page_controllers.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/h_navigation/mirage/mirage.dart';
import 'package:flutter/material.dart';

class MyBzFlyersPage extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MyBzFlyersPage({
    super.key
  });
  // --------------------
  ///
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BzModel? _myActiveBz = HomeProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );
    // --------------------
    final String? _activePhid = HomeProvider.proGetMyBzFlyersActivePhid(
      context: context,
      listen: true,
    );
    // --------------------
    return FlyersGrid(
      key: const ValueKey<String>('BzFlyersPage_grid'),
      screenName: 'bzFlyersPage',
      flyersIDs: ScopeModel.getBzFlyersIDs(
        bzModel: _myActiveBz,
        activePhid: _activePhid,
        onlyShowPublished: false,
      ),
      gridWidth: Scale.screenWidth(context),
      gridHeight: Scale.screenHeight(context),
      numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 2,
      bottomPadding: MirageModel.getBzMirageBottomInsetsValueForBzFlyers(context),
      topPadding: Ratioz.appBarMargin,
      showAddFlyerButton: true,
      onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerBzOptionsTap(
        flyer: flyerModel,
      ),
      onFlyerNotFound: (String flyerID){
        blog('BzFlyersPage : flyer is not found ($flyerID)');
      },
      gridType: FlyerGridType.zoomable,
      hasResponsiveSideMargin: true,
    );

  }
// -----------------------------------------------------------------------------
}

// class MyBzFlyersPageOld extends StatefulWidget {
//   // --------------------------------------------------------------------------
//   const MyBzFlyersPageOld({
//     super.key
//   });
//   // --------------------
//   ///
//   // --------------------
//   @override
//   _MyBzFlyersPageOldState createState() => _MyBzFlyersPageOldState();
//   // --------------------------------------------------------------------------
// }
//
// class _MyBzFlyersPageOldState extends State<MyBzFlyersPageOld> with SingleTickerProviderStateMixin{
//   // -----------------------------------------------------------------------------
//   late ZGridController _zGridController;
//   final ScrollController _scrollController = ScrollController();
//   final ValueNotifier<String?> _activePhid = ValueNotifier(null);
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _zGridController = ZGridController.initialize(
//       vsync: this,
//       scrollController: _scrollController,
//     );
//
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(TheStatefulScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.thing != widget.thing) {
//       unawaited(_doStuff());
//     }
//   }
//    */
//   // --------------------
//   @override
//   void dispose() {
//     /// SCROLL_CONTROLLER_IS_DISPOSED_IN_ZOOMABLE_GRID_CONTROLLER
//     // _scrollController.dispose(); // so do not dispose here, kept for reference
//     _zGridController.dispose();
//     _activePhid.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final BzModel? _myActiveBz = HomeProvider.proGetActiveBzModel(
//         context: context,
//         listen: true,
//     );
//     // --------------------
//     return BzFlyersView(
//       bzModel: _myActiveBz,
//       activePhid: _activePhid,
//       mounted: mounted,
//       scrollController: _scrollController,
//       zGridController: _zGridController,
//       onlyShowPublished: true,
//       showAddFlyerButton: true,
//       appBarType: AppBarType.non,
//       onFlyerOptionsTap: (FlyerModel flyerModel) => onFlyerBzOptionsTap(
//         flyer: flyerModel,
//       ),
//     );
//     // --------------------
//   }
//   // -----------------------------------------------------------------------------
// }
