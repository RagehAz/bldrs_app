import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/property_search_criteria.dart';
import 'package:bldrs/views/widgets/in_pyramids/profile/status_buttons.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatusBubble extends StatelessWidget {

  final List<Map<String, Object>> status;
  final UserStatus userStatus;
  final Function switchUserStatus;
  final UserStatus currentUserStatus;
  final Function openEnumLister;


  StatusBubble({
    @required this.status,
    @required this.userStatus,
    @required this.switchUserStatus,
    @required this.currentUserStatus,
    @required this.openEnumLister,
});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    double pageMargin = Ratioz.ddAppBarMargin * 2;

    double abPadding = Ratioz.ddAppBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    // double propertyStatusBtWidth = (screenWidth - (2 * pageMargin) - (8 * abPadding)) / 3;
    // double propertyStatusBtHeight = 40;

    return InPyramidsBubble(
      centered: true,
      columnChildren: <Widget>[

        // --- HEADLINE QUESTION
        SuperVerse(
            verse: 'Let the Builders know',
            size: 2,
            centered: true,
            margin: 0,
            shadow: false,
            italic: true,
            color: Colorz.Yellow,
            weight: VerseWeight.thin,
            maxLines: 2,
          ),
        SuperVerse(
            verse: 'What are you looking for ?',
            size: 3,
            centered: true,
            shadow: true,
            italic: true,
            color: Colorz.Yellow,
            weight: VerseWeight.bold,
            maxLines: 2,
          ),

        SizedBox(
          height: pageMargin,
        ),

        // --- USER STATUS MAIN BUTTONS
        StatusButtons(
          status: status,
          stateIndex: 0,
          switchUserStatus: switchUserStatus,
          currentUserStatus: currentUserStatus,
        ),

        // --- IF USER IS SEARCHING FOR PROPERTIES
        currentUserStatus == UserStatus.SearchingUser ?
        PropertySearchCriteria(
          openEnumLister: openEnumLister,
        ) :

            // --- IF USER WANT TO SELL OR RENT HIS PROPERTY
        currentUserStatus == UserStatus.SellingUser ?
            Container(
          width: screenWidth - (abPadding * 4),
          height: 100,
          color: Colorz.Yellow,
          margin: EdgeInsets.only(top: abPadding*  2),
          child: SuperVerse(
            verse: 'SELL SELL SELL FUCKERS !!',
          ),
            ) :

            // --- IF USER IS IN CONSTRUCTION
        currentUserStatus == UserStatus.ConstructingUser ||
            currentUserStatus == UserStatus.PlanningUser||
            currentUserStatus == UserStatus.BuildingUser ?
        StatusButtons(
          status: status,
          stateIndex: 1,
          switchUserStatus: switchUserStatus,
          currentUserStatus: currentUserStatus,
        ) :
            Container(),

      ],
    );
  }
}
