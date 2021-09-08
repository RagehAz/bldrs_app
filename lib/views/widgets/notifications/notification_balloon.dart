import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/pyramids/bldrs_name.dart';
import 'package:flutter/material.dart';

class NotificationSenderBalloon extends StatelessWidget {
  final NotiSender sender;
  final String pic;

  const NotificationSenderBalloon({
    @required this.sender,
    @required this.pic,
  });

  static double balloonWidth(){
    return 40;
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _balloonWidth = balloonWidth();

    return

      sender == NotiSender.bz ?
      BzLogo(
        width: _balloonWidth,
        image: pic,
      )
          :
      sender == NotiSender.author ?
      AuthorPic(
        authorPic: pic,
        flyerZoneWidth: _screenWidth * 0.89,
      )
          :
      sender == NotiSender.user ?
      UserBalloon(
        pic: pic,
        balloonWidth: _balloonWidth,
        balloonType: UserStatus.PlanningTalking,
        onTap: null,
        blackAndWhite: false,
        loading: false,
      )
          :
      sender == NotiSender.bldrs ?
      BldrsName(
        size: _balloonWidth,
      )
          :
      DreamBox(
        width: _balloonWidth,
        height: _balloonWidth,
        icon: pic,
      );

  }
}
