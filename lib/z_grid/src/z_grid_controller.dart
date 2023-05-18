part of z_grid;

class ZGridController {
  // -----------------------------------------------------------------------------
  const ZGridController({
    @required this.isZoomed,
    @required this.scrollController,
    @required this.lastOffset,
    @required this.transformationController,
    @required this.animationController,
    @required this.animation,
    @required this.shouldDisposeScrollController,
  });
  // --------------------
  final ValueNotifier<bool> isZoomed;
  final ScrollController scrollController;
  final ValueNotifier<double> lastOffset;
  final TransformationController transformationController;
  final AnimationController animationController;
  final CurvedAnimation animation;
  final bool shouldDisposeScrollController;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  static ZGridController initialize({
    @required TickerProvider vsync,
    @required ScrollController scrollController,
  }){

     final AnimationController _animationController = AnimationController(
        vsync: vsync,
        duration: zoomingDuration,
      );

     final CurvedAnimation _animation = CurvedAnimation(
        parent: _animationController,
        curve: zoomingCurve,
        reverseCurve: zoomingCurve,
      );

    return ZGridController(
      animation: _animation,
      animationController: _animationController,
      scrollController: scrollController ?? ScrollController(),
      shouldDisposeScrollController: scrollController == null,
      isZoomed: ValueNotifier(false),
      lastOffset: ValueNotifier(0),
      transformationController: TransformationController(),
    );

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  void dispose(){
    animationController.dispose();
    isZoomed.dispose();
    lastOffset.dispose();
    transformationController.dispose();
    animation.dispose();
    if (shouldDisposeScrollController) {
      scrollController.dispose();
    }
  }

  // -----------------------------------------------------------------------------

  /// ANIMATION DURATIONS - CURVES

  // --------------------
  static const Duration zoomedItemFadeInDuration = Duration(milliseconds: 200);
  static const Curve zoomedItemFadeInCurve = Curves.easeInOutCubic;
  static const Duration zoomingDuration = Duration(milliseconds: 300);
  static const Curve zoomingCurve = Curves.easeOutExpo;
  // -----------------------------------------------------------------------------

  /// MICRO ZOOMING CONTROLLERS

  // --------------------
  static Future<void> _scrollToRow({
    @required int itemIndex,
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required bool mounted,
    @required ZGridController zGridController,
    @required double gridSidePadding,
  }) async {

    final double _newOffset = ZGridScale._getRowOffset(
      rowIndex: itemIndex ~/ columnCount,
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    setNotifier(
        notifier: zGridController.lastOffset,
        mounted: mounted,
        value: zGridController.scrollController.offset,
    );

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: _newOffset,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

  }
  // -----------------------------------------------------------------------------
  static Future<void> _zoomToMatrix({
    @required Matrix4 matrix,
    @required ZGridController zGridController,
  }) async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: zGridController.transformationController.value,
      end: matrix,
    ).animate(zGridController.animation);

    zGridController.animation.addListener(() {
      zGridController.transformationController.value = _reset.value;
    });

    zGridController.animationController.reset();

    await zGridController.animationController.forward();

    zGridController.animation.removeListener(() { });
  }
  // -----------------------------------------------------------------------------

  /// ZOOMING

  // --------------------
  static Future<void> zoomIn({
    @required BuildContext context,
    @required int itemIndex,
    @required bool mounted,
    @required Function onZoomInStart,
    @required Function onZoomInEnd,
    @required ZGridController zGridController,
    @required ZGridScale gridScale,
  }) async {

    Keyboard.closeKeyboard(context);

    // blog('zoomIn : itemIndex ~/ rowsCount = ${itemIndex ~/ _columnsCount}');

    if (onZoomInStart != null){
      await onZoomInStart();
    }

    unawaited(_scrollToRow(
      itemIndex: itemIndex,
      columnCount: gridScale.columnCount,
      gridWidth: gridScale.gridWidth,
      itemAspectRatio: gridScale.itemAspectRatio,
      zGridController: zGridController,
      mounted: mounted,
      gridSidePadding: gridScale.gridSidePadding,
    ));

    /// APP IS LEFT TO RIGHT INDEX
    final int _ltrIndex = itemIndex % gridScale.columnCount;
    /// APP IS RIGHT TO LEFT INDEX
    final int _reverseIndex = gridScale.columnCount - (itemIndex % gridScale.columnCount) - 1;

    await _zoomToMatrix(
      zGridController: zGridController,
      matrix: ZGridScale._getZoomMatrix(
        context: context,
        rowIndex: 0,
        columnIndex: UiProvider.checkAppIsLeftToRight(context) ? _ltrIndex : _reverseIndex,
        columnCount: gridScale.columnCount,
        gridWidth: gridScale.gridWidth,
        topPaddingOnZoomIn: gridScale.topPaddingOnZoomIn,
        topPaddingOnZoomOut: gridScale.topPaddingOnZoomOut,
        gridSidePadding: gridScale.gridSidePadding,
      ),
    );

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: true,
    );

    if (onZoomInEnd != null){
      await onZoomInEnd();
    }

  }
  // --------------------
  static Future<void> zoomOut({
    @required bool mounted,
    @required  Function onZoomOutStart,
    @required  Function onZoomOutEnd,
    @required ZGridController zGridController,
  }) async {

    if (onZoomOutStart != null){
      await onZoomOutStart();
    }

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: false,
    );

    unawaited(_zoomToMatrix(
      zGridController: zGridController,
      matrix: Matrix4.identity(),
    ));

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: zGridController.lastOffset.value,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

    if (onZoomOutEnd != null){
      await onZoomOutEnd();
    }

  }
  // --------------------
  static Future<void> onDismissBigItem({
    @required Function onZoomOutStart,
    @required Function onZoomOutEnd,
    @required bool mounted,
    @required ZGridController zGridController,
  }) async {

    if (onZoomOutStart != null){
      await onZoomOutStart();
    }

    setNotifier(
      notifier: zGridController.isZoomed,
      mounted: mounted,
      value: false,
    );

    unawaited(_zoomToMatrix(
      matrix: Matrix4.identity(),
      zGridController: zGridController,
    ));

    await Sliders.slideToOffset(
      scrollController: zGridController.scrollController,
      offset: zGridController.lastOffset.value,
      duration: zoomingDuration,
      curve: zoomingCurve,
    );

    if (onZoomOutEnd != null){
      await onZoomOutEnd();
    }


  }
  // -----------------------------------------------------------------------------
}