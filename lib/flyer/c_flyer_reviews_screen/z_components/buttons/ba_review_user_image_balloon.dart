import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/flyer/c_flyer_reviews_screen/z_components/review_bubble/a_review_box.dart';
import 'package:bldrs/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:flutter/material.dart';

class ReviewUserImageBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewUserImageBalloon({
    required this.userModel,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final UserModel? userModel;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _balloonSize = ReviewBox.userBalloonSize;

    return SizedBox(
      key: const ValueKey('ReviewImageBalloonPart'),
      width: _balloonSize,
      child: UserBalloon(
        userModel: userModel,
        size: _balloonSize,
        loading: false,
        onTap: onTap,
        // balloonColor: ,
        shadowIsOn: false,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
