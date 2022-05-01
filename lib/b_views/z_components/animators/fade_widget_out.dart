import 'package:flutter/material.dart';

enum FadeType{
  fadeIn,
  fadeOut,
  repeatAndReverse,
  repeatForwards,
  stillAtMin,
  stillAtMax,
}

class WidgetFader extends StatefulWidget {
  const WidgetFader({
    @required this.child,
    @required this.fadeType,
    this.max = 1,
    this.min = 0,
    this.duration,
    this.curve = Curves.easeInOut,
    Key key
  }) : super(key: key);

  final Widget child;
  final FadeType fadeType;
  final double max;
  final double min;
  final Duration duration;
  final Curve curve;

  @override
  _WidgetFaderState createState() => _WidgetFaderState();
}

class _WidgetFaderState extends State<WidgetFader> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  CurvedAnimation _animation;
  // Animation<double> _opacityTween;

  @override
  void initState() {

    final Duration _duration = widget.duration ?? const Duration(seconds: 2);

    _animationController = AnimationController(
        reverseDuration: _duration,
        duration: _duration,
        vsync: this
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: widget.curve,
      reverseCurve: widget.curve,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.dispose();
    super.dispose();
  }

  Future<void> _animate() async {

    if (widget.fadeType == FadeType.fadeIn){
      await _animationController.forward(from: widget.min,);
    }
    else if (widget.fadeType == FadeType.fadeOut){
      await _animationController.reverse(from: widget.max);
    }
    else if (widget.fadeType == FadeType.repeatAndReverse){
      await _animationController.repeat(
        min: widget.min,
        max: widget.max,
        reverse: true,
        period: widget.duration,
      );
    }
    else if (widget.fadeType == FadeType.repeatForwards){
      await _animationController.repeat(
        min: widget.min,
        max: widget.max,
        reverse: false,
        period: widget.duration,
      );
    }
    else if (widget.fadeType == FadeType.stillAtMin){
      _animationController.value = widget.min;
    }
    else if (widget.fadeType == FadeType.stillAtMax){
      _animationController.value = widget.max;
    }
    else {
      await _animationController.forward(from: widget.min,);
    }

  }

  @override
  Widget build(BuildContext context) {

    _animate();

    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

}
