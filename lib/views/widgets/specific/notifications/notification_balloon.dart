import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/views/widgets/general/artworks/bldrs_name.dart';
import 'package:bldrs/views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:flutter/material.dart';

class NotificationSenderBalloon extends StatelessWidget {
  final NotiPicType sender;
  final String pic;

  const NotificationSenderBalloon({
    @required this.sender,
    @required this.pic,
    Key key,
  }) : super(key: key);

  static const double balloonWidth = 40;

  @override
  Widget build(BuildContext context) {

    // double _screenWidth = Scale.superScreenWidth(context);

    return

      sender == NotiPicType.bz ?
      BzLogo(
        width: balloonWidth,
        image: pic,
      )
          :
      sender == NotiPicType.author ?
      AuthorPic(
        authorPic: pic,
        width: balloonWidth,
      )
          :
      sender == NotiPicType.user ?
      Balloona(
          balloonWidth: balloonWidth,
          pic: pic,
          loading: false,
      )
      //   (
      //   pic: pic,
      //   balloonWidth: balloonWidth,
      //   balloonType: UserStatus.PlanningTalking,
      //   onTap: null,
      //   blackAndWhite: false,
      //   loading: false,
      //   shadowIsOn: false,
      // )
          :
      sender == NotiPicType.bldrs ?
      const BldrsName(
        size: balloonWidth,
      )
          :
      sender == NotiPicType.country ?
      DreamBox(
        width: balloonWidth,
        height: balloonWidth,
        icon: Flag.getFlagIconByCountryID(pic),
      )
          :
      DreamBox(
        width: balloonWidth,
        height: balloonWidth,
        icon: pic,
      );

  }
}
