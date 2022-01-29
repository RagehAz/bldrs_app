import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
/// GO BACK ON HORIZONTAL MAX BOUNCE
class HorizontalBouncer extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const HorizontalBouncer({
    @required this.child,
    @required this.numberOfSlides,
    this.boxDistance,
   this.notificationListenerKey,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxDistance;
  final int numberOfSlides;
  final Widget child;
  final Key notificationListenerKey;
  /// --------------------------------------------------------------------------
  @override
  _HorizontalBouncerState createState() => _HorizontalBouncerState();
/// --------------------------------------------------------------------------
}

class _HorizontalBouncerState extends State<HorizontalBouncer> {
  final ValueNotifier<bool> _canNavigate = ValueNotifier(true);
  int _numberOfTimesBack = 0;

  @override
  void dispose() {
    _canNavigate.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  void navigate() {

    if (_canNavigate.value == true){
      _numberOfTimesBack++;
      blog('go back : _numberOfTimesBack : $_numberOfTimesBack');
      Nav.goBack(context);
    }

      _canNavigate.value = false;

  }

// -----------------------------------------------------------------------------
  bool _canSlideOnSwipe({
    @required ScrollUpdateNotification details,
    @required double boxDistance,
    int numberOfBoxes = 2,
  }) {
    final double _offset = details.metrics.pixels;

    const double _limitRatio = 0.1;

    final double _backLimit = boxDistance * _limitRatio * (-1);

    final double _nextLimit =
        (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));

    bool _canSlide;

    if (details.metrics.axis != Axis.horizontal) {
      _canSlide = false;
    }

    // else if (goesBackOnly == true) {
    //   _canSlide = _offset < _backLimit;
    // }

    else {
      _canSlide = _offset < _backLimit || _offset > _nextLimit;
    }

    // print('boxDistance * numberOfBoxes = $boxDistance * ${numberOfBoxes - 1} = ${boxDistance * (numberOfBoxes - 1)} : _backLimit : $_backLimit : _offset : $_offset');

    return _canSlide;
  }

  @override
  Widget build(BuildContext context) {
    final double _width = widget.boxDistance ?? Scale.superScreenWidth(context);

    return ValueListenableBuilder(
        valueListenable: _canNavigate,
        child: widget.child,
        builder: (_, bool canNavigate, Widget child){

          return NotificationListener<ScrollUpdateNotification>(
            key: widget.notificationListenerKey,
            onNotification: (ScrollUpdateNotification details) {

              final bool _canSlide = _canSlideOnSwipe(
                details: details,
                boxDistance: _width,
                numberOfBoxes: widget.numberOfSlides,
              );

              // print('details : ${details.scrollDelta}');

              if (_canSlide == true && canNavigate == true) {
                // ScrollDirection _direction = details.metrics.;

                navigate();
              }
              return true;
            },
            child: child,
          );

        }
    );
  }
}
