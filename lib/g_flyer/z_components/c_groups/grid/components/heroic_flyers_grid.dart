import 'package:basics/components/animators/widget_fader.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/components/flyers_grid_builder.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/g_flyer/z_components/d_variants/missing_flyer.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:flutter/material.dart';

class HeroicFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeroicFlyersGrid({
    required this.screenName,
    required this.gridWidth,
    required this.gridHeight,
    required this.scrollController,
    required this.flyers,
    required this.flyersIDs,
    required this.topPadding,
    required this.numberOfColumnsOrRows,
    required this.showAddFlyerButton,
    required this.onFlyerOptionsTap,
    required this.onSelectFlyer,
    required this.scrollDirection,
    required this.onMissingFlyerTap,
    required this.scrollable,
    required this.selectionMode,
    required this.bottomPadding,
    required this.hasResponsiveSideMargin,
    super.key
  });
  /// --------------------------------------------------------------------------
  final List<FlyerModel>? flyers;
  final List<String>? flyersIDs;
  final double gridWidth;
  final double gridHeight;
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
  final Function(String? flyerID)? onMissingFlyerTap;
  final double? bottomPadding;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    // final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
    //   context: context,
    //   scrollDirection: scrollDirection,
    //   numberOfColumnsOrRows: numberOfColumnsOrRows,
    //   gridHeight: gridHeight,
    //   gridWidth: gridWidth,
    //   hasResponsiveSideMargin: hasResponsiveSideMargin,
    // );

    final ZGridScale _gridScale = ZGridScale.initialize(
      context: context,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      columnCount: numberOfColumnsOrRows,
      bottomPaddingOnZoomedOut: bottomPadding,
      topPaddingOnZoomOut: topPadding,
      itemAspectRatio: FlyerDim.flyerAspectRatio(),
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );

    // --------------------
    return FlyersGridBuilder(
        gridWidth: _gridScale.gridWidth,
        gridHeight: _gridScale.gridHeight,
        scrollController: scrollController,
        scrollable: scrollable,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
        numberOfColumnsOrRows: _gridScale.columnCount,
        scrollDirection: scrollDirection,
        hasResponsiveSideMargin: _gridScale.hasResponsiveSideMargin,
        itemCount: FlyerDim.flyerGridNumberOfSlots(
          flyersCount: flyersIDs?.length ?? flyers?.length ?? 0,
          addFlyerButtonIsOn: showAddFlyerButton,
          isLoadingGrid: false,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
        ),
        builder: (BuildContext ctx, int index){
          // ---------------------------------------------
          /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
          if (showAddFlyerButton == true && index == 0){
            return AddFlyerButton(
              flyerBoxWidth: _gridScale.smallItemWidth,
            );
          }
          // ---------------------------------------------
          /// OTHERWISE
          else {

            final int _flyerIndex = showAddFlyerButton == true ? index-1 : index;
            final String? _flyerID = (flyersIDs?.length ?? 0) == 0 ? null : flyersIDs![_flyerIndex];
            final FlyerModel? _flyer = (flyers?.length ?? 0) == 0 ? null : flyers![_flyerIndex];
            final String _heroPath = '$screenName/$_flyerID/';

            /// NEW
            return FlyerBuilder(
              key: const ValueKey<String>('FlyerBuilder_inGrid'),
              flyerID: _flyerID,
              flyerModel: _flyer,
              renderFlyer: RenderFlyer.firstSlide,
              onlyFirstSlide: true,
              slidePicType: SlidePicType.small,
              builder: (bool loading, FlyerModel? smallFlyer) {

                if (loading == true && smallFlyer == null){
                  return FlyerLoading(
                    flyerBoxWidth: _gridScale.smallItemWidth,
                    animate: true,
                    direction: Axis.vertical,
                  );
                }

                /// NOT FOUND FLYER
                else if (loading == false && smallFlyer == null){
                  return MissingFlyer(
                    flyerBoxWidth: _gridScale.smallItemWidth,
                    flyerID: _flyerID ?? _flyer?.id,
                    onTap: onMissingFlyerTap,
                  );
                }

                else {
                  return WidgetFader(
                    fadeType: FadeType.fadeIn,
                    duration: const Duration(milliseconds: 300),
                    child: FlyerSelectionStack(
                      flyerModel: smallFlyer,
                      flyerBoxWidth: _gridScale.smallItemWidth,
                      onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer!(smallFlyer!),
                      onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap!(smallFlyer!),
                      selectionMode: selectionMode,
                      flyerWidget: FlyerHero(
                        renderedFlyer: smallFlyer,
                        canBuildBigFlyer: false,
                        flyerBoxWidth: _gridScale.smallItemWidth,
                        heroPath: _heroPath,
                        invoker: 'Flyer',
                        gridWidth: gridWidth,
                        gridHeight: gridHeight,
                      ),
                    ),
                  );
                }

              }

            );

          }
          // ---------------------------------------------
        }
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
