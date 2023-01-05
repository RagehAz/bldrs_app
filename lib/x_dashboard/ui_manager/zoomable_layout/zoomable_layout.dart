import 'dart:async';

import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/x_dashboard/ui_manager/zoomable_layout/zoomable_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ZoomableLayoutScreen extends StatefulWidget {
  // -----------------------------------------------------------------------------
  const ZoomableLayoutScreen({
    Key key
  }) : super(key: key);
  // -----------------------------------------------------------------------------
  @override
  State<ZoomableLayoutScreen> createState() => _ZoomableLayoutScreenState();
  // -----------------------------------------------------------------------------
}

class _ZoomableLayoutScreenState extends State<ZoomableLayoutScreen>  with SingleTickerProviderStateMixin{
  // -----------------------------------------------------------------------------
  final TransformationController _transformationController = TransformationController();
  AnimationController _zoomAnimationController;
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

    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _transformationController.addListener(() {

      // final double _scale = _transformationController.value.getMaxScaleOnAxis();

      Trinity.blogMatrix(_transformationController.value);

    });

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
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TASK :
  double _calculateMaxScale(){
    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    final double _flyerBoxWidth = FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: Axis.vertical,
      numberOfColumnsOrRows: 2,
      gridWidth: _screenWidth,
      gridHeight: _screenHeight,
    );

    final double _spacing = FlyerDim.flyerGridGridSpacingValue(_flyerBoxWidth);

    final double _zoomableScreenWidth = _flyerBoxWidth + (_spacing * 2);

    return _screenWidth / _zoomableScreenWidth;
  }
  // --------------------
  /// TASK :
  Matrix4 topLeftMatrix(){

    // 1.9716981132075473 calculated and printed

    final double _scaleX = 1.2; //_calculateMaxScale();
    final double _scaleY = _scaleX;
    final double _scale = _scaleX;

    const double _transX =  0;//- Scale.screenWidth(context) * 0;
    const double _transY = 0;

    final Float64List _list = Float64List.fromList(<double>[
      _scaleX,  0,        0,    0,
      0,        _scaleY,  0,    0,
      0,        0,        0,    0,
      _transX,  _transY,  0,    1/_scale,
    ]);

    return Matrix4.fromFloat64List(_list);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _reset() async {
    await _zoomToMatrix(Matrix4.identity());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _zoomToMatrix(Matrix4 matrix) async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: matrix,
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {
      _transformationController.value = _reset.value;
    });

    _zoomAnimationController.reset();

    await _zoomAnimationController.forward();


  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.screenWidth(context);
    final double _screenHeight = Scale.screenHeight(context);

    final double _flyerBoxWidth = FlyerDim.flyerGridFlyerBoxWidth(
        context: context,
        scrollDirection: Axis.vertical,
        numberOfColumnsOrRows: 2,
        gridWidth: _screenWidth,
        gridHeight: _screenHeight,
    );

    final double _spacing = FlyerDim.flyerGridGridSpacingValue(_flyerBoxWidth);

    final double _zoomableScreenWidth = _flyerBoxWidth + (_spacing * 2);

    // zoomableScreenWidth * maxScale = screenWidth
    final double _maxScale = _screenWidth / _zoomableScreenWidth;

    blog('maxScale : $_maxScale');

    return Material(
      color: Colorz.skyDarkBlue,
      child: InteractiveViewer(
        clipBehavior: Clip.hardEdge,
        alignPanAxis: false,
        boundaryMargin: EdgeInsets.zero,
        maxScale: _maxScale,
        minScale: 1,
        onInteractionEnd:(ScaleEndDetails details) {
          blog('onInteractionEnd');
        },
        onInteractionStart: (ScaleStartDetails details){
          blog('onInteractionStart');
        },
        onInteractionUpdate:(ScaleUpdateDetails details) {
          blog('onInteractionUpdate : details');
          blog(details.toString());
        },
        panEnabled: true,
        scaleEnabled: true,
        scaleFactor: 200.0,
        transformationController: _transformationController,
        child: Container(
          width: _screenWidth,
          height: _screenHeight,
          color: Colorz.yellow200,
          child: GridView.builder(
              gridDelegate: FlyerDim.flyerGridDelegate(
                flyerBoxWidth: _flyerBoxWidth,
                numberOfColumnsOrRows: 2,
                scrollDirection: Axis.vertical,
              ),
              padding: FlyerDim.flyerGridPadding(
                context: context,
                topPaddingValue: 10,
                gridSpacingValue: _spacing,
                isVertical: true,
              ),
              itemCount: 20,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, int index){

                return FlyerBox(
                  flyerBoxWidth: _flyerBoxWidth,
                  boxColor: Colorz.bloodTest,
                  onTap: () async {

                    await _reset();

                  },
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
    );

  }
  // -----------------------------------------------------------------------------
}
