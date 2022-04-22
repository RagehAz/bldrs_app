import 'package:flutter/material.dart';

class AnimateWidgetToMatrix extends StatefulWidget {

  const AnimateWidgetToMatrix({
    @required this.child,
    @required this.matrix,
    this.duration,
    Key key
  }) : super(key: key);

  final Widget child;
  final List<double> matrix;
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

    _animationController.forward();

    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (_, Widget child){

        final Matrix4 matrix = Matrix4Tween(
            begin: Matrix4.identity(),
            end: Matrix4.fromList(widget.matrix),
        ).evaluate(_animationController);

        return Transform(
          transform: matrix,
          child: child,
        );

      },
    );
  }

}
