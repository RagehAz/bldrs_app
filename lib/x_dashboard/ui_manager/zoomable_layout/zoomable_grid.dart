import 'dart:async';

import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widget_fader/widget.dart';

class ZoomableGrid extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const ZoomableGrid({
    this.gridWidth,
    this.gridHeight,

    this.topPadding = Stratosphere.smallAppBarStratosphere,
    this.spacing = 5,
    this.rowsOrColumnsCount = 2,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeOutExpo,

    this.topChild,
    this.topChildFadeInCurve = Curves.easeInOutCubic,
    this.topChildFadeInDuration = const Duration(milliseconds: 200),


    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;

  final double topPadding;
  final double spacing;
  final int rowsOrColumnsCount;

  final Duration animationDuration;
  final Curve animationCurve;

  final Widget topChild;
  final Duration topChildFadeInDuration;
  final Curve topChildFadeInCurve;

  // -----------------------------------------------------------------------------
  @override
  State<ZoomableGrid> createState() => _ZoomableGridState();
// -----------------------------------------------------------------------------
}

class _ZoomableGridState extends State<ZoomableGrid>  with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  static const int rowsCount = 2; // matrixes are only opted for 2 rows
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Curve _curve = Curves.easeOutExpo;
  static const Curve _bigFlyerFadeInCurve = Curves.easeInOutCubic;
  static const Duration _bigFlyerFadeInDuration = Duration(milliseconds: 200);
  static const double _topPadding = Stratosphere.smallAppBarStratosphere;
  // -----------------------------------------------------------------------------
  final TransformationController _transformationController = TransformationController();
  AnimationController _animationController;
  CurvedAnimation _animation;
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  final ValueNotifier<bool> _isZoomed = ValueNotifier(false);
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

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: _curve,
      reverseCurve: _curve,
    );

    // _transformationController.addListener(() {
    //   final double _scale = _transformationController.value.getMaxScaleOnAxis();
    //   Trinity.blogMatrix(_transformationController.value);
    // });

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
    _loading.dispose();
    _isZoomed.dispose();
    _transformationController.dispose();
    _animationController.dispose();
    _animation.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  double _getFlyerBoxWidth(){
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    return FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: Axis.vertical,
      numberOfColumnsOrRows: rowsCount,
      gridWidth: _screenWidth,
      gridHeight: _screenHeight,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getFlyerBoxHeight(){
    return FlyerDim.flyerHeightByFlyerWidth(context, _getFlyerBoxWidth());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getSpacing(){
    final double _flyerBoxWidth = _getFlyerBoxWidth();
    return FlyerDim.flyerGridGridSpacingValue(_flyerBoxWidth);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getMaxZoomWidth(){
    final double _flyerBoxWidth = _getFlyerBoxWidth();
    final double _spacing = _getSpacing();
    return _flyerBoxWidth + (_spacing * 2);
  }
  // --------------------
  double _getVerticalOffset({
    @required int rowIndex,
  }){
    return (_getFlyerBoxHeight() + _getSpacing()) * rowIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getVerticalTranslation({
    @required int rowIndex,
  }){
    final double _scale = _calculateMaxScale();
    final double _scaledStratosphere = _topPadding * _scale;
    final double _rowOffset = _getVerticalOffset(rowIndex: rowIndex) * _scale;
    return - ((_scaledStratosphere - _topPadding) + _rowOffset);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getRightColumnTranslation(){
    final double _scale = _calculateMaxScale();
    final double _flyerBoxWidth = _getFlyerBoxWidth();
    final double _spacing = _getSpacing();
    return - (_flyerBoxWidth + _spacing) * _scale;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _calculateMaxScale(){
    final double _screenWidth = Scale.screenWidth(context);
    final double _maxZoomWidth = _getMaxZoomWidth();
    return _screenWidth / _maxZoomWidth;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Matrix4 rightMatrix({
    @required int rowIndex,
  }){

    final double _scale = _calculateMaxScale();
    final double _transX = _getRightColumnTranslation();
    final double _transY =  _getVerticalTranslation(
      rowIndex: rowIndex,
    );

    final Float64List _list = Float64List.fromList(<double>[
      _scale,  0,        0,        0,
      0,        _scale,  0,        0,
      0,        0,        _scale,  0,
      _transX,  _transY,  0,       1,
    ]);

    return Matrix4.fromFloat64List(_list);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Matrix4 leftMatrix({
    @required int rowIndex,
  }){

    final double _scale = _calculateMaxScale();

    const double _transX = 0;
    final double _transY =  _getVerticalTranslation(
      rowIndex: rowIndex,
    );

    final Float64List _list = Float64List.fromList(<double>[
      _scale,  0,        0,        0,
      0,        _scale,  0,        0,
      0,        0,        _scale,  0,
      _transX,  _transY,  0,       1,
    ]);

    return Matrix4.fromFloat64List(_list);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _zoomRight({
    @required int flyerIndex,
  }) async {

    await _zoomToMatrix(rightMatrix(rowIndex: flyerIndex ~/ 2));

    setNotifier(
      notifier: _isZoomed,
      mounted: mounted,
      value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _zoomLeft({
    @required int flyerIndex,
  }) async {

    await _zoomToMatrix(leftMatrix(rowIndex: flyerIndex ~/ 2));

    setNotifier(
      notifier: _isZoomed,
      mounted: mounted,
      value: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _reset() async {

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
  Future<void> _scrollToRow({
    @required int flyerIndex,
  }) async {

    final double _offset = _getVerticalOffset(rowIndex: flyerIndex ~/ 2);

    await Sliders.slideToOffset(
      scrollController: _scrollController,
      offset: _offset,
      duration: _animationDuration,
      curve: _curve,
    );

  }
  // --------------------
  Future<void> _onFlyerTap(int index) async {

    /// if index is odd number => go right
    if(index.isOdd){
      unawaited(_zoomRight(flyerIndex: 0));
      unawaited(_scrollToRow(flyerIndex: index));
    }

    else {
      unawaited(_zoomLeft(flyerIndex: 0));
      unawaited(_scrollToRow(flyerIndex: index));
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);
    final double _flyerBoxWidth = _getFlyerBoxWidth();
    final double _spacing = _getSpacing();
    final double _maxScale =_calculateMaxScale();

    return ValueListenableBuilder(
      valueListenable: _isZoomed,
      builder: (_, bool isZoomed, Widget child){

        return Stack(
          children: <Widget>[

            /// ZOOMABLE GRID
            child,

            /// THE FLYER
            if (isZoomed == true)
              IgnorePointer(
                ignoring: !isZoomed,
                child: WidgetFader(
                  fadeType: FadeType.fadeIn,
                  duration: _bigFlyerFadeInDuration,
                  curve: _bigFlyerFadeInCurve,
                  child: Padding(
                    padding: const EdgeInsets.only(top: _topPadding),
                    child: FlyerBox(
                      flyerBoxWidth: BldrsAppBar.width(context),
                      boxColor: Colorz.yellow255,
                      stackWidgets: const [
                        Loading(loading: true),
                      ],
                    ),
                  ),
                ),
              ),

          ],
        );

      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        maxScale: _maxScale,
        minScale: 1,
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
          width: _screenWidth,
          height: _screenHeight,
          child: ValueListenableBuilder(
            valueListenable: _isZoomed,
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
                controller: _scrollController,
                gridDelegate: FlyerDim.flyerGridDelegate(
                  flyerBoxWidth: _flyerBoxWidth,
                  numberOfColumnsOrRows: rowsCount,
                  scrollDirection: Axis.vertical,
                ),
                padding: FlyerDim.flyerGridPadding(
                  context: context,
                  topPaddingValue: _topPadding,
                  gridSpacingValue: _spacing,
                  isVertical: true,
                ),
                itemCount: 20,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, int index){

                  return FlyerBox(
                    flyerBoxWidth: _flyerBoxWidth,
                    boxColor: Colorz.bloodTest.withAlpha(Numeric.createRandomIndex(listLength: 1000)),
                    onTap: () => _onFlyerTap(index),
                    stackWidgets: [

                      SuperVerse(
                        verse: Verse.plain(index.toString()),
                        margin: 20,
                        labelColor: Colorz.black255,
                      ),

                    ],
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
