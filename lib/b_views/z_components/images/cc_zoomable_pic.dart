import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class ZoomablePicture extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoomablePicture({
    @required this.child,
    @required this.isOn,
    this.onTap,
    this.autoShrink = true,
    this.isFullScreen = false,
    this.transformationController,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final bool isOn;
  final bool autoShrink;
  final bool isFullScreen;
  final Function onTap;
  final TransformationController transformationController;
  /// --------------------------------------------------------------------------
  @override
  _ZoomablePictureState createState() => _ZoomablePictureState();
  /// --------------------------------------------------------------------------
}

class _ZoomablePictureState extends State<ZoomablePicture> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  TransformationController _transformationController;
  AnimationController _zoomAnimationController;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _transformationController = widget.transformationController ?? TransformationController();
    _zoomAnimationController = AnimationController(
      vsync: this,
      duration: Ratioz.duration150ms,
    );
    _transformationController.addListener(() {
      if (_transformationController.value.getMaxScaleOnAxis() > 1.5) {
        // blog('XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX its bigger than 1.5 now');
      }
    });
  }
  // --------------------
  @override
  void dispose() {
    _transformationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _resetZoom() async {

    final Animation<Matrix4> _reset = Matrix4Tween(
      begin: _transformationController.value,
      end: Matrix4.identity(),
    ).animate(_zoomAnimationController);

    _zoomAnimationController.addListener(() {

      setNotifier(
          notifier: _transformationController,
          mounted: mounted,
          value: _reset.value,
      );

    });

    _zoomAnimationController.reset();
    await _zoomAnimationController.forward();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onDoubleTap() async {
    await _resetZoom();
    await Nav.goBack(
      context: context,
      invoker: '_onDoubleTap',
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () async {

        if (widget.isFullScreen == true) {
          await _resetZoom();
        }

        if (widget.onTap != null){
          widget.onTap();
        }

      },
      onDoubleTap: widget.isFullScreen == false ? null : () => _onDoubleTap(),

      child: RotatedBox(
        quarterTurns: 0,
        child: InteractiveViewer(
          key: widget.key,
          transformationController: _transformationController,
          panEnabled: widget.isOn,
          scaleEnabled: widget.isOn,
          constrained: false,
          maxScale: 10,
          minScale: 0.5,
          onInteractionEnd: (ScaleEndDetails scaleEndDetails) async {

            if (widget.autoShrink == true) {
              await _resetZoom();
            }

            else {
              // await Future.delayed(Duration(seconds: 5), () async {
              //   await resetZoom();
              // });
            }

          },

          // onInteractionStart: (ScaleStartDetails scaleStartDetails){
          //   blog('scaleStartDetails : $scaleStartDetails');
          //   },
          // onInteractionUpdate: (ScaleUpdateDetails scaleUpdateDetails){
          //   blog('scaleUpdateDetails : $scaleUpdateDetails');
          //   },

          child: widget.child ?? const SizedBox(),
        ),
      ),


    );

  }
  // -----------------------------------------------------------------------------
}
