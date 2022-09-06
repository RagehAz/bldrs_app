import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/b_review_bubble.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/a_user_balloon.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class ReviewUserImageBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewUserImageBalloon({
    @required this.userModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _balloonSize = ReviewBubble.userBalloonSize;

    return SizedBox(
      key: const ValueKey('ReviewImageBalloonPart'),
      width: _balloonSize,
      child: UserBalloon(
        userModel: userModel,
        size: _balloonSize,
        loading: false,
        onTap: (){blog('tapping user balloon in reviews');},
        // balloonColor: ,
        userStatus: UserStatus.planning,
        shadowIsOn: false,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
