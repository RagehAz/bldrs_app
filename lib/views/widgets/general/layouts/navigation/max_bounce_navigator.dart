import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// -----------------------------------------------------------------------------
/// GoHomeOnMaxBounce
class MaxBounceNavigator extends StatefulWidget {
  final double boxDistance;
  final int numberOfScreens;
  final Widget child;
  final Function onNavigate;
  final Key notificationListenerKey;
  final Axis axis;

  const MaxBounceNavigator({
    @required this.child,
    this.boxDistance,
    this.numberOfScreens = 1,
    this.onNavigate,
    this.notificationListenerKey,
    this.axis = Axis.vertical,
    Key key,
  }) : super(key: key);

  @override
  _MaxBounceNavigatorState createState() => _MaxBounceNavigatorState();
}

class _MaxBounceNavigatorState extends State<MaxBounceNavigator> {
  bool _canNavigate = true;
// -----------------------------------------------------------------------------
  void navigate(){

    setState(() {
      _canNavigate = false;
    });

    if (widget.onNavigate == null){
      Nav.goBack(context);
      // await null;
    }

    else {
      widget.onNavigate();
      setState(() {
        _canNavigate = true;
      });
    }

  }
// -----------------------------------------------------------------------------
  bool _goesBackOnlyCheck(){
    bool _goesBack;

    if (widget.axis == Axis.vertical){
      _goesBack = true;
    }
    else {
      _goesBack = false;
    }

    return _goesBack;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = widget.boxDistance == null ? Scale.superScreenHeight(context) : widget.boxDistance;
    final double _width = widget.boxDistance == null ? Scale.superScreenHeight(context) : widget. boxDistance;

    final double _boxDistance = widget.axis == Axis.vertical ? _height : _width;

    final bool _goesBackOnly = _goesBackOnlyCheck();

    return
      NotificationListener<ScrollUpdateNotification>(
        key: widget.notificationListenerKey,
        onNotification: (ScrollUpdateNotification details){
          bool _canSlide = Scrollers.canSlide(
            details: details,
            boxDistance: _boxDistance,
            numberOfBoxes: widget.numberOfScreens,
            goesBackOnly: _goesBackOnly,
            axis: widget.axis,
          );

          // print('details : ${details.scrollDelta}');

          if(_canSlide == true && _canNavigate == true){

            // ScrollDirection _direction = details.metrics.;

            navigate();


          }
          return true;
        },
        child: widget.child,
      );
  }
}
