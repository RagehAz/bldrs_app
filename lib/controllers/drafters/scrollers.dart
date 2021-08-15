import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum SlidingDirection{
  next,
  back,
  freeze,
}
// -----------------------------------------------------------------------------
class Scrollers{
// -----------------------------------------------------------------------------
  static ScrollPhysics superScroller(bool trigger){
    ScrollPhysics scroller = trigger == true ?
    const BouncingScrollPhysics()
        :
    const NeverScrollableScrollPhysics();

    return scroller;
  }
// -----------------------------------------------------------------------------
  static bool isAtTop(ScrollController scrollController){
    bool _atTop = scrollController.offset == scrollController.position.minScrollExtent;
    return _atTop;
  }
// -----------------------------------------------------------------------------
  static bool isAtBottom(ScrollController scrollController){
    bool _atTop = scrollController.offset == scrollController.position.maxScrollExtent;
    return _atTop;
  }
// -----------------------------------------------------------------------------
  static bool isGoingDown(ScrollController scrollController){
    bool _goingDown;

    if(scrollController != null){
      if(scrollController.position != null){
        _goingDown = scrollController.position.userScrollDirection == ScrollDirection.forward;
      }
    }

    return _goingDown;
  }
// -----------------------------------------------------------------------------
  static bool isGoingUp(ScrollController scrollController){
    bool _goingUp = scrollController.position.userScrollDirection == ScrollDirection.reverse;
    return _goingUp;
  }
// -----------------------------------------------------------------------------
  static bool isAtPercentFromTop({ScrollController scrollController, double percent, double maxHeight}){

    double _min = scrollController.position.minScrollExtent;
    double _max = maxHeight; //scrollController.position.maxScrollExtent;
    double _fraction = percent / 100 ;

    bool _isAtTenPercentFromTop = scrollController.offset <= (_min + (_max * _fraction));

    return _isAtTenPercentFromTop;
  }
// -----------------------------------------------------------------------------
  static bool canPageUp({ScrollUpdateNotification details, double height}){
    double _offset = details.metrics.pixels;

    double _bounceLimit = height * 0.3 * (-1);

    bool _canPageUp = _offset < _bounceLimit;

    return _canPageUp;
  }
// -----------------------------------------------------------------------------

}
// -----------------------------------------------------------------------------
class GoHomeOnMaxBounce extends StatefulWidget {
  final double height;
  final Widget child;
  final Function onNavigate;

  const GoHomeOnMaxBounce({
    this.height,
    @required this.child,
    this.onNavigate,
  });

  @override
  _GoHomeOnMaxBounceState createState() => _GoHomeOnMaxBounceState();
}

class _GoHomeOnMaxBounceState extends State<GoHomeOnMaxBounce> {
  bool _canNavigate = true;

  Future<void> navigate() async {

    setState(() {
      _canNavigate = false;
    });

    if (widget.onNavigate == null){
      await Nav.goBack(context);
    }

    else {
      widget.onNavigate();
    }

  }

  @override
  Widget build(BuildContext context) {

    double _height = widget.height == null ? Scale.superScreenHeight(context) : widget.height;

    return
      NotificationListener(
        onNotification: (ScrollUpdateNotification details){
          bool _canPageUp = Scrollers.canPageUp(details: details, height: _height,);

          if(_canPageUp == true && _canNavigate == true){

            navigate();

          }
          return true;
          },
        child: widget.child,
      );
  }
}
// -----------------------------------------------------------------------------
class Scroller extends StatelessWidget {
  final Widget child;

  Scroller({
    @required this.child,
});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3,
      radius: Radius.circular(1.5),
      isAlwaysShown: false,
      // controller: ,
      child: child,
    );
  }
}
// -----------------------------------------------------------------------------
