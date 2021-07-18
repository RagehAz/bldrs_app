import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
class Scrollers{
// -----------------------------------------------------------------------------
  static ScrollPhysics superScroller(bool trigger){
    ScrollPhysics scroller = trigger == true ?
    BouncingScrollPhysics()
        :
    NeverScrollableScrollPhysics();

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
    bool _goingDown = scrollController.position.userScrollDirection == ScrollDirection.forward;
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
}