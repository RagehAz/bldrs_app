import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:flutter/material.dart';

/// GO BACK ON HORIZONTAL MAX BOUNCE
class HorizontalBouncer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HorizontalBouncer({
    required this.child,
    required this.numberOfSlides,
    required this.controller,
    this.boxDistance,
    this.notificationListenerKey,
    this.canNavigate = true,
    this.onNavigate,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? boxDistance;
  final int numberOfSlides;
  final Widget child;
  final Key? notificationListenerKey;
  final PageController controller;
  final bool canNavigate;
  final Function? onNavigate;
  /// --------------------------------------------------------------------------
  @override
  _HorizontalBouncerState createState() => _HorizontalBouncerState();
  /// --------------------------------------------------------------------------
}

class _HorizontalBouncerState extends State<HorizontalBouncer> {
  // -----------------------------------------------------------------------------
  late ValueNotifier<bool> _canNavigate;
  int _numberOfTimesBack = 0;
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _canNavigate = ValueNotifier(widget.canNavigate);
  }
  // --------------------
  @override
  void dispose() {
    _canNavigate.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> navigate() async {

    if (_canNavigate.value == true){
      _numberOfTimesBack++;
      // blog('go back : _numberOfTimesBack : $_numberOfTimesBack');
      if (_numberOfTimesBack == 1){

        if (widget.onNavigate == null){
          await Nav.goBack(
            context: context,
            invoker: 'HorizontalBouncer.navigate',
          );
        }

        else {
          widget.onNavigate!();
        }

      }
    }

    setNotifier(
        notifier: _canNavigate,
        mounted: mounted,
        value: false,
    );

  }
  // --------------------
  bool _canSlideOnSwipe({
    required ScrollUpdateNotification details,
    required double boxDistance,
    int numberOfBoxes = 2,
  }) {

    final double _offset = widget.controller.position.pixels;

    const double _limitRatio = 0.1;

    final double _backLimit = boxDistance * _limitRatio * (-1);

    final double _nextLimit =
        (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));

    bool _canSlide;

    if (details.metrics.axis != Axis.horizontal) {
      _canSlide = false;
    }

    else {
      _canSlide = _offset < _backLimit || _offset > _nextLimit;
    }

    return _canSlide;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = widget.boxDistance ?? Scale.screenWidth(context);

    return ValueListenableBuilder(
        valueListenable: _canNavigate,
        child: widget.child,
        builder: (_, bool canNavigate, Widget? child){

          return NotificationListener<ScrollUpdateNotification>(
            key: widget.notificationListenerKey,
            onNotification: (ScrollUpdateNotification details) {

              final bool _canSlide = _canSlideOnSwipe(
                details: details,
                boxDistance: _width,
                numberOfBoxes: widget.numberOfSlides,
              );

              if (_canSlide == true && canNavigate == true) {
                navigate();
              }

              return true;
            },
            child: child ?? const SizedBox(),
          );

        }
    );

  }
// -----------------------------------------------------------------------------
}
