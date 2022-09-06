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
  /// --------------------------------------------------------------------------
  const WidgetFader({
    @required this.fadeType,
    this.child,
    this.max = 1,
    this.min = 0,
    this.duration,
    this.curve = Curves.easeInOut,
    this.absorbPointer = false,
    this.builder,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final FadeType fadeType;
  final double max;
  final double min;
  final Duration duration;
  final Curve curve;
  final bool absorbPointer;
  final Widget Function(double, Widget) builder;
  /// --------------------------------------------------------------------------
  @override
  _WidgetFaderState createState() => _WidgetFaderState();
  /// --------------------------------------------------------------------------
}

class _WidgetFaderState extends State<WidgetFader> with SingleTickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  AnimationController _animationController;
  // Animation<double> _opacityTween;
  CurvedAnimation _animation;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

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

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _animationController.dispose();
    _animation.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    _animate();

    return AbsorbPointer(
        absorbing: widget.absorbPointer,
        child:

        widget.builder == null ?

        FadeTransition(
          opacity: _animation,
          child: widget.child,
        )

            :

        AnimatedBuilder(
            animation: _animation,
            child: widget.child,
            builder: (_, Widget child){

              final double _value = _animation.value;

              return widget.builder(_value, child);

            }
        )

    );

  }
  // -----------------------------------------------------------------------------
}
