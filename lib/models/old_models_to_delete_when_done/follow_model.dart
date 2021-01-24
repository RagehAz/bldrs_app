import 'package:flutter/foundation.dart';

enum FollowState {
  accepted,
  declined,
  pending,
}

 class FollowModel{
   final String followID;
   final String userID;
   final String bzID;
   // final DateTime followTime;
   final FollowState followState;

   FollowModel({
     @required this.followID,
     @required this.userID,
     @required this.bzID,
     // @required this.followTime,
     @required this.followState,
 });
 }

