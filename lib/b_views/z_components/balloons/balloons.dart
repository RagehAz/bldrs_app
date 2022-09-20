import 'package:bldrs/a_models/user/need_model.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_arrowed_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_circle_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_speaking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_thinking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_zero_cornered_balloon.dart';
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
    static CustomClipper<Path> getBalloonClipPath(BalloonType type) {

      switch (type){
        case BalloonType.circle:        return PathOfCircleBalloon();         break;
        case BalloonType.thinking:      return PathOfThinkingBalloon();       break;
        case BalloonType.arrowed:       return PathOfArrowedBalloon();        break;
        case BalloonType.speaking:      return PathOfSpeakingBalloon();       break;
        case BalloonType.zeroCornered:  return PathOfZeroCorneredBalloon();   break;
        case BalloonType.roundCornered: return PathOfZeroCorneredBalloon();   break;
        default: return PathOfCircleBalloon(); break;

      }

    }
  // --------------------
    static BalloonType concludeBalloonByNeedType(NeedType userStatus) {

      switch (userStatus){
        case NeedType.seekProperty         : return BalloonType.thinking; break;
        case NeedType.planConstruction     : return BalloonType.speaking; break;
        case NeedType.finishConstruction   : return BalloonType.zeroCornered; break;
        case NeedType.furnish              : return BalloonType.roundCornered; break;
        case NeedType.offerProperty        : return BalloonType.arrowed; break;
        default: return BalloonType.circle;
      }

    }
  // -----------------------------------------------------------------------------
}
