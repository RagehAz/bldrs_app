import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_arrowed_balloon.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_circle_balloon.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_round_cornered_balloon.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_speaking_balloon.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_thinking_balloon.dart';
import 'package:bldrs/z_components/balloons/clip_paths/path_of_zero_cornered_balloon.dart';
import 'package:flutter/material.dart';

enum BalloonType{
  circle,
  thinking,
  arrowed,
  speaking,
  zeroCornered,
  roundCornered,
}

class Balloon {
  /// --------------------------------------------------------------------------

  const Balloon();

  // -----------------------------------------------------------------------------

  /// BALALEEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static CustomClipper<Path> getBalloonClipPath(BalloonType? type) {

    switch (type){
      case BalloonType.circle:        return PathOfCircleBalloon();
      case BalloonType.thinking:      return PathOfThinkingBalloon();
      case BalloonType.arrowed:       return PathOfArrowedBalloon();
      case BalloonType.speaking:      return PathOfSpeakingBalloon();
      case BalloonType.zeroCornered:  return PathOfZeroCorneredBalloon();
      case BalloonType.roundCornered: return PathOfRoundCorneredBalloon();
      default: return PathOfCircleBalloon();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BalloonType concludeBalloonByNeedType(NeedType? userStatus) {

    switch (userStatus){
      case NeedType.seekProperty         : return BalloonType.thinking;
      case NeedType.planConstruction     : return BalloonType.speaking;
      case NeedType.finishConstruction   : return BalloonType.zeroCornered;
      case NeedType.furnish              : return BalloonType.roundCornered;
      case NeedType.offerProperty        : return BalloonType.arrowed;
      default: return BalloonType.circle;
    }

  }
  // -----------------------------------------------------------------------------
}
