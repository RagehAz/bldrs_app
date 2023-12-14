import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/b_light_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/future_model_builders/flyer_builder.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlyersZGrid extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersZGrid({
    required this.gridHeight,
    required this.gridWidth,
    required this.flyersIDs,
    required this.hasResponsiveSideMargin,
    this.scrollController,
    this.columnCount = 3,
    this.bottomPaddingOnZoomedOut,
    this.showAddFlyerButton = false,
    this.onSelectFlyer,
    this.onFlyerNotFound,
    this.selectionMode = false,
    this.onFlyerOptionsTap,
    this.topPadding,
    this.zGridController,
    this.flyers,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ScrollController? scrollController;
  final double gridWidth;
  final double gridHeight;
  final int columnCount;
  final double? bottomPaddingOnZoomedOut;
  final List<String>? flyersIDs;
  final List<FlyerModel>? flyers;
  final bool showAddFlyerButton;
  final Function(FlyerModel flyerModel)? onSelectFlyer;
  final Function(String flyerID)? onFlyerNotFound;
  final bool selectionMode;
  final Function(FlyerModel flyerModel)? onFlyerOptionsTap;
  final double? topPadding;
  final ZGridController? zGridController;
  final bool hasResponsiveSideMargin;
  /// --------------------------------------------------------------------------
  @override
  State<FlyersZGrid> createState() => _FlyersZGridState();
  /// --------------------------------------------------------------------------
}

class _FlyersZGridState extends State<FlyersZGrid> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  late ZGridController _controller;
  ZGridScale? _gridScale;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _controller = widget.zGridController ?? ZGridController.initialize(
      vsync: this,
      scrollController: widget.scrollController, // can be null or passed from top
    );

    super.initState();
  }
  // --------------------
  /*
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {});

    }
    super.didChangeDependencies();
  }
   */
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    if (widget.zGridController == null){
      _controller.dispose();
    }
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// ON ZOOMING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onZoomInStart() async {
    blog('onZoomInStart');
    UiProvider.proSetLayoutIsVisible(
        setTo: false,
        notify: true,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onZoomInEnd() async {
    blog('onZoomInEnd');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> onZoomOutStart() async {
    blog('onZoomOutStart');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onZoomOutEnd() async {
    blog('onZoomOutEnd');

    FlyersProvider.proSetZoomedFlyer(
        context: context,
        flyerModel: null,
        notify: true
    );

    UiProvider.proSetLayoutIsVisible(
        setTo: true,
        notify: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// BAKING FLYER

  // --------------------
  FlyerModel? _bakeFlyerModel({required int flyerIndex}){

    final int _flyerIndex = widget.showAddFlyerButton == true ? flyerIndex-1 : flyerIndex;

    final FlyerModel? _flyerModel = Lister.checkCanLoop(widget.flyers) == true ?
    widget.flyers![_flyerIndex]
        :
    null;

    return _flyerModel;
  }
  // --------------------
  String? _bakeFlyerID({
    required FlyerModel? flyerModel,
    required int flyerIndex,
  }){

    final String? _flyerID = flyerModel == null ?
    widget.flyersIDs![flyerIndex]
        :
    null;

    return _flyerID;
  }
  // -----------------------------------------------------------------------------

  /// TAPPING FLYER

  // --------------------
  Future<void> _onTapFlyerToZoomIn({
    required FlyerModel? flyerModel,
    required int index,
    required ZGridScale gridScale,
  }) async {

    if (flyerModel != null) {

      final FlyerModel? _zoomedFlyer = FlyersProvider.proGetZoomedFlyer(
        listen: false,
        context: context,
      );
      if (_zoomedFlyer == null){
        FlyersProvider.proSetZoomedFlyer(
          context: context,
          flyerModel: flyerModel,
          notify: true,
        );
        await ZGridController.zoomIn(
          context: context,
          itemIndex: index,
          mounted: true,
          onZoomInStart: onZoomInStart,
          onZoomInEnd: onZoomInEnd,
          gridScale: gridScale,
          zGridController: _controller,
        );
      }

    }

  }
  // --------------------
  Function? onSelectFlyerFunction({
    required FlyerModel? flyerModel,
  }){

    if (widget.onSelectFlyer == null || flyerModel == null){
      return null;
    }

    else {
      return () => widget.onSelectFlyer!.call(flyerModel);
    }

  }
  // --------------------
  Function? onFlyerOptionsFunction({
    required FlyerModel? flyerModel,
  }){

    if (widget.onFlyerOptionsTap == null || flyerModel == null){
      return null;
    }

    else {
      return () => widget.onFlyerOptionsTap?.call(flyerModel);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    _gridScale = ZGridScale.initialize(
      gridWidth: widget.gridWidth,
      gridHeight: widget.gridHeight,
      columnCount: widget.columnCount,
      bottomPaddingOnZoomedOut: widget.bottomPaddingOnZoomedOut,
      topPaddingOnZoomOut: widget.topPadding,
      itemAspectRatio: FlyerDim.flyerAspectRatio(),
      hasResponsiveSideMargin: widget.hasResponsiveSideMargin,
    );

    if (_gridScale == null){
      return const SizedBox();
    }

    else {

      return ZGrid(
        gridScale: _gridScale!,
        blurBackgroundOnZoomedIn: true,
        controller: _controller,
        mounted: mounted,
        onZoomOutEnd: _onZoomOutEnd,
        onZoomOutStart: onZoomOutStart,
        itemCount: FlyerDim.flyerGridNumberOfSlots(
          flyersCount: widget.flyersIDs?.length ?? widget.flyers?.length ?? 0,
          addFlyerButtonIsOn: widget.showAddFlyerButton,
          isLoadingGrid: false,
          numberOfColumnsOrRows: widget.columnCount,
        ),

        /// SMALL FLYERS BUILDER
        builder: (int index) {
          // ---------------------------------------------
          /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
          if (widget.showAddFlyerButton == true && index == 0){
            return AddFlyerButton(
              flyerBoxWidth: _gridScale!.smallItemWidth,
            );
          }
          // ---------------------------------------------
          else {

            final int _flyerIndex = widget.showAddFlyerButton == true ? index-1 : index;

            final FlyerModel? _flyerModel = _bakeFlyerModel(
                flyerIndex: _flyerIndex,
            );

            final String? _flyerID = _bakeFlyerID(
              flyerModel: _flyerModel,
              flyerIndex: _flyerIndex,
            );

            final double _flyerBoxWidth = _gridScale!.smallItemWidth;

            return FlyerBuilder(
              flyerID: _flyerID,
              flyerModel: _flyerModel,
              flyerBoxWidth: _flyerBoxWidth,
              renderFlyer: RenderFlyer.firstSlide,
              onFlyerNotFound: (String? id) => widget.onFlyerNotFound?.call(id!),
              onlyFirstSlide: true,
              slidePicType: SlidePicType.small,
              builder: (bool loading, FlyerModel? flyerModel){

                /// LOADING FLYER
                if (loading == true && flyerModel == null){
                  return FlyerLoading(
                    flyerBoxWidth: _flyerBoxWidth,
                    animate: true,
                    direction: Axis.vertical,
                  );
                }

                /// SMALL FLYER
                else {

                  return FlyerSelectionStack(
                    flyerModel: flyerModel,
                    flyerBoxWidth: _flyerBoxWidth,
                    onSelectFlyer: onSelectFlyerFunction(flyerModel: flyerModel),
                    onFlyerOptionsTap: onFlyerOptionsFunction(flyerModel: flyerModel),
                    selectionMode: widget.selectionMode,
                    /// When selectionMode is false, the flyerWidget below is wrapped in IgnorePointer
                    flyerWidget: SmallFlyer(
                      showTopButton: true,
                      flyerModel: flyerModel,
                      flyerBoxWidth: _gridScale!.smallItemWidth,
                      optionsButtonIsOn: widget.onFlyerOptionsTap != null,
                      onTap: () => _onTapFlyerToZoomIn(
                        flyerModel: flyerModel,
                        index: index,
                        gridScale: _gridScale!,
                      ),
                    ),
                  );

                }

              },
            );

          }
        },

        /// BIG FLYER FOOTPRINT
        bigItemFootprint: FlyerBox(
          flyerBoxWidth: _gridScale!.bigItemWidth,
          boxColor: Colorz.black255,
        ),

        /// BIG FLYER
        bigItem: Selector<FlyersProvider, FlyerModel?>(
          selector: (_, FlyersProvider flyersProvider) => flyersProvider.zoomedFlyer,
          builder: (_, FlyerModel? flyerModel, Widget? child) {

            return LightBigFlyer(
              flyerBoxWidth: _gridScale!.bigItemWidth,
              renderedFlyer: flyerModel!,
              // showGallerySlide: true,
              onHorizontalExit: () async {
                // await zoomOutFlyer(
                //   mounted: mounted,
                //   controller: _controller,
                //   flyerNotifier: _zoomedFlyer,
                // );
              },
              onVerticalExit: () async {
                blog('this works only in the gallery slide max bounce');
                // await zoomOutFlyer(
                //   mounted: mounted,
                //   controller: _controller,
                //   context: context,
                // );
                },
            );

            },
        ),

      );

    }

  }
  // -----------------------------------------------------------------------------
}

Future<void> zoomOutFlyer({
  required BuildContext context,
  required bool mounted,
  required ZGridController? controller,
}) async {

  if (controller != null) {
    if (Mapper.boolIsTrue(controller.isZoomed.value) == true) {
      await ZGridController.zoomOut(
        mounted: mounted,
        zGridController: controller,
        onZoomOutStart: () {},
        onZoomOutEnd: () async {

          FlyersProvider.proSetZoomedFlyer(
              context: context,
              flyerModel: null,
              notify: true,
          );

          UiProvider.proSetLayoutIsVisible(
            setTo: true,
            notify: true,
          );

        },
      );
    }
  }

}
