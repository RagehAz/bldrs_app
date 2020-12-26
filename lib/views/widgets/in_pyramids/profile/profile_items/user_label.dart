import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/user_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/in_pyramids_items/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class UserLabel extends StatelessWidget {
  final UserType userType;
  final Function switchUserType;
  final String userPicture;
  final String userName;
  final String userJobTitle;
  final String userCompanyName;
  final String userCity;
  final String userCountry;

  UserLabel({
    @required this.userType,
    @required this.switchUserType,
    @required this.userPicture,
    @required this.userName,
    @required this.userJobTitle,
    @required this.userCompanyName,
    @required this.userCity,
    @required this.userCountry,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    // double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    return InPyramidsBubble(

      centered: true,
      columnChildren: <Widget>[

        SizedBox(
          width: screenWidth,
          height: screenHeight * 0.05,
        ),

        UserBubble(
          bubbleWidth: 80,
          userType: userType,
          userPic: userPicture,
          onTap: (){},
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
