import 'package:bldrs/models/enums/enum_user_type.dart';
import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final UserType userType;
  final Function switchUserType;
  final String userPicture;
  final String userName;
  final String userJobTitle;
  final String userCompanyName;
  final String userCity;
  final String userCountry;
  final Function editProfileBtOnTap;

  UserBubble({
    @required this.userType,
    @required this.switchUserType,
    @required this.userPicture,
    @required this.userName,
    @required this.userJobTitle,
    @required this.userCompanyName,
    @required this.userCity,
    @required this.userCountry,
    @required this.editProfileBtOnTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = superScreenWidth(context);
    double screenHeight = superScreenHeight(context);
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    // double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);
    double topPadding = screenHeight * 0.05;
    double editProfileBtSize = topPadding ;

    return InPyramidsBubble(

      centered: true,
      columnChildren: <Widget>[

        Container(
          height: topPadding,
          alignment: superInverseCenterAlignment(context),
          child: DreamBox(
            height: editProfileBtSize,
            width: editProfileBtSize,
            icon: Iconz.Gears,
            iconSizeFactor: 0.6,
            bubble: true,
            boxFunction: editProfileBtOnTap,
          ),
        ),

        UserBalloon(
          balloonWidth: 80,
          userType: userType,
          userPic: userPicture,
          onTap: (){print('balloon tap');},
        ),

        // --- USER NAME
        SuperVerse(
          verse: userName,
          shadow: true,
          size: 4,
          margin: 5,
          maxLines: 2,
          labelColor: Colorz.WhiteAir,
        ),

        // --- USER JOB TITLE
        SuperVerse(
          verse: '$userJobTitle @ $userCompanyName',
          size: 2,
          italic: true,
          weight: VerseWeight.thin,
        ),

        // --- USER LOCALE
        SuperVerse(
          verse: 'in $userCity, $userCountry',
          weight: VerseWeight.thin,
          italic: true,
          color: Colorz.Grey,
          size: 2,
        ),

        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.05,
        ),
      ],
    );
  }
}
