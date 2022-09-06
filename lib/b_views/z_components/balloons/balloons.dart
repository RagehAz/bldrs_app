import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_arrowed_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_circle_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_speaking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_thinking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_zero_cornered_balloon.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
enum BalloonType{
  circle,
  thinking,
  arrowed,
  speaking,
  zeroCornered,
  roundCornered,
}
// -----------------------------------------------------------------------------

/// BALALEEN

// --------------------
CustomClipper<Path> getBalloonClipPath(BalloonType type) {

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
BalloonType concludeBalloonByUserStatus(UserStatus userStatus) {

  final BalloonType userBalloon =
  userStatus == UserStatus.normal ? BalloonType.circle
      :
  userStatus == UserStatus.searching ? BalloonType.thinking
      :
  userStatus == UserStatus.finishing ? BalloonType.arrowed
      :
  userStatus == UserStatus.planning ? BalloonType.speaking
      :
  userStatus == UserStatus.building ? BalloonType.zeroCornered
      :
  userStatus == UserStatus.selling ? BalloonType.roundCornered
      :
  userStatus == null ? BalloonType.circle
      :
  BalloonType.circle;

  return userBalloon;
}
// -----------------------------------------------------------------------------
