import 'package:flutter/material.dart';

class AnimateWidgetToMatrix extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimateWidgetToMatrix({
    @required this.child,
    @required this.matrix,
    this.duration = const Duration(seconds: 3),
    // this.origin,
    this.canAnimate = true,
    this.curve = Curves.easeInExpo,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final Matrix4 matrix;
  final Duration duration;
  // final Offset origin;
  final bool canAnimate;
  final Curve curve;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (canAnimate == true && matrix != null){
      return _AnimatedChild(
        duration: duration,
        matrix: matrix,
        curve: curve,
        child: child,
      );
    }

    else {
      return child;
    }
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class _AnimatedChild extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const _AnimatedChild({
    @required this.child,
    @required this.matrix,
    @required this.duration,
    @required this.curve,
    // @required this.origin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final Matrix4 matrix;
  final Duration duration;
  final Curve curve;
  // final Offset origin;
  /// --------------------------------------------------------------------------
  @override
  __AnimatedChildState createState() => __AnimatedChildState();
  /// --------------------------------------------------------------------------
}

class __AnimatedChildState extends State<_AnimatedChild> with TickerProviderStateMixin {
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
      curve: widget.curve,
    );

    _animationController.forward(from: 0);

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
