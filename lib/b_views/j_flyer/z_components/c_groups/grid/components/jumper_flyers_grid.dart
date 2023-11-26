import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_grid_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:flutter/material.dart';

class JumpingFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const JumpingFlyersGrid({
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
    required this.onFlyerNotFound,
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
  final Function(String flyerID)? onFlyerNotFound;
  final double? bottomPadding;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: scrollDirection,
      numberOfColumnsOrRows: numberOfColumnsOrRows,
      gridHeight: gridHeight,
      gridWidth: gridWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    // --------------------
    return FlyersGridBuilder(
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        scrollController: scrollController,
        scrollable: scrollable,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
        numberOfColumnsOrRows: numberOfColumnsOrRows,
        scrollDirection: scrollDirection,
        hasResponsiveSideMargin: hasResponsiveSideMargin,
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
              flyerBoxWidth: _gridSlotWidth,
            );
          }
          // ---------------------------------------------
          /// OTHERWISE
          else {

            final int _flyerIndex = showAddFlyerButton == true ? index-1 : index;
            final String? _flyerID = (flyersIDs?.length ?? 0) == 0 ? null : flyersIDs![_flyerIndex];
            final FlyerModel? _flyer = (flyers?.length ?? 0) == 0 ? null : flyers![_flyerIndex];

            return FlyerBuilder(
              key: const ValueKey<String>('FlyerBuilder_inGrid'),
              flyerID: _flyerID,
              flyerModel: _flyer,
              flyerBoxWidth: _gridSlotWidth,
              onFlyerNotFound: onFlyerNotFound == null || _flyerID == null ?
              null : (String? flyerID) => onFlyerNotFound?.call(_flyerID),
              renderFlyer: RenderFlyer.firstSlide,
              slidePicType: SlidePicType.small,
              onlyFirstSlide: true,
              builder: (bool loading, FlyerModel? smallFlyer) {

                if (loading == true && smallFlyer == null){
                  return FlyerLoading(
                    flyerBoxWidth: _gridSlotWidth,
                    animate: true,
                    direction: Axis.vertical,
                  );
                }
                else {

                  return FlyerSelectionStack(
                    flyerModel: smallFlyer,
                    flyerBoxWidth: _gridSlotWidth,
                    onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer?.call(smallFlyer!),
                    onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap?.call(smallFlyer!),
                    selectionMode: selectionMode,
                    flyerWidget: SmallFlyer(
                      flyerBoxWidth: _gridSlotWidth,
                      flyerModel: smallFlyer,
                      showTopButton: true,
                      canUseFilter: false,
                      // canAnimateMatrix: true,
                      // flyerShadowIsOn: true,
                      // isRendering: false,
                      // optionsButtonIsOn: false,
                      // slideIndex: 0,
                      // slideShadowIsOn: true,
                      onTap: () async {

                        await BldrsNav.goToNewScreen(
                          pageTransitionType: PageTransitionType.bottomToTop,
                          screen: FlyerPreviewScreen(
                            flyerID: null,
                            flyerModel: smallFlyer,
                          ),
                        );

                      },
                    ),
                  );

                }


              },

            );

          }
          // ---------------------------------------------
        }
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
