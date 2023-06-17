import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/b_light_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/z_grid/z_grid.dart';

class FlyersZGrid extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const FlyersZGrid({
    @required this.gridHeight,
    @required this.gridWidth,
    @required this.flyersIDs,
    this.scrollController,
    this.columnCount = 3,
    this.bottomPaddingOnZoomedOut,
    this.showAddFlyerButton = false,
    this.onSelectFlyer,
    this.onFlyerNotFound,
    this.selectionMode,
    this.onFlyerOptionsTap,
    this.topPadding,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ScrollController scrollController;
  final double gridWidth;
  final double gridHeight;
  final int columnCount;
  final double bottomPaddingOnZoomedOut;
  final List<String> flyersIDs;
  final bool showAddFlyerButton;
  final Function(FlyerModel flyerModel) onSelectFlyer;
  final Function(String flyerID) onFlyerNotFound;
  final bool selectionMode;
  final Function(FlyerModel flyerModel) onFlyerOptionsTap;
  final double topPadding;
  /// --------------------------------------------------------------------------
  @override
  State<FlyersZGrid> createState() => _FlyersZGridState();
  /// --------------------------------------------------------------------------
}

class _FlyersZGridState extends State<FlyersZGrid> with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  final ValueNotifier<FlyerModel> _zoomedFlyer = ValueNotifier(null);
  ZGridController _controller;
  // -----------------------------------------------------------------------------
  @override
  void initState() {

    _controller = ZGridController.initialize(
      vsync: this,
      scrollController: widget.scrollController, // can be null or passed from top
    );

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      asyncInSync(() async {

      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
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
    _controller.dispose();
    _zoomedFlyer.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
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
  Future<void> onZoomOutEnd() async {
    blog('onZoomOutEnd');

    setNotifier(
      notifier: _zoomedFlyer,
      mounted: mounted,
      value: null,
    );

    UiProvider.proSetLayoutIsVisible(
        setTo: true,
        notify: true,
    );

  }
  // -----------------------------------------------------------------------------
  Future<void> _onFlyerTap({
    @required FlyerModel flyerModel,
    @required int index,
    @required ZGridScale gridScale,
  }) async {

    if (flyerModel != null) {

      if (widget.onSelectFlyer != null && widget.selectionMode == true) {
        widget.onSelectFlyer(flyerModel);
      }

      else {

        setNotifier(
          notifier: _zoomedFlyer,
          mounted: mounted,
          value: flyerModel,
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double gridSidePadding = 10;

    final ZGridScale _gridScale = ZGridScale.initialize(
      gridWidth: widget.gridWidth,
      gridHeight: widget.gridHeight,
      columnCount: widget.columnCount,
      gridSidePadding: gridSidePadding,
      bottomPaddingOnZoomedOut: widget.bottomPaddingOnZoomedOut,
      topPaddingOnZoomOut: widget.topPadding,
      itemAspectRatio: FlyerDim.flyerAspectRatio(
        forceMaxHeight: false,
      ),
    );

    return ZGrid(
      gridScale: _gridScale,
      blurBackgroundOnZoomedIn: true,
      controller: _controller,
      mounted: mounted,
      onZoomOutEnd: onZoomOutEnd,
      onZoomOutStart: onZoomOutStart,
      itemCount: FlyerDim.flyerGridNumberOfSlots(
        flyersCount: widget.flyersIDs?.length ?? 0,
        addFlyerButtonIsOn: widget.showAddFlyerButton,
        isLoadingGrid: false,
        numberOfColumnsOrRows: widget.columnCount,
      ),

      builder: (int index) {
        // ---------------------------------------------
        /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
        if (widget.showAddFlyerButton == true && index == 0){
          return AddFlyerButton(
            flyerBoxWidth: _gridScale.smallItemWidth,
          );
        }
        // ---------------------------------------------
        else {

          final int _flyerIndex = widget.showAddFlyerButton == true ? index-1 : index;
          final String _flyerID = widget.flyersIDs[_flyerIndex];
          final double _flyerBoxWidth = _gridScale.smallItemWidth;

          return FlyerBuilder(
              flyerID: _flyerID,
              flyerBoxWidth: _flyerBoxWidth,
              renderFlyer: RenderFlyer.firstSlide,
              onFlyerNotFound: widget.onFlyerNotFound,
              builder: (FlyerModel flyerModel){

                return FlyerSelectionStack(
                  flyerModel: flyerModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  onSelectFlyer: widget.onSelectFlyer == null ?
                      null //() => _onFlyerTap(flyerModel: flyerModel, index: index)
                      :
                      () => widget.onSelectFlyer(flyerModel),
                  onFlyerOptionsTap: widget.onFlyerOptionsTap == null ? null : () => widget.onFlyerOptionsTap(flyerModel),
                  selectionMode: widget.selectionMode,
                  flyerWidget: SmallFlyer(
                    flyerModel: flyerModel,
                    flyerBoxWidth: _gridScale.smallItemWidth,
                    optionsButtonIsOn: widget.onFlyerOptionsTap != null,
                    onTap: () => _onFlyerTap(
                      flyerModel: flyerModel,
                      index: index,
                      gridScale: _gridScale,
                    ),
                  ),
                );

          },
          );

        }

      },

      bigItemFootprint: FlyerBox(
        flyerBoxWidth: _gridScale.bigItemWidth,
        boxColor: Colorz.black255,
      ),

      bigItem: ValueListenableBuilder(
        valueListenable: _zoomedFlyer,
        builder: (_, FlyerModel flyerModel, Widget child) {
          return LightBigFlyer(
            flyerBoxWidth: _gridScale.bigItemWidth,
            renderedFlyer: flyerModel,
            // showGallerySlide: true,
            onHorizontalExit: () async {

              await ZGridController.zoomOut(
                  mounted: mounted,
                  onZoomOutStart: onZoomOutStart,
                  onZoomOutEnd: onZoomOutEnd,
                  zGridController: _controller,
              );

            },
          );
        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
