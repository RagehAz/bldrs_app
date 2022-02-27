import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';

class ReviewUserImageBalloonPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewUserImageBalloonPart({
    @required this.imageBoxWidth,
    @required this.userModel,
    @required this.bubbleMargin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double imageBoxWidth;
  final UserModel userModel;
  final double bubbleMargin;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _balloonWidth = imageBoxWidth - (bubbleMargin * 2);

    return Container(
      key: const ValueKey('ReviewImageBalloonPart'),
      width: imageBoxWidth,
      alignment: Alignment.topCenter,
      child: UserBalloon(
        userModel: userModel,
        balloonWidth: _balloonWidth,
        loading: false,
        onTap: (){blog('tapping user balloon in reviews');},
        // balloonColor: ,
        balloonType: UserStatus.planning,
        shadowIsOn: false,
      ),
    );
  }

}
