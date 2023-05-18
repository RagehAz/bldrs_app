part of z_grid;

class ZGrid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const ZGrid({
    @required this.gridScale,
    @required this.controller,
    @required this.itemCount,
    @required this.mounted,
    @required this.blurBackgroundOnZoomedIn,
    @required this.onZoomOutStart,
    @required this.onZoomOutEnd,
    @required this.bigItem,
    @required this.bigItemFootprint,
    @required this.builder,
    Key key
  }) : super(key: key);
  // --------------------
  final ZGridScale gridScale;
  final ZGridController controller;
  final int itemCount;
  final bool mounted;
  final bool blurBackgroundOnZoomedIn;
  final Function onZoomOutStart;
  final Function onZoomOutEnd;
  final Widget bigItem;
  final Widget bigItemFootprint;
  final Widget Function(int index) builder;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final EdgeInsets _topPaddingOnZoomedIn = EdgeInsets.only(
      top: ZGridScale.getTopPaddingOnZoomIn(
        topPaddingOnZoomIn: gridScale.topPaddingOnZoomIn,
      ),
    );

    return ValueListenableBuilder(
      valueListenable: controller.isZoomed,
      builder: (_, bool zoomed, Widget child){

        return GestureDetector(
          onHorizontalDragUpdate: zoomed == false ? null : (details) {
            blog('prevent swipe gestures from affecting the PageView');
          },
          onHorizontalDragEnd: zoomed == false ? null : (details) {
            blog('prevent swipe gestures from affecting the PageView');
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[

              /// ZOOMABLE GRID
              child,

              /// THE BIG ITEM ON TOP OF GRID AFTER ZOOMING IN
              if (zoomed == true && bigItem != null)
                IgnorePointer(
                  ignoring: !zoomed,
                  child: WidgetFader(
                    fadeType: FadeType.fadeIn,
                    duration: ZGridController.zoomedItemFadeInDuration,
                    curve: ZGridController.zoomedItemFadeInCurve,
                    child: Stack (
                      alignment: Alignment.topCenter,
                      children: <Widget>[

                        BlurLayer(
                          width: gridScale.gridWidth,
                          height: gridScale.gridHeight,
                          color: Colorz.black125,
                          blurIsOn: blurBackgroundOnZoomedIn,
                        ),

                        /// BACKGROUND BLACK FOOTPRINT
                        if (bigItemFootprint != null)
                        Container( // => THIS TREE STARTING HERE IS USED TWICE : COPY THIS TEXT TO FIND WHERE
                          width: gridScale.bigItemWidth,
                          height: gridScale.bigItemHeight,
                          margin: _topPaddingOnZoomedIn,
                          alignment: Alignment.topCenter,
                          child: bigItemFootprint,
                        ),

                        /// BIG FLYER
                        DismissiblePage(
                          key: const ValueKey<String>('FullScreenFlyer_DismissiblePage'),
                          onDismissed: () => ZGridController.onDismissBigItem(
                            mounted: mounted,
                            zGridController: controller,
                            onZoomOutStart: onZoomOutStart,
                            onZoomOutEnd: onZoomOutEnd,
                          ),
                          // isFullScreen: true,
                          dragSensitivity: .4,
                          maxTransformValue: 4,
                          minScale: 0.9,
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
                              width: gridScale.bigItemWidth,
                              height: gridScale.bigItemHeight,
                              margin: _topPaddingOnZoomedIn,
                              alignment: Alignment.topCenter,
                              child: bigItem,
                            ),
                          ),
                        ),

                      ],

                    ),
                  ),
                ),

            ],
          ),
        );

      },
      child: InteractiveViewer(
        transformationController: controller.transformationController,
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
          width: gridScale.gridWidth,
          height: gridScale.gridHeight,
          child: ValueListenableBuilder(
            valueListenable: controller.isZoomed,
            builder: (_, bool zoomed, Widget theGrid){

              /// THE GRID
              return IgnorePointer(
                ignoring: zoomed,
                child: GridView.builder(
                key: const ValueKey<String>('ZGrid'),
                controller: controller.scrollController,
                gridDelegate: ZGridScale.getGridDelegate(
                  gridWidth: gridScale.gridWidth,
                  columnCount: gridScale.columnCount,
                  itemAspectRatio: gridScale.itemAspectRatio,
                  gridSidePadding: gridScale.gridSidePadding,
                ),
                padding: ZGridScale.getGridPadding(
                  topPaddingOnZoomOut: gridScale.topPaddingOnZoomOut,
                  gridWidth: gridScale.gridWidth,
                  columnCount: gridScale.columnCount,
                  itemAspectRatio: gridScale.itemAspectRatio,
                  context: context,
                  gridSidePadding: gridScale.gridSidePadding,
                  isZoomed: zoomed,
                  bottomPaddingOnZoomedOut: gridScale.bottomPaddingOnZoomedOut,
                ),
                itemCount: itemCount,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, int index) => builder(index)
            ),
              );

            },

            child: const SizedBox(),

          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}