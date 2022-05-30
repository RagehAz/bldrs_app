import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';
import 'package:bldrs/b_views/z_components/balloons/user_balloon_structure/b_balloona.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/bz_profile/author_label.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/a_models/secondary_models/note_model.dart';
import 'package:flutter/material.dart';

class NotificationSenderBalloon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NotificationSenderBalloon({
    @required this.senderType,
    @required this.pic,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final NoteSenderType senderType;
  final String pic;
  /// --------------------------------------------------------------------------
  static const double balloonWidth = 40;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // double _screenWidth = Scale.superScreenWidth(context);

    return senderType == NoteSenderType.bz?
    BzLogo(
      width: balloonWidth,
      image: pic,
    )

        :

    senderType == NoteSenderType.author ?
    AuthorPic(
      authorPic: pic,
      width: balloonWidth,
    )

        :

    senderType == NoteSenderType.user ?
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

    senderType == NoteSenderType.bldrs ?
    const BldrsName(
      size: balloonWidth,
    )

        :

    senderType == NoteSenderType.country ?
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
