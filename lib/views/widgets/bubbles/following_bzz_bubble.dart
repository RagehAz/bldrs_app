import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FollowingBzzBubble extends StatelessWidget {
  // final List<FlyerData> bzLogos;

  // BldrsFollowing({
  //   // @required this.bzLogos,
  // });

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin * 2;

    double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    return InPyramidsBubble(
      centered: false,
      columnChildren: <Widget>[

        SuperVerse(
          verse: 'Following ${10} Businesses',
          size: 2,
          centered: false,
          margin: abPadding,
          color: Colorz.Grey,
        ),


        // BzGrid(
        //   gridZoneWidth: screenWidth - pageMargin * 4,
        //   bzLogos: bzLogos,
        //   numberOfColumns: 7,
        // ),


      ],
    );
  }
}
