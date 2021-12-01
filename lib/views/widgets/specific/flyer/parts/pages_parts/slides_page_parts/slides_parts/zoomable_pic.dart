import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// TASK : try InteractiveViewer() in slides to zoom and pan
class ZoomablePicture extends StatefulWidget {
  final Widget child;
  final bool isOn;
  final autoShrink;
  final bool isFullScreen;
  final Function onTap;

  ZoomablePicture({
    @required this.child,
    @required this.isOn,
    @required this.onTap,
    this.autoShrink = true,
    this.isFullScreen = false,
    Key key,
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
    super.initState();
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
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _transformationController.dispose();
    _zoomAnimationController.dispose();

    super.dispose();
  }
// -----------------------------------------------------------------------------
  Future<void> _resetZoom() async {
    final Animation<Matrix4> _reset = await Matrix4Tween(
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
  Future<void> _onDoubleTap() async {
    await _resetZoom();
    Nav.goBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        if(widget.isFullScreen == true){
          _resetZoom();
        }

        else {
          widget.onTap();
        }

        },
      onDoubleTap: widget.isFullScreen ? () async {_onDoubleTap();} : null,
      child: InteractiveViewer(
        key: widget.key,
        transformationController: _transformationController,
        panEnabled: widget.isOn ? true : false,
        scaleEnabled: widget.isOn ? true : false,
        constrained: false,
        alignPanAxis: false,
        boundaryMargin: EdgeInsets.zero,
        maxScale: 10,
        minScale: 0.5,
        onInteractionEnd: (ScaleEndDetails scaleEndDetails) async {

          if(widget.autoShrink == true){
            await _resetZoom();
          } else {
            // await Future.delayed(Duration(seconds: 5), () async {
            //   await resetZoom();
            // });
          }

        },
        // onInteractionStart: (ScaleStartDetails scaleStartDetails){
        //   print('scaleStartDetails : $scaleStartDetails');
        //   },
        // onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
        //   print('scaleUpdateDetails : $scaleUpdateDetails');
        //   },
        child: widget.child == null ? Container() : widget.child,
      ),
    );
  }
}
