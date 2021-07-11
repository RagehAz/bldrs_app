import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
// -----------------------------------------------------------------------------
/// ADD THIS IN PUBSPEC YAML
///
/// dependencies:
///     matrix_gesture_detector: ^0.1.0
class ZoomableWidget extends StatefulWidget {
  final Widget child;
  final Function onReset;
  final Function onMatrixUpdate;
  final bool shouldRotate;

  ZoomableWidget({
    @required this.child,
    this.onMatrixUpdate,
    this.onReset,
    this.shouldRotate = true,
    Key key,
}) : super(key: key);

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  Matrix4 _matrix = Matrix4.identity();
  Matrix4 _zero =  Matrix4.identity();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('Hello neo');

    return GestureDetector(
      onDoubleTap: (){
        setState(() {
          _matrix = _zero;
        });
      },
      child: MatrixGestureDetector(
        shouldRotate: widget.shouldRotate,
        shouldScale: true,
        shouldTranslate: true,
        clipChild: true,
        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          setState(() {
            _matrix = m;
          });
          widget.onMatrixUpdate(m);
        },
        child: Transform(
          transform: _matrix,
          child: widget.child,
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------


class StatelessZoomableWidget extends StatelessWidget {
  final Widget child;
  final Function onDoubleTap;
  final Function onMatrixUpdate;
  final bool shouldRotate;
  final Matrix4 matrix;

  StatelessZoomableWidget({
    @required this.child,
    this.onMatrixUpdate,
    this.onDoubleTap,
    this.shouldRotate = true,
    this.matrix,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      child: MatrixGestureDetector(
        shouldRotate: shouldRotate,
        shouldScale: true,
        shouldTranslate: true,
        clipChild: true,
        onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
          onMatrixUpdate(m);
        },
        child: Transform(
          transform: matrix,
          child: child,
        ),
      ),
    );
  }
}
