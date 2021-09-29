import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/general/pyramids/bldrs_name.dart';
import 'package:flutter/material.dart';

class NotificationSenderBalloon extends StatelessWidget {
  final NotiPicType sender;
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

    // double _screenWidth = Scale.superScreenWidth(context);
    double _balloonWidth = balloonWidth();

    return

      sender == NotiPicType.bz ?
      BzLogo(
        width: _balloonWidth,
        image: pic,
      )
          :
      sender == NotiPicType.author ?
      AuthorPic(
        authorPic: pic,
        width: _balloonWidth,
      )
          :
      sender == NotiPicType.user ?
      UserBalloon(
        pic: pic,
        balloonWidth: _balloonWidth,
        balloonType: UserStatus.PlanningTalking,
        onTap: null,
        blackAndWhite: false,
        loading: false,
        shadowIsOn: false,
      )
          :
      sender == NotiPicType.bldrs ?
      BldrsName(
        size: _balloonWidth,
      )
          :
      sender == NotiPicType.country ?
      DreamBox(
        width: _balloonWidth,
        height: _balloonWidth,
        icon: Flagz.getFlagByIso3(pic),
      )
          :
      DreamBox(
        width: _balloonWidth,
        height: _balloonWidth,
        icon: pic,
      );

  }
}
