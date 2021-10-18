import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/views/widgets/specific/in_pyramids/profile/property_search_criteria.dart';
import 'package:bldrs/views/widgets/specific/in_pyramids/profile/status_buttons.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class StatusBubble extends StatelessWidget {

  final List<Map<String, Object>> status;
  final UserStatus userStatus;
  final Function switchUserStatus;
  final UserStatus currentUserStatus;
  final Function openEnumLister;

  const StatusBubble({
    @required this.status,
    @required this.userStatus,
    @required this.switchUserStatus,
    @required this.currentUserStatus,
    this.openEnumLister,
});

  @override
  Widget build(BuildContext context) {

    final double screenWidth = Scale.superScreenWidth(context);
    // double screenHeight = MediaQuery.of(context).size.height;
    const double pageMargin = Ratioz.appBarMargin * 2;

    const double abPadding = Ratioz.appBarMargin;
    // double abHeight = screenWidth * 0.25;
    // double profilePicHeight = abHeight;
    // double abButtonsHeight = abHeight - (2 * abPadding);

    // double propertyStatusBtWidth = (screenWidth - (2 * pageMargin) - (8 * abPadding)) / 3;
    // double propertyStatusBtHeight = 40;

    return Bubble(
      centered: true,
      columnChildren: <Widget>[

        /// HEADLINE QUESTION
        SuperVerse(
            verse: 'Let the Builders know',
            size: 2,
            centered: true,
            margin: 0,
            shadow: false,
            italic: true,
            color: Colorz.yellow255,
            weight: VerseWeight.thin,
            maxLines: 2,
          ),

        SuperVerse(
            verse: 'What are you looking for ?',
            size: 3,
            centered: true,
            shadow: true,
            italic: true,
            color: Colorz.yellow255,
            weight: VerseWeight.bold,
            maxLines: 2,
          ),

        const SizedBox(
          height: pageMargin,
        ),

        /// USER STATUS MAIN BUTTONS
        StatusButtons(
          status: status,
          stateIndex: 0,
          switchUserStatus: switchUserStatus,
          currentUserStatus: currentUserStatus,
        ),

        /// IF USER IS SEARCHING FOR PROPERTIES
        currentUserStatus == UserStatus.SearchingThinking ?
        PropertySearchCriteria(
          openEnumLister: openEnumLister,
        )

            :

        /// IF USER WANT TO SELL OR RENT HIS PROPERTY
        currentUserStatus == UserStatus.Selling ?
        Container(
          width: screenWidth - (abPadding * 4),
          height: 100,
          color: Colorz.yellow255,
          margin: const EdgeInsets.only(top: abPadding *  2),
          child: SuperVerse(
            verse: 'SELL SELL SELL FUCKERS !!',
          ),
        )

            :

        /// IF USER IS IN CONSTRUCTION
        currentUserStatus == UserStatus.Finishing ||
        currentUserStatus == UserStatus.PlanningTalking||
        currentUserStatus == UserStatus.Building ?
        StatusButtons(
          status: status,
          stateIndex: 1,
          switchUserStatus: switchUserStatus,
          currentUserStatus: currentUserStatus,
        )

            :

        Container(),

      ],
    );
  }
}
