

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FadeWidgetOut extends StatefulWidget {
  const FadeWidgetOut({
    @required this.child,
    Key key
  }) : super(key: key);

  final Widget child;

  @override
  _FadeWidgetOutState createState() => _FadeWidgetOutState();
}

class _FadeWidgetOutState extends State<FadeWidgetOut> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  CurvedAnimation _animation;
  // Animation<double> _opacityTween;

  @override
  void initState() {

    _animationController = AnimationController(
        reverseDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 2),
        vsync: this
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );



    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _animationController.reverse(from: 1);

    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
