import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_zero_cornered_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_arrowed_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_circle_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_speaking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_thinking_balloon.dart';
import 'package:bldrs/b_views/z_components/balloons/clip_paths/path_of_round_cornered_balloon.dart';
import 'package:flutter/material.dart';

enum BalloonType{
  circle,
  thinking,
  arrowed,
  speaking,
  zeroCornered,
  roundCornered,
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
CustomClipper<Path> concludeBalloonByUserStatus(UserStatus userStatus) {

  final CustomClipper<Path> userBalloon =
  userStatus == UserStatus.normal ? PathOfCircleBalloon()
      :
  userStatus == UserStatus.searching ? PathOfThinkingBalloon()
      :
  userStatus == UserStatus.finishing ? PathOfArrowedBalloon()
      :
  userStatus == UserStatus.planning ? PathOfSpeakingBalloon()
      :
  userStatus == UserStatus.building ? PathOfZeroCorneredBalloon()
      :
  userStatus == UserStatus.selling ? PathOfRoundCorneredBalloon()
      :
  userStatus == null ? PathOfCircleBalloon()
      :
  PathOfCircleBalloon();

  return userBalloon;
}
// -----------------------------------------------------------------------------
