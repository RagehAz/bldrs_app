import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';

class ProgressBarModel {
  /// --------------------------------------------------------------------------
  const ProgressBarModel({
    @required this.swipeDirection,
    @required this.index,
    @required this.numberOfStrips,
  });
  /// --------------------------------------------------------------------------
  final SwipeDirection swipeDirection;
  final int index;
  final int numberOfStrips;
/// --------------------------------------------------------------------------
  ProgressBarModel copyWith({
    SwipeDirection swipeDirection,
    int index,
    int numberOfStrips,
  }){
    return ProgressBarModel(
      swipeDirection: swipeDirection ?? this.swipeDirection,
      index: index ?? this.index,
      numberOfStrips: numberOfStrips ?? this.numberOfStrips,
    );
  }
// -----------------------------------------------------------------------------
  static ProgressBarModel emptyModel(){
    return const ProgressBarModel(
      index: null,
      numberOfStrips: null,
      swipeDirection: null,
    );
  }
// -----------------------------------------------------------------------------
}
