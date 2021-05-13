import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
ScrollPhysics superScroller(bool trigger){
  ScrollPhysics scroller = trigger == true ?
  AlwaysScrollableScrollPhysics()
      :
  NeverScrollableScrollPhysics();

  return scroller;
}
// -----------------------------------------------------------------------------
