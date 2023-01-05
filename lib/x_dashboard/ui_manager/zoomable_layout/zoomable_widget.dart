import 'dart:async';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoomableWidget({
    @required this.child,
    @required this.isOn,
    this.autoShrink = true,
    this.doubleTapReset = false,
    this.tapReset = false,
    this.onTap,
    this.zoomTriggerLimit = 2,
    this.onZoomLimitReachedListener,
    Key key,
  }) : super (key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final bool isOn;
  final bool autoShrink;
  final bool doubleTapReset;
  final bool tapReset;
  final Function onTap;
  final double zoomTriggerLimit;
  final ValueChanged<double> onZoomLimitReachedListener;
  /// --------------------------------------------------------------------------
  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> with TickerProviderStateMixin{
  TransformationController _transformationController;
  AnimationController _zoomAnimationController;
  // final ValueNotifier<double> _zoom = ValueNotifier(1);
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: Ratioz.duration150ms,
    );
    _transformationController.addListener(() {

      final double _scale = _transformationController.value.getMaxScaleOnAxis();

      if(_scale > widget.zoomTriggerLimit){
        // print('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX its bigger than 1.5 now');
        widget.onZoomLimitReachedListener(_scale);
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
//   void _changeZoom(double scale){
//     _zoom.value = _zoom.value * scale;
//   }

  Future<void> _resetZoom() async {
    final _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {
      _transformationController.value = _reset.value;
    });

    _zoomAnimationController.reset();
    unawaited(_zoomAnimationController.forward());
  }
// -----------------------------------------------------------------------------
  Future<void> _onDoubleTap() async {
    await _resetZoom();
    // Nav.goBack(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: () async {

          if(widget.tapReset == true){
            await _resetZoom();
          }

          if (widget.onTap != null) {
            widget.onTap();
          }

        },
        onDoubleTap: widget.doubleTapReset ? () async {await _onDoubleTap();} : null,
        child: InteractiveViewer(
          key: widget.key,
          transformationController: _transformationController,
          panEnabled: widget.isOn,
          scaleEnabled: widget.isOn,
          // constrained: true,
          alignPanAxis: true,
          // boundaryMargin: EdgeInsets.zero,
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

            // print('end at : ${scaleEndDetails.pointerCount}');
            // print('zoom : ${_zoom.value}');
          },
          // onInteractionStart: (ScaleStartDetails scaleStartDetails){
          //   print('scaleStartDetails : $scaleStartDetails');
          //   },
          onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
            // print('scaleUpdateDetails scale : ${scaleUpdateDetails.verticalScale}');

            // _changeZoom(scaleUpdateDetails.scale);
            // print('zoom : ${_zoom.value}');

            },
          child: widget.child ?? Container(),
        ),
      ),
    );
  }
}
