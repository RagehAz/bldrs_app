import 'dart:async';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ZoomableGridController {
  // --------------------------------------------------------------------------
  ZoomableGridController(
      // {
      // this.gridWidth,
      // this.gridHeight,
      // }
  );
  // --------------------
  final TransformationController _transformationController = TransformationController();
  TransformationController get transformationController => _transformationController;
  // --------------------
  AnimationController _animationController;
  AnimationController get animationController => _animationController;
  // --------------------
  CurvedAnimation _animation;
  CurvedAnimation get animation => _animation;
  // --------------------
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  // --------------------
  final ValueNotifier<bool> _isZoomed = ValueNotifier(false);
  ValueNotifier<bool> get isZoomed => _isZoomed;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  ///
  void initialize({
    TickerProvider vsync,

    /// TOTAL WIDTH OF THE GRID
    double gridWidth,
    /// TOTAL HEIGHT OF THE GRID
    double gridHeight,
    /// ITEM HEIGHT WIDTH WHEN ZOOMED IN
    double bigItemWidth,
    /// ITEM HEIGHT WHEN ZOOMED IN
    double bigItemHeight,
    /// TOP PADDING FOR SMALL ITEMS
    double topPaddingOnZoomedOut = 5,
    /// TOP PADDING FOR BIG ITEMS
    double topPaddingOnZoomedIn = 5,
    /// SPACING RATIO BETWEEN ITEMS AND AROUND THE GRID
    double spacingRatio = 0.03,
    /// NUMBER OR COLUMNS
    int columnsCount = 2,
    /// ANIMATION DURATION
    Duration zoomingDuration = const Duration(milliseconds: 300),
    /// ANIMATION CURVE
    Curve zoomingCurve = Curves.easeOutExpo,
    /// TOP WIDGET FADE IN DURATION
    Duration zoomedItemFadeInDuration = const Duration(milliseconds: 200),
    /// TOP WIDGET FADE IN CURVE
    Curve zoomedItemFadeInCurve = Curves.easeInOutCubic,
  }) {

    /// GRID DIMENSIONS
    _gridWidth = gridWidth;
    _gridHeight = gridHeight;

    /// BIG ITEM DIMENSIONS
    _bigItemWidth = bigItemWidth;
    _bigItemHeight = bigItemHeight;

    /// SPACING
    _spacingRatio = spacingRatio;

    /// NUMBER OF COLUMNS
    _columnsCount = columnsCount;

    /// PADDINGS
    _topPaddingOnZoomedOut = topPaddingOnZoomedOut; // was topPadding
    _topPaddingOnZoomedIn = topPaddingOnZoomedIn; // was zoomedTopPadding

    /// ANIMATION DURATIONS - CURVES
    _zoomingDuration = zoomingDuration;
    _zoomingCurve = zoomingCurve;
    _zoomedItemFadeInDuration = zoomedItemFadeInDuration;
    _zoomedItemFadeInCurve = zoomedItemFadeInCurve;

    if (vsync != null){

      /// ANIMATION INITIALIZATION
      _animationController = AnimationController(
        vsync: vsync,
        duration: zoomingDuration,
      );

      /// CURVE INITIALIZATION
      _animation = CurvedAnimation(
        parent: _animationController,
        curve: zoomingCurve,
        reverseCurve: zoomingCurve,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  void dispose(){
    _transformationController.dispose();
    _isZoomed.dispose();
    _animationController.dispose();
    _animation.dispose();
    _scrollController.dispose();
  }
  // -----------------------------------------------------------------------------

  /// GRID DIMENSIONS

  // --------------------
  double _gridWidth;
  double get gridWidth => _gridWidth;
  // --------------------
  double _gridHeight;
  double get gridHeight => _gridHeight;
  // --------------------
  int _columnsCount;
  int get columnsCount => _columnsCount;
  // --------------------
  /// TESTED : WORKS PERFECT
  double getGridWidth(BuildContext context){
    /// NOTE : SHOULD USE THIS INSIDE BUILD METHODS
    return _gridWidth ?? Scale.screenWidth(context);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double getGridHeight(BuildContext context){
    /// NOTE : SHOULD USE THIS INSIDE BUILD METHODS
    return _gridHeight ?? Scale.screenHeight(context);
  }
  // -----------------------------------------------------------------------------

  /// SPACINGS

  // --------------------
  double _spacingRatio;
  double get spacingRatio => _spacingRatio;
  // --------------------
  /// TASK : TEST ME
  double getSpacing(BuildContext context){
    return getSmallItemWidth(context) * _spacingRatio;
  }
  // -----------------------------------------------------------------------------

  /// VERTICAL PADDINGS

  // --------------------
  double _topPaddingOnZoomedOut; // was topPadding
  double get topPaddingOnZoomedOut => _topPaddingOnZoomedOut;
  // --------------------
  double _topPaddingOnZoomedIn; // was zoomedTopPadding

  double get topPaddingOnZoomedIn => _topPaddingOnZoomedIn;
  // --------------------
  /// TASK : TEST ME
  double getBottomPadding(BuildContext context){
    final double _gridHeight = getGridHeight(context);
    return _gridHeight - _topPaddingOnZoomedOut - _getSmallItemHeight(context) - getSpacing(context) - 10;
  }
  // -----------------------------------------------------------------------------

  /// BIG ITEM DIMENSIONS

  // --------------------
  double _bigItemWidth;
  double get bigItemWidth => _bigItemWidth;
  // --------------------
  double _bigItemHeight;
  double get bigItemHeight => _bigItemHeight;
  // --------------------
  /// TASK : TEST ME
  double getBigItemWidth(BuildContext context){
    return _bigItemWidth ?? getGridWidth(context);
  }
  // --------------------
  /// TASK : TEST ME
  double getBigItemHeight(BuildContext context){
    return _bigItemHeight ?? getGridHeight(context);
  }
  // -----------------------------------------------------------------------------

  /// ASPECT RATIO

  // --------------------
  /// TASK : TEST ME
  double _getItemAspectRatio(BuildContext context){
    return getBigItemWidth(context) / getBigItemHeight(context);
  }
  // -----------------------------------------------------------------------------

  /// SMALL ITEM DIMENSIONS

  // --------------------
  /// TASK : TEST ME
  double getSmallItemWidth(BuildContext context){

    final double _smallItemWidth =
        getGridWidth(context) /
            (
                _columnsCount
                + (_columnsCount * _spacingRatio)
                + _spacingRatio
            );


    return _smallItemWidth;

  }
  // --------------------
  /// TASK : TEST ME
  double _getSmallItemHeight(BuildContext context){
    return getSmallItemWidth(context) / _getItemAspectRatio(context);
  }
  // -----------------------------------------------------------------------------

  /// ZOOMING WIDTH

  // --------------------
  /// TASK : TEST ME
  double _getZoomableWidth(BuildContext context){
    final double _flyerBoxWidth = getSmallItemWidth(context);
    final double _spacing = getSpacing(context);
    return _flyerBoxWidth + (_spacing * 2);
  }
  // --------------------
  /// TASK : TEST ME
  double getZoomedWidth(BuildContext context){
    final double _flyerBoxWidth = getSmallItemWidth(context);
    final double _scale = calculateMaxScale(context);
    return _flyerBoxWidth * _scale;
  }
  // -----------------------------------------------------------------------------

  /// ANIMATION DURATIONS - CURVES

  // --------------------
  Duration _zoomingDuration;
  Duration get zoomingDuration => _zoomingDuration;
  // --------------------
  Curve _zoomingCurve;
  Curve get zoomingCurve => _zoomingCurve;
  // --------------------
  Duration _zoomedItemFadeInDuration;
  Duration get zoomedItemFadeInDuration => _zoomedItemFadeInDuration;
  // --------------------
  Curve _zoomedItemFadeInCurve;
  Curve get zoomedItemFadeInCurve => _zoomedItemFadeInCurve;
  // -----------------------------------------------------------------------------

  /// ZOOMING OFFSETS (MATRIX TRANSLATIONS)

  // --------------------
  ///
  double _getRowOffset({
    @required int rowIndex,
    @required BuildContext context,
  }){

    blog('_getRowOffset : rowIndex : $rowIndex');

    return (_getSmallItemHeight(context) + getSpacing(context)) * rowIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getVerticalZoomOffset({
    @required int rowIndex,
    @required BuildContext context,
  }){

    blog('_getVerticalZoomOffset : rowIndex : $rowIndex');
    final double _scale = calculateMaxScale(context);
    final double _scaledTopPadding = _topPaddingOnZoomedOut * _scale;
    final double _rowOffset = _getRowOffset(
      context: context,
      rowIndex: rowIndex,
    ) * _scale;

    return  - (_scaledTopPadding - _topPaddingOnZoomedIn) + _rowOffset;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getHorizontalZoomOffset({
    @required int columnIndex,
    @required BuildContext context,
  }){
    final double _scale = calculateMaxScale(context);
    final double _flyerBoxWidth = getSmallItemWidth(context);
    final double _spacing = getSpacing(context);
    return - (((_flyerBoxWidth + _spacing) * columnIndex) * _scale);
  }
  // --------------------
  /// TASK : TEST ME
  double calculateMaxScale(BuildContext context){
    final double _maxZoomWidth = _getZoomableWidth(context);
    return getGridWidth(context) / _maxZoomWidth;
  }
  // -----------------------------------------------------------------------------

  /// ZOOMING

  // --------------------
  /// TASK : TEST ME
  Future<void> zoomIn({
    @required BuildContext context,
    @required int itemIndex,
    @required bool mounted,
  }) async {

    blog('zoomIn : itemIndex ~/ rowsCount = ${itemIndex ~/ _columnsCount}');

    unawaited(_scrollToRow(
        context: context,
        itemIndex: itemIndex,
    ));

    await _zoomToMatrix(_getZoomMatrix(
      context: context,
      rowIndex: 0,
      columnIndex: itemIndex % _columnsCount,
    ));

    setNotifier(
      notifier: _isZoomed,
      mounted: mounted,
      value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> zoomOut({
    @required bool mounted,
  }) async {

    setNotifier(
      notifier: _isZoomed,
      mounted: mounted,
      value: false,
    );

    await _zoomToMatrix(Matrix4.identity());

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _zoomToMatrix(Matrix4 matrix) async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: matrix,
    ).animate(_animation);

    _animation.addListener(() {
      _transformationController.value = _reset.value;
    });

    _animationController.reset();

    await _animationController.forward();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _scrollToRow({
    @required BuildContext context,
    @required int itemIndex,
  }) async {

    final double _offset = _getRowOffset(
      context: context,
      rowIndex: itemIndex ~/ _columnsCount,
    );

    await Sliders.slideToOffset(
      scrollController: _scrollController,
      offset: _offset,
      duration: _zoomingDuration,
      curve: _zoomingCurve,
    );

  }
  // -----------------------------------------------------------------------------

  /// MATRIXES

  // --------------------
  /// TESTED : WORKS PERFECT
  Matrix4 _getZoomMatrix({
    @required BuildContext context,
    @required int rowIndex,
    @required int columnIndex,
  }){

    final double _scale = calculateMaxScale(context);
    final double _transX = _getHorizontalZoomOffset(
      columnIndex: columnIndex,
      context: context,
    );
    final double _transY = _getVerticalZoomOffset(
      context: context,
      rowIndex: 0,
    );

    final Float64List _list = Float64List.fromList(<double>[
      _scale,  0,        0,        0,
      0,        _scale,  0,        0,
      0,        0,        _scale,  0,
      _transX,  _transY,  0,       1,
    ]);

    return Matrix4.fromFloat64List(_list);

  }

  // -----------------------------------------------------------------------------
}
