import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class AnimateWidgetToMatrix extends StatefulWidget {

  const AnimateWidgetToMatrix({
    @required this.child,
    @required this.matrix,
    this.duration,
    Key key
  }) : super(key: key);

  final Widget child;
  final Matrix4 matrix;
  final Duration duration;


  @override
  _AnimateWidgetToMatrixState createState() => _AnimateWidgetToMatrixState();
}

class _AnimateWidgetToMatrixState extends State<AnimateWidgetToMatrix> with TickerProviderStateMixin {

  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.duration ?? const Duration(seconds: 2),
      reverseDuration: widget.duration ?? const Duration(seconds: 2),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    if (widget.matrix == null){
      return widget.child;
    }

    else {
      _animationController.forward();
      return AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (_, Widget child){

          final Matrix4 matrix = Matrix4Tween(
            begin: Matrix4.identity(),
            end: widget.matrix,
          ).evaluate(_animationController);

          return MatrixGestureDetector(
            onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm){
            },
            shouldRotate: false,
            shouldScale: false,
            shouldTranslate: false,
            clipChild: true,
            focalPointAlignment: Alignment.center,
            child: Transform(
              transform: matrix,
              child: child,
            ),
          );

        },
      );
    }

  }

}
