import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/heroic_flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/loading_flyers_grid.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.screenName,
    @required this.isHeroicGrid,
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.flyers,
    this.flyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.showAddFlyerButton = false,
    this.onFlyerOptionsTap,
    this.onSelectFlyer,
    this.scrollDirection = Axis.vertical,
    this.isLoadingGrid = false,
    this.onFlyerNotFound,
    this.scrollable = true,
    this.selectionMode = false,
    this.bottomPadding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isHeroicGrid;
  final List<FlyerModel> flyers;
  final List<String> flyersIDs;
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final String screenName;
  final bool showAddFlyerButton;
  final Axis scrollDirection;
  final bool isLoadingGrid;
  final bool scrollable;
  final bool selectionMode;
  final Function(FlyerModel flyerModel) onFlyerOptionsTap;
  final Function(FlyerModel flyerModel) onSelectFlyer;
  final Function(String flyerID) onFlyerNotFound;
  final double bottomPadding;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool showLoadingGridInstead({
    @required bool isLoadingGrid,
    @required List<FlyerModel> flyers,
    @required List<String> paginationFlyersIDs,
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
  @override
  Widget build(BuildContext context) {
    // -----------------------------------------------------------------------------
    /// NOTHING TO SHOW
    if (flyers == null && flyersIDs == null && isLoadingGrid == false){
      return const SizedBox();
    }

    /// SHOW GRID
    else {
      // --------------------
      assert((){
        final bool _canBuild =
                flyers != null
                ||
                flyersIDs != null
                ||
                isLoadingGrid == true;

        if (_canBuild == false){
          throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
        }

        return _canBuild;
      }(), 'You either give me (List<FlyerModel> flyers) or '
          '(List<String> flyersIDs) or '
          'switch on (isLoadingGrid) but '
          'never leave me like this empty handed with nulls & nulls');
      // --------------------
      final bool _isLoadingGrid = showLoadingGridInstead(
        flyers : flyers,
        paginationFlyersIDs: flyersIDs,
        isLoadingGrid: isLoadingGrid,
      );
      // --------------------
      final bool _isHeroicGrid = scrollDirection == Axis.horizontal || isHeroicGrid == true;
      // --------------------
      /// LOADING GRID
      if (_isLoadingGrid == true) {
        return LoadingFlyersGrid(
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
          gridWidth: gridWidth,
          gridHeight: gridHeight,
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
      /// ZOOMABLE FLYERS GRID
      else {

        return FlyersZGrid(
          gridWidth: gridWidth,
          gridHeight: gridHeight,
          flyersIDs: flyersIDs ?? FlyerModel.getFlyersIDsFromFlyers(flyers),
          columnCount: numberOfColumnsOrRows,
          onFlyerNotFound: onFlyerNotFound,
          showAddFlyerButton: showAddFlyerButton,
          onSelectFlyer: onSelectFlyer,
          selectionMode: selectionMode,
          onFlyerOptionsTap: onFlyerOptionsTap,
          scrollController: scrollController,
          topPadding: topPadding,
          bottomPaddingOnZoomedOut: bottomPadding,
        );

      }
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------
}
