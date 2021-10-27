import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// -----------------------------------------------------------------------------
enum SlidingDirection{
  next,
  back,
  freeze,
}
// -----------------------------------------------------------------------------
abstract class Scrollers{
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
    final bool _atTop = scrollController.offset == scrollController.position.minScrollExtent;
    return _atTop;
  }
// -----------------------------------------------------------------------------
  static bool isAtBottom(ScrollController scrollController){
    final bool _atTop = scrollController.offset == scrollController.position.maxScrollExtent;
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
    final bool _goingUp = scrollController.position.userScrollDirection == ScrollDirection.reverse;
    return _goingUp;
  }
// -----------------------------------------------------------------------------
  static bool isAtPercentFromTop({ScrollController scrollController, double percent, double maxHeight}){

    final double _min = scrollController.position.minScrollExtent;
    final double _max = maxHeight; //scrollController.position.maxScrollExtent;
    final double _fraction = percent / 100 ;

    final bool _isAtTenPercentFromTop = scrollController.offset <= (_min + (_max * _fraction));

    return _isAtTenPercentFromTop;
  }
// -----------------------------------------------------------------------------
  static bool canSlide({ScrollUpdateNotification details, double boxDistance, int numberOfBoxes, @required bool goesBackOnly, @required Axis axis}){
    final double _offset = details.metrics.pixels;

    const double _limitRatio = 0.25;

    final double _backLimit = boxDistance * _limitRatio * (-1);

    final int _numberOfBoxes = numberOfBoxes ?? 2;

    final double _nextLimit = (boxDistance * (_numberOfBoxes - 1)) + (_backLimit * (-1));

    bool _canSlide;

    if(details.metrics.axis != axis){
      _canSlide = false;
    }

    else if (goesBackOnly == true){
      _canSlide =  _offset < _backLimit;
    }
    else {
      _canSlide = _offset < _backLimit || _offset > _nextLimit;
    }

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
