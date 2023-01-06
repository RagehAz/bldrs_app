import 'dart:async';

import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:widget_fader/widget.dart';

import 'zoomable_grid_controller.dart';

class ZoomableGrid extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const ZoomableGrid({
    this.controller,
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final ZoomableGridController controller;
  // -----------------------------------------------------------------------------
  @override
  State<ZoomableGrid> createState() => _ZoomableGridState();
// -----------------------------------------------------------------------------
}

class _ZoomableGridState extends State<ZoomableGrid>  with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
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

    if (widget.controller == null){
      _controller = ZoomableGridController();
      _controller.initialize(vsync: this,);
    }

    else {
      _controller = widget.controller;
      _controller.initialize(
        vsync: this,
        gridWidth: widget.controller.gridWidth,
        gridHeight: widget.controller.gridHeight,
        smallItemWidth: widget.controller.smallItemWidth,
        smallItemHeight: widget.controller.smallItemHeight,
        topPaddingOnZoomedOut: widget.controller.topPaddingOnZoomedOut,
        topPaddingOnZoomedIn: widget.controller.topPaddingOnZoomedIn,
        spacingRatio: widget.controller.spacingRatio,
        columnsCount: widget.controller.columnsCount,
        zoomingDuration: widget.controller.zoomingDuration,
        zoomingCurve: widget.controller.zoomingCurve,
        zoomedItemFadeInDuration: widget.controller.zoomedItemFadeInDuration,
        zoomedItemFadeInCurve: widget.controller.zoomedItemFadeInCurve,
      );
    }

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
  void dispose() {

      // widget.controller?.dispose();
      _controller?.dispose();
    // if (widget.controller == null) {
    // }

    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSmallItemTap(int index) async {

    await _controller.zoomIn(
        context: context,
        itemIndex: index,
        mounted: mounted
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDismissBigItem() async {
    await _controller.zoomOut(
      mounted: mounted,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// GRID DIMENSIONS
    final double _gridWidth = _controller.getGridWidth(context);
    final double _gridHeight = _controller.getGridHeight(context);
    /// SPACINGS
    // final double _spacing = _controller.getSpacing(context);
    /// BIG ITEM DIMENSIONS
    final double _bigItemWidth = _controller.getBigItemWidth(context);
    final double _bigItemHeight = _controller.getBigItemHeight(context);
    /// SMALL ITEM DIMENSIONS
    final double _smallItemWidth = _controller.smallItemWidth;
    final double _smallItemHeight = _controller.smallItemHeight;
    /// VERTICAL PADDINGS
    final EdgeInsets _topPaddingOnZoomedIn = EdgeInsets.only(top: _controller.topPaddingOnZoomedIn);
    // final double _bottomPadding = _controller.getBottomPadding(context);

    return ValueListenableBuilder(
      valueListenable: _controller.isZoomed,
      builder: (_, bool isZoomed, Widget child){

        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            /// ZOOMABLE GRID
            child,

            /// THE FLYER
            if (isZoomed == true)
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.5,
                  child: IgnorePointer(
                    ignoring: !isZoomed,
                    child: WidgetFader(
                      fadeType: FadeType.fadeIn,
                      duration: _controller.zoomedItemFadeInDuration,
                      curve: _controller.zoomedItemFadeInCurve,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [

                          /// BACKGROUND BLACK FOOTPRINT
                          Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
                            width: _bigItemWidth,
                            height: _bigItemHeight,
                            margin: _topPaddingOnZoomedIn,
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: _bigItemWidth,
                              height: _bigItemHeight,
                              color: Colorz.black255,
                            ),
                          ),

                          /// BIG FLYER
                          DismissiblePage(
                            key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
                            onDismissed: () => _onDismissBigItem(),
                            isFullScreen: false,
                            dragSensitivity: .4,
                            maxTransformValue: 4,
                            minScale: 1,
                            reverseDuration: Ratioz.duration150ms,
                            /// BACKGROUND
                            // startingOpacity: 1,
                            backgroundColor: Colors.transparent,
                            // dragStartBehavior: DragStartBehavior.start,
                            // direction: DismissiblePageDismissDirection.vertical,

                            child: Material(
                              color: Colors.transparent,
                              type: MaterialType.transparency,
                              child: Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
                                width: _bigItemWidth,
                                height: _bigItemHeight,
                                margin: _topPaddingOnZoomedIn,
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: _bigItemWidth,
                                  height: _bigItemHeight,
                                  color: Colorz.blue80,
                                ),
                              ),
                            ),
                          ),

                        ],

                      ),
                    ),
                  ),
                ),
              ),

          ],
        );

      },
      child: InteractiveViewer(
        transformationController: _controller.transformationController,
        // maxScale: _maxScale,
        // minScale: 1,
        panEnabled: false,
        scaleEnabled: false,
        // clipBehavior: Clip.hardEdge,
        // alignPanAxis: false,
        // boundaryMargin: EdgeInsets.zero,
        // onInteractionEnd:(ScaleEndDetails details) {
        //   blog('onInteractionEnd');
        // },
        // onInteractionStart: (ScaleStartDetails details){
        //   blog('onInteractionStart');
        // },
        // onInteractionUpdate:(ScaleUpdateDetails details) {
        //   blog('onInteractionUpdate : details');
        //   blog(details.toString());
        // },
        // scaleFactor: 200.0, // Affects only pointer device scrolling, not pinch to zoom.
        child: SizedBox(
          width: _gridWidth,
          height: _gridHeight,
          child: ValueListenableBuilder(
            valueListenable: _controller.isZoomed,
            builder: (_, bool isZoomed, Widget theGrid){

              /// THE GRID
              return IgnorePointer(
                ignoring: isZoomed,
                child: theGrid,
              );

            },

            /// to avoid rebuilding the whole list
            child: GridView.builder(
                key: const ValueKey<String>('The_zoomable_grid'),
                controller: _controller.scrollController,
                gridDelegate: _controller.gridDelegate(context: context),
                padding: _controller.gridPadding(context: context),
                itemCount: 20,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, int index){

                  return GestureDetector(
                    onTap: () => _onSmallItemTap(index),
                    child: Container(
                      width: _smallItemWidth,
                      height: _smallItemHeight,
                      color: Colorz.bloodTest.withAlpha(Numeric.createRandomIndex(listLength: 1000)),
                      alignment: Alignment.center,
                      child: SuperVerse(
                        verse: Verse.plain(index.toString()),
                        margin: 20,
                        labelColor: Colorz.black255,
                      ),
                    ),
                  );

                }
            ),
          ),
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
