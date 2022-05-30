

// -----------------------------------------------------------------------------
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_building_user.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_constructing_user.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_normal_user.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_planning_user.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_searching_user.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/clip_paths/path_selling_user.dart';
import 'package:flutter/material.dart';

CustomClipper<Path> userBalloon(UserStatus userType) {

  final CustomClipper<Path> userBalloon =
  userType == UserStatus.normal ? NormalCircle()
      :
  userType == UserStatus.searching ? SearchingThinking()
      :
  userType == UserStatus.finishing ? FinishingBalloon()
      :
  userType == UserStatus.planning ? PlanningTalkingBalloon()
      :
  userType == UserStatus.building ? BuildingBalloon()
      :
  userType == UserStatus.selling ? SellingBalloon()
      :
  userType == null ? NormalCircle()
      :
  NormalCircle();

  return userBalloon;

}
