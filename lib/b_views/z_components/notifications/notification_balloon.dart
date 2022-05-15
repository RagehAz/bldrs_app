import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/buttons/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/author_label.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/f_helpers/notifications/notification_model/noti_model.dart';
import 'package:flutter/material.dart';

class NotificationSenderBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotificationSenderBalloon({
    @required this.sender,
    @required this.pic,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NotiPicType sender;
  final String pic;
  /// --------------------------------------------------------------------------
  static const double balloonWidth = 40;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // double _screenWidth = Scale.superScreenWidth(context);

    return sender == NotiPicType.bz?
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
