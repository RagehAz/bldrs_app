import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/unfinished_status_buttons.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StatusBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatusBubble({
    @required this.status,
    @required this.userStatus,
    @required this.switchUserStatus,
    @required this.currentUserStatus,
    this.openEnumLister,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Map<String, Object>> status;
  final UserStatus userStatus;
  final Function switchUserStatus;
  final UserStatus currentUserStatus;
  final Function openEnumLister;
  /// --------------------------------------------------------------------------
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
      headerViewModel: const BubbleHeaderVM(),
      childrenCentered: true,
      columnChildren: <Widget>[

        /// HEADLINE QUESTION
        const SuperVerse(
          verse: Verse(
            text: '##Let the Builders know',
            translate: true,
          ),
          margin: 0,
          italic: true,
          color: Colorz.yellow255,
          weight: VerseWeight.thin,
          maxLines: 2,
        ),

        const SuperVerse(
          verse: Verse(
            text: '##What are you looking for ?',
            translate: true,
          ),
          size: 3,
          shadow: true,
          italic: true,
          color: Colorz.yellow255,
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
        // if (currentUserStatus == UserStatus.searching)
        //   PropertySearchCriteria(
        //     openEnumLister: openEnumLister,
        //   ),

        /// IF USER WANT TO SELL OR RENT HIS PROPERTY
        if (currentUserStatus == UserStatus.selling)
          Container(
            width: screenWidth - (abPadding * 4),
            height: 100,
            color: Colorz.yellow255,
            margin: const EdgeInsets.only(top: abPadding * 2),
            child: const SuperVerse(
              verse: Verse(
                text: '##SELL SELL SELL FUCKERS !!',
                translate: false,
              ),
            ),
          ),

        /// IF USER IS IN CONSTRUCTION
        if (currentUserStatus == UserStatus.finishing ||
            currentUserStatus == UserStatus.planning ||
            currentUserStatus == UserStatus.building)
          StatusButtons(
            status: status,
            stateIndex: 1,
            switchUserStatus: switchUserStatus,
            currentUserStatus: currentUserStatus,
          ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
