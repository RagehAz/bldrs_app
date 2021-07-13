import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ZoomablePicture extends StatefulWidget {
  final Widget child;
  final bool isOn;

  const ZoomablePicture({
    @required this.child,
    @required this.isOn,
    Key key
  }) : super(key: key);

  @override
  _ZoomablePictureState createState() => _ZoomablePictureState();
}

class _ZoomablePictureState extends State<ZoomablePicture> with TickerProviderStateMixin{
  TransformationController _transformationController;
  AnimationController _zoomAnimationController;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    _transformationController = TransformationController();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: Ratioz.duration150ms,
      animationBehavior: AnimationBehavior.normal,
    );
    _transformationController.addListener(() {
      if(_transformationController.value.getMaxScaleOnAxis() > 1.5){
        print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX its bigger than 1.5 now');
      }
    });
    super.initState();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _transformationController.dispose();
    _zoomAnimationController.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  void resetZoom(){
    final _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {
      _transformationController.value = _reset.value;
    });

    _zoomAnimationController.reset();
    _zoomAnimationController.forward();
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: widget.key,
      transformationController: _transformationController,
      panEnabled: widget.isOn ? true : false,
      scaleEnabled: widget.isOn ? true : false,
      constrained: false,
      alignPanAxis: false,
      boundaryMargin: EdgeInsets.zero,
      maxScale: 10,
      minScale: 0.5,
      onInteractionEnd: (ScaleEndDetails scaleEndDetails){
        // print('scaleEndDetails : $scaleEndDetails');
        // setState(() {
        //   _transformationController.value = new Matrix4.identity();
        //   print('should toScene');
        // });

        // Offset _pixelPerSecond = scaleEndDetails.velocity.pixelsPerSecond;
        // Offset _pixelTranslate = scaleEndDetails.velocity.pixelsPerSecond.translate(1, 1);
        // Offset _pixelScale = scaleEndDetails.velocity.pixelsPerSecond.scale(0, 0);
        // double _direction = scaleEndDetails.velocity.pixelsPerSecond.direction;
        // double _distance = scaleEndDetails.velocity.pixelsPerSecond.distance;
        // bool _isFinite = scaleEndDetails.velocity.pixelsPerSecond.isFinite;
        // Offset _clampingPixelPerSecond = scaleEndDetails.velocity.clampMagnitude(0, 10).pixelsPerSecond;
        //
        // print('_pixelPerSecond : $_pixelPerSecond');
        // print('_pixelTranslate : $_pixelTranslate');
        // print('_pixelScale : $_pixelScale');
        // print('_direction : $_direction');
        // print('_distance : $_distance');
        // print('_isFinite : $_isFinite');
        // print('_clampingPixelPerSecond : $_clampingPixelPerSecond');

        // _transformationController.toScene(_pixelScale);

        resetZoom();

      },
      // onInteractionStart: (ScaleStartDetails scaleStartDetails){
      //   print('scaleStartDetails : $scaleStartDetails');
      //   },
      // onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
      //   print('scaleUpdateDetails : $scaleUpdateDetails');
      //   },
      child: widget.child,
    );
  }
}
