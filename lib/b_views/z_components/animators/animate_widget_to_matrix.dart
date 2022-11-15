import 'package:flutter/material.dart';

class AnimateWidgetToMatrix extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AnimateWidgetToMatrix({
    @required this.child,
    @required this.matrix,
    this.duration,
    this.origin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final Matrix4 matrix;
  final Duration duration;
  final Offset origin;
  /// --------------------------------------------------------------------------
  @override
  _AnimateWidgetToMatrixState createState() => _AnimateWidgetToMatrixState();
  /// --------------------------------------------------------------------------
}

class _AnimateWidgetToMatrixState extends State<AnimateWidgetToMatrix> with TickerProviderStateMixin {
  // --------------------------------------------------------------------------
  AnimationController _animationController;
  CurvedAnimation _curvedAnimation;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.duration ?? const Duration(seconds: 3),
      reverseDuration: widget.duration ?? const Duration(seconds: 3),
      vsync: this,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCirc,
    );

  }
  // --------------------
  @override
  void dispose() {
    _animationController.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.matrix == null){
      return widget.child;
    }

    else {

      // blog('matrix recieved : -');
      /*
      [0] 1.138749326453811,0.02232896657085917,0.0,-30.159553871702524
      [1] -0.02232896657085917,1.138749326453811,0.0,-37.20054909383884
      [2] 0.0,0.0,1.0,0.0
      [3] 0.0,0.0,0.0,1.0
       */
      // blog(widget.matrix);

      _animationController.forward(from: 0);


      return AnimatedBuilder(
        animation: _animationController,
        child: widget.child,
        builder: (_, Widget child){

          final Matrix4 matrix = Matrix4Tween(
            begin: Matrix4.identity(),
            end: widget.matrix,
          ).evaluate(_curvedAnimation);

          return Transform(
            transform: matrix,
            child: child,
          );

        },
      );
    }

  }
  // --------------------------------------------------------------------------
}
