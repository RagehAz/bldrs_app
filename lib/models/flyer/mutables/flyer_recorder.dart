import 'package:flutter/material.dart';

class FlyerRecorder{
  /// record functions
  final Function onViewSlide; // FlyerRecord
  final Function onAnkhTap; // FlyerRecord
  final Function onShareTap; // FlyerRecord
  final Function onFollowTap; // FlyerRecord
  final Function onCallTap; // FlyerRecord
  /// user based bool triggers
  bool ankhIsOn; // FlyerRecord
  bool followIsOn; // FlyerRecord

  FlyerRecorder({
    @required this.onViewSlide,
    @required this.onAnkhTap,
    @required this.onShareTap,
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.ankhIsOn,
    @required this.followIsOn,
  });

}