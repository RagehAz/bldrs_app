import 'package:bldrs/f_helpers/drafters/animators.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';
///=> TAMAM
class ProgressBarModel {
  /// --------------------------------------------------------------------------
  const ProgressBarModel({
    @required this.swipeDirection,
    @required this.index,
    @required this.numberOfStrips,
    this.stripsColors,
  });
  /// --------------------------------------------------------------------------
  final SwipeDirection swipeDirection;
  final int index;
  final int numberOfStrips;
  final List<Color> stripsColors;
  // --------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const Color errorStripColor = Colors.red;
  static const Color goodStripColor = Colors.green;
  static const Color defaultStripColor = Colorz.white255;
  // --------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ProgressBarModel copyWith({
    SwipeDirection swipeDirection,
    int index,
    int numberOfStrips,
    List<Color> stripsColors,
  }){
    return ProgressBarModel(
      swipeDirection: swipeDirection ?? this.swipeDirection,
      index: index ?? this.index,
      numberOfStrips: numberOfStrips ?? this.numberOfStrips,
      stripsColors: stripsColors ?? this.stripsColors,
    );
  }
  // --------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TESTED : WORKS PERFECT
  static ProgressBarModel initialModel({
    @required int numberOfStrips,
  }){

    return ProgressBarModel(
      swipeDirection: SwipeDirection.freeze,
      index: 0,
      numberOfStrips: numberOfStrips,
      stripsColors: ProgressBarModel.generateColors(
        colors: null,
        length: numberOfStrips,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ProgressBarModel emptyModel(){
    return const ProgressBarModel(
      index: 0,
      numberOfStrips: 1,
      swipeDirection: SwipeDirection.freeze,
      stripsColors: <Color>[Colorz.white255],
    );
  }
  // --------------------------------------------------------------------------

  /// SETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void onSwipe({
    @required BuildContext context,
    @required int newIndex,
    @required ValueNotifier<ProgressBarModel> progressBarModel,
    @required bool mounted,
    int numberOfPages,
  }){

    /// A - if Keyboard is active
    if (Keyboard.keyboardIsOn(context) == true) {

      ProgressBarModel._updateProgressBarNotifierOnIndexChanged(
        context: context,
        progressBarModel: progressBarModel,
        newIndex: newIndex,
        mounted: mounted,
        numberOfPages: numberOfPages,
        // syncFocusScope: true,
      );

    }

    /// A - if keyboard is not active
    else {
      ProgressBarModel._updateProgressBarNotifierOnIndexChanged(
        context: context,
        progressBarModel: progressBarModel,
        newIndex: newIndex,
        syncFocusScope: false,
        mounted: mounted,
        numberOfPages: numberOfPages,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void _updateProgressBarNotifierOnIndexChanged({
    @required BuildContext context,
    @required ValueNotifier<ProgressBarModel> progressBarModel,
    @required int newIndex,
    @required bool mounted,
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

    setNotifier(
        notifier: progressBarModel,
        mounted: mounted,
        value: progressBarModel.value.copyWith(
          swipeDirection: _direction,
          index: newIndex,
          numberOfStrips: numberOfPages,
        ),
    );

  }
  // --------------------------------------------------------------------------

  /// STRIPS COLORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Color> generateColors({
    @required int length,
    @required List<Color> colors,
  }){

    if (Mapper.checkCanLoopList(colors) == true){
      blog('generateColors : colors : $colors');
      return colors;
    }

    else {
      return List.generate(length, (index){
        return defaultStripColor;
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void setStripColor({
    @required int index,
    @required Color color,
    @required ValueNotifier<ProgressBarModel> notifier,
    @required bool mounted,
  }){

    final List<Color> _stripsColors = <Color>[ ...?notifier.value.stripsColors];

    _stripsColors.removeAt(index);
    _stripsColors.insert(index, color);

    setNotifier(
      notifier: notifier,
      mounted: mounted,
      value: notifier.value.copyWith(
        stripsColors: _stripsColors,
      ),
    );

  }
  // --------------------------------------------------------------------------
}
