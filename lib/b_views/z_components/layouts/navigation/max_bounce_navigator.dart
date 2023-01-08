import 'package:scale/scale.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

/// GoHomeOnMaxBounce
class MaxBounceNavigator extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const MaxBounceNavigator({
    @required this.child,
    this.boxDistance,
    this.numberOfScreens = 1,
    this.onNavigate,
    this.notificationListenerKey,
    this.axis = Axis.vertical,
    this.isOn = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxDistance;
  final int numberOfScreens;
  final Widget child;
  final Function onNavigate;
  final Key notificationListenerKey;
  final Axis axis;
  final bool isOn;
  /// --------------------------------------------------------------------------
  @override
  _MaxBounceNavigatorState createState() => _MaxBounceNavigatorState();
  /// --------------------------------------------------------------------------
}

class _MaxBounceNavigatorState extends State<MaxBounceNavigator> {
  // -----------------------------------------------------------------------------
  bool _canNavigate = true;
  // --------------------
  Future<void> navigate() async {

      _canNavigate = false;

    if (widget.onNavigate == null) {

      await Nav.goBack(
        context: context,
        invoker: 'OldMaxBounceNavigator.navigate',
      );

    }

    else {
      await widget.onNavigate();
      _canNavigate = true;

    }
  }
  // --------------------
  bool _goesBackOnlyCheck() {
    bool _goesBack;

    if (widget.axis == Axis.vertical) {
      _goesBack = true;
    } else {
      _goesBack = false;
    }

    return _goesBack;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (widget.isOn == true){

      final double _height = widget.boxDistance ?? Scale.screenHeight(context);
      final double _width = widget.boxDistance ?? Scale.screenHeight(context);
      final double _boxDistance = widget.axis == Axis.vertical ? _height : _width;
      final bool _goesBackOnly = _goesBackOnlyCheck();

      return NotificationListener<ScrollUpdateNotification>(
        key: widget.notificationListenerKey,
        onNotification: (ScrollUpdateNotification details) {

          /// CAN SLIDE WHEN ( SLIDE LIMIT REACHED )
          final bool _canSlide = Scrollers.checkCanSlide(
            details: details,
            boxDistance: _boxDistance,
            numberOfBoxes: widget.numberOfScreens,
            goesBackOnly: _goesBackOnly,
            axis: widget.axis,
          );

          // blog('_canSlide : $_canSlide : _canNavigate : $_canNavigate');

          if (_canSlide == true && _canNavigate == true) {
            navigate();
          }

          return true;
        },
        child: widget.child,
      );


    }

    else {
      return widget.child;
    }

  }
// -----------------------------------------------------------------------------
}
