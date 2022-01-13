import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/bubbles/bubble.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/user/status_buttons.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/xxx_lab/property_search_criteria.dart';
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
      centered: true,
      columnChildren: <Widget>[

        /// HEADLINE QUESTION
        const SuperVerse(
          verse: 'Let the Builders know',
          margin: 0,
          italic: true,
          color: Colorz.yellow255,
          weight: VerseWeight.thin,
          maxLines: 2,
        ),

        const SuperVerse(
          verse: 'What are you looking for ?',
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
        if (currentUserStatus == UserStatus.searching)
          PropertySearchCriteria(
            openEnumLister: openEnumLister,
          ),

        /// IF USER WANT TO SELL OR RENT HIS PROPERTY
        if (currentUserStatus == UserStatus.selling)
          Container(
            width: screenWidth - (abPadding * 4),
            height: 100,
            color: Colorz.yellow255,
            margin: const EdgeInsets.only(top: abPadding * 2),
            child: const SuperVerse(
              verse: 'SELL SELL SELL FUCKERS !!',
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
}
