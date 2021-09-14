import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
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
  static bool canSlide({ScrollUpdateNotification details, double boxDistance, int numberOfBoxes}){
    double _offset = details.metrics.pixels;

    double _limitRatio = 0.25;

    double _backLimit = boxDistance * _limitRatio * (-1);

    double _nextLimit = (boxDistance * (numberOfBoxes - 1)) + (_backLimit * (-1));

    bool _canSlide = _offset < _backLimit || _offset > _nextLimit;

    // print('boxDistance * numberOfBoxes = $boxDistance * ${numberOfBoxes - 1} = ${boxDistance * (numberOfBoxes - 1)} : _backLimit : $_backLimit : _offset : $_offset');

    return _canSlide;
  }
// -----------------------------------------------------------------------------
  static Future<void> scrollTo({ScrollController controller, double offset}) async {

    // if (controller.positions.isEmpty == true){
      controller.animateTo(
        offset,
        curve: Curves.easeInOutCirc,
        duration: Ratioz.durationSliding400,
      );
    // }

  }
// -----------------------------------------------------------------------------
  static Future<void> scrollToBottom({@required ScrollController controller}) async {

    await controller.animateTo(controller.position.maxScrollExtent, duration: Ratioz.durationSliding400, curve: Curves.easeInOutCirc);

  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
class MaxBounceNavigator extends StatefulWidget {
  final double boxDistance;
  final int numberOfBoxes;
  final Widget child;
  final Function onNavigate;
  final Key notificationListenerKey;
  final Axis axis;

  const MaxBounceNavigator({
    this.boxDistance,
    this.numberOfBoxes = 1,
    @required this.child,
    this.onNavigate,
    this.notificationListenerKey,
    this.axis = Axis.vertical,
  });

  @override
  _MaxBounceNavigatorState createState() => _MaxBounceNavigatorState();
}

class _MaxBounceNavigatorState extends State<MaxBounceNavigator> {
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
      setState(() {
        _canNavigate = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    double _height = widget.boxDistance == null ? Scale.superScreenHeight(context) : widget.boxDistance;
    double _width = widget.boxDistance == null ? Scale.superScreenHeight(context) : widget. boxDistance;

    double _boxDistance = widget.axis == Axis.vertical ? _height : _width;

    return
      NotificationListener(
        key: widget.notificationListenerKey,
        onNotification: (ScrollUpdateNotification details){
          bool _canSlide = Scrollers.canSlide(
            details: details,
            boxDistance: _boxDistance,
            numberOfBoxes: widget.numberOfBoxes,
          );

          // print('details : ${details.scrollDelta}');

          if(_canSlide == true && _canNavigate == true){

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
      controller: ScrollController(keepScrollOffset: true, initialScrollOffset: 0,),
      // controller: ,
      child: child,
    );
  }
}
// -----------------------------------------------------------------------------
