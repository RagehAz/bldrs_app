import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_light_flyer_structure/b_light_big_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/small_flyer.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/packed_screen.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/src/zoomable_grid_controller.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

class ZoomableFlyersGrid extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoomableFlyersGrid({
    @required this.flyersIDs,
    @required this.gridWidth,
    @required this.gridHeight,
    this.columnCount = 2,
    this.showAddFlyerButton = false,
    this.onSelectFlyer,
    this.onFlyerNotFound,
    this.selectionMode,
    this.onFlyerOptionsTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> flyersIDs;
  final double gridWidth;
  final double gridHeight;
  final int columnCount;
  final bool showAddFlyerButton;
  final Function(FlyerModel flyerModel) onSelectFlyer;
  final Function onFlyerNotFound;
  final bool selectionMode;
  final Function(FlyerModel flyerModel) onFlyerOptionsTap;
  /// --------------------------------------------------------------------------
  @override
  State<ZoomableFlyersGrid> createState() => _ZoomableFlyersGridState();
  /// --------------------------------------------------------------------------
}

class _ZoomableFlyersGridState extends State<ZoomableFlyersGrid> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<FlyerModel> _zoomedFlyer = ValueNotifier(null);
  ZoomableGridController _controller;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _controller = initializeBldrsZoomableGridController(
      context: context,
      columnsCount: widget.columnCount,
      gridWidth: widget.gridWidth,
      gridHeight: widget.gridHeight,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(ZoomableFlyersGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (
    Mapper.checkListsAreIdentical(list1: widget.flyersIDs, list2: oldWidget.flyersIDs) == false
    ) {
      setState(() {});
    }
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _zoomedFlyer.dispose();
    _controller.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> onZoomInStart() async {
    blog('onZoomInStart');

    UiProvider.proSetLayoutIsVisible(
        context: context,
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
        context: context,
        setTo: true,
        notify: true,
    );

  }
  // -----------------------------------------------------------------------------
  Future<void> _onFlyerTap({
    @required FlyerModel flyerModel,
    @required int index,
  }) async {

    if (flyerModel != null) {

      if (widget.onSelectFlyer != null) {
        widget.onSelectFlyer(flyerModel);
      }

      else {
        setNotifier(
          notifier: _zoomedFlyer,
          mounted: mounted,
          value: flyerModel,
        );

        // UiProvider.proSetLayoutIsVisible(
        //     context: context,
        //     setTo: false,
        //     notify: true,
        // );

        await _controller.zoomIn(
          context: context,
          itemIndex: index,
          mounted: true,
          onStart: onZoomInStart,
          onEnd: onZoomInEnd,
        );
      }

    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ZoomableGrid(
      controller: _controller,
      onZoomOutStart: onZoomOutStart,
      onZoomOutEnd: onZoomOutEnd,

      bigItemFootprint: FlyerBox(
        flyerBoxWidth: _controller.getBigItemWidth(context),
        boxColor: Colorz.black255,
      ),

      bigItem: ValueListenableBuilder(
        valueListenable: _zoomedFlyer,
        builder: (_, FlyerModel flyerModel, Widget child) {
          return LightBigFlyer(
            flyerBoxWidth: _controller.getBigItemWidth(context),
            renderedFlyer: flyerModel,
            onHorizontalExit: () async {
              await _controller.zoomOut(
                mounted: true,
                onStart: onZoomOutStart,
                onEnd: onZoomOutEnd,
              );
            },
          );
        },
      ),

      itemCount: widget.flyersIDs?.length ?? 0,
      builder: (int index) {
        // ---------------------------------------------
        /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
        if (widget.showAddFlyerButton == true && index == 0){
          return AddFlyerButton(
            flyerBoxWidth: _controller.smallItemWidth,
          );
        }
        // ---------------------------------------------
        else {

          final int _flyerIndex = widget.showAddFlyerButton == true ? index-1 : index;
          final String _flyerID = widget.flyersIDs[_flyerIndex];
          final double _flyerBoxWidth = _controller.smallItemWidth;

          return FlyerBuilder(
              flyerID: _flyerID,
              flyerBoxWidth: _flyerBoxWidth,
              renderFlyer: RenderFlyer.firstSlide,
              onFlyerNotFound: widget.onFlyerNotFound,
              builder: (FlyerModel flyerModel){

                return FlyerSelectionStack(
                  flyerModel: flyerModel,
                  flyerBoxWidth: _flyerBoxWidth,
                  onSelectFlyer: widget.onSelectFlyer == null ? null : () => widget.onSelectFlyer(flyerModel),
                  onFlyerOptionsTap: widget.onFlyerOptionsTap == null ? null : () => widget.onFlyerOptionsTap(flyerModel),
                  selectionMode: widget.selectionMode,
                  flyerWidget: SmallFlyer(
                    flyerModel: flyerModel,
                    flyerBoxWidth: _controller.smallItemWidth,
                    optionsButtonIsOn: widget.onFlyerOptionsTap != null,
                    onTap: () => _onFlyerTap(
                      flyerModel: flyerModel,
                      index: index,
                    ),
                  ),
                );

          },
          );

        }

      },
    );

  }
  // -----------------------------------------------------------------------------
}
