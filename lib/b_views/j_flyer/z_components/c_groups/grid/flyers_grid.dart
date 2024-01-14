import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/heroic_flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/jumper_flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/loading_flyers_grid.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

enum FlyerGridType {
  zoomable,
  heroic,
  jumper,
  loading,
}

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    required this.screenName,
    required this.gridType,
    required this.hasResponsiveSideMargin,
    required this.numberOfColumnsOrRows,
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.flyers,
    this.flyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.showAddFlyerButton = false,
    this.onFlyerOptionsTap,
    this.onSelectFlyer,
    this.scrollDirection = Axis.vertical,
    this.onFlyerNotFound,
    this.scrollable = true,
    this.selectionMode = false,
    this.bottomPadding,
    this.zGridController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerGridType gridType;
  final List<FlyerModel>? flyers;
  final List<String>? flyersIDs;
  final double? gridWidth;
  final double? gridHeight;
  final ScrollController? scrollController;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final String screenName;
  final bool showAddFlyerButton;
  final Axis scrollDirection;
  final bool scrollable;
  final bool selectionMode;
  final Function(FlyerModel flyerModel)? onFlyerOptionsTap;
  final Function(FlyerModel flyerModel)? onSelectFlyer;
  final Function(String flyerID)? onFlyerNotFound;
  final double? bottomPadding;
  final ZGridController? zGridController;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool showLoadingGridInstead({
    required bool isLoadingGrid,
    required List<FlyerModel>? flyers,
    required List<String>? paginationFlyersIDs,
  }){
    bool _showLoadingGrid = true;

    if (isLoadingGrid == false){
      if (flyers != null || paginationFlyersIDs != null){
        _showLoadingGrid = false;
      }
    }

    return _showLoadingGrid;
  }
  // --------------------
  void assertGivenFlyersAreGood(){

    final bool _isLoadingGrid = gridType == FlyerGridType.loading;

    assert((){
        final bool _canBuild =
                flyers != null
                ||
                flyersIDs != null
                ||
                _isLoadingGrid == true;

        if (_canBuild == false){
          throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
        }

        return _canBuild;
      }(), 'You either give me (List<FlyerModel> flyers) or '
          '(List<String> flyersIDs) or '
          'switch on (isLoadingGrid) but '
          'never leave me like this empty handed with nulls & nulls');

  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------------
    final bool _isLoadingGrid = gridType == FlyerGridType.loading;
    final bool _isHeroicGrid = gridType == FlyerGridType.heroic;
    final bool _isJumpingGrid = gridType == FlyerGridType.jumper;
    // -----------------------------------------------------------------------------
    /// NOTHING TO SHOW
    if (flyers == null && flyersIDs == null && _isLoadingGrid == false){
      return const SizedBox();
    }

    /// SHOW GRID
    else {
      // --------------------
      assertGivenFlyersAreGood();
      // --------------------
      final bool _showLoadingGrid = showLoadingGridInstead(
        flyers : flyers,
        paginationFlyersIDs: flyersIDs,
        isLoadingGrid: _isLoadingGrid,
      );
      // --------------------
      /// LOADING GRID
      if (_showLoadingGrid == true) {
        return LoadingFlyersGrid(
          hasResponsiveSideMargin: hasResponsiveSideMargin,
          gridWidth: gridWidth ?? MediaQuery.of(context).size.width,
          gridHeight: gridHeight ?? MediaQuery.of(context).size.height,
          scrollController: scrollController,
          topPadding: topPadding,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
          scrollDirection: scrollDirection,
          scrollable: scrollable,
        );
      }
      // --------------------
      /// HEROIC FLYERS GRID
      else if (_isHeroicGrid == true){
        // --------------------
        return HeroicFlyersGrid(
          hasResponsiveSideMargin: hasResponsiveSideMargin,
          gridWidth: gridWidth ?? MediaQuery.of(context).size.width,
          gridHeight: gridHeight ?? MediaQuery.of(context).size.height,
          scrollController: scrollController,
          scrollable: scrollable,
          topPadding: topPadding,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
          scrollDirection: scrollDirection,
          screenName: screenName,
          flyers: flyers,
          flyersIDs: flyersIDs,
          selectionMode: selectionMode,
          onFlyerNotFound: onFlyerNotFound,
          onFlyerOptionsTap: onFlyerOptionsTap,
          onSelectFlyer: onSelectFlyer,
          showAddFlyerButton: showAddFlyerButton,
          bottomPadding: bottomPadding,
        );
        // --------------------

      }
      // --------------------
      /// JUMPING FLYERS GRID
      else if (_isJumpingGrid == true){
        return JumpingFlyersGrid(
          hasResponsiveSideMargin: hasResponsiveSideMargin,
          gridWidth: gridWidth ?? MediaQuery.of(context).size.width,
          gridHeight: gridHeight ?? MediaQuery.of(context).size.height,
          scrollController: scrollController,
          scrollable: scrollable,
          topPadding: topPadding,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
          scrollDirection: scrollDirection,
          screenName: screenName,
          flyers: flyers,
          flyersIDs: flyersIDs,
          selectionMode: selectionMode,
          onFlyerNotFound: onFlyerNotFound,
          onFlyerOptionsTap: onFlyerOptionsTap,
          onSelectFlyer: onSelectFlyer,
          showAddFlyerButton: showAddFlyerButton,
          bottomPadding: bottomPadding,
        );
      }
      // --------------------
      /// ZOOMABLE FLYERS GRID
      else {
        return FlyersZGrid(
          hasResponsiveSideMargin: hasResponsiveSideMargin,
          gridWidth: gridWidth ?? MediaQuery.of(context).size.width,
          gridHeight: gridHeight ?? MediaQuery.of(context).size.height,
          flyersIDs: Lister.checkCanLoop(flyers) == false ? flyersIDs : null,
          flyers: flyers,
          columnCount: numberOfColumnsOrRows,
          onFlyerNotFound: onFlyerNotFound,
          showAddFlyerButton: showAddFlyerButton,
          onSelectFlyer: onSelectFlyer,
          selectionMode: selectionMode,
          onFlyerOptionsTap: onFlyerOptionsTap,
          scrollController: scrollController,
          topPadding: topPadding,
          bottomPaddingOnZoomedOut: bottomPadding,
          zGridController: zGridController,
        );
      }
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------
}
