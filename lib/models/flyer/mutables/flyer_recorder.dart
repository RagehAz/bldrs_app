import 'package:flutter/material.dart';

class FlyerRecorder{
  /// record functions
  final Function onViewSlide; // FlyerRecord
  final Function onAnkhTap; // FlyerRecord
  final Function onShareTap; // FlyerRecord
  final Function onFollowTap; // FlyerRecord
  final Function onCallTap; // FlyerRecord
  final Function onCountersTap;
  final Function onEditReview;
  final Function onSubmitReview;
  /// user based bool triggers
  bool ankhIsOn; // FlyerRecord
  bool followIsOn; // FlyerRecord
  TextEditingController reviewController;
  final Function onShowReviewOptions;

  FlyerRecorder({
    @required this.onViewSlide,
    @required this.onAnkhTap,
    @required this.onShareTap,
    @required this.onFollowTap,
    @required this.onCallTap,
    @required this.onCountersTap,
    @required this.ankhIsOn,
    @required this.followIsOn,
    @required this.reviewController,
    @required this.onEditReview,
    @required this.onSubmitReview,
    @required this.onShowReviewOptions,
  });

}
