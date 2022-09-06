import 'package:bldrs/f_helpers/drafters/animators.dart';
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
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
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
  // --------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  static ProgressBarModel emptyModel(){
    return const ProgressBarModel(
      index: 0,
      numberOfStrips: 1,
      swipeDirection: SwipeDirection.freeze,
    );
  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  static void updateProgressBarNotifierOnIndexChanged({
    @required BuildContext context,
    @required ValueNotifier<ProgressBarModel> progressBarModel,
    @required int newIndex,
    bool syncFocusScope = true,
    int numberOfPages,
  }){

    final SwipeDirection _direction = Animators.getSwipeDirection(
      newIndex: newIndex,
      oldIndex: progressBarModel.value.index,
    );

    if (syncFocusScope == true){
      if (_direction == SwipeDirection.next) {
        FocusScope.of(context).nextFocus();
      }
      else if (_direction == SwipeDirection.back) {
        FocusScope.of(context).previousFocus();
      }

    }

    progressBarModel.value = progressBarModel.value.copyWith(
      swipeDirection: _direction,
      index: newIndex,
      numberOfStrips: numberOfPages,
    );

  }
  // --------------------------------------------------------------------------
}
