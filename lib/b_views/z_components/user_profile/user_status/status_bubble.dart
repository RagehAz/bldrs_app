import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/unfinished_property_search_criteria.dart';
import 'package:bldrs/b_views/z_components/user_profile/user_status/unfinished_status_buttons.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class StatusBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatusBubble({
    @required this.status,
    @required this.onSelectStatus,
    @required this.currentStatus,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Map<String, Object>> status;
  final Function onSelectStatus;
  final UserStatus currentStatus;
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
        /// HEADLINE QUESTION
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

        /// SPACER
        const SizedBox(
          height: pageMargin,
        ),

        /// USER STATUS MAIN BUTTONS
        StatusButtons(
          status: status,
          stateIndex: 0,
          onSelectStatus: onSelectStatus,
          currentUserStatus: currentStatus,
        ),

        /// IF USER IS SEARCHING FOR PROPERTIES
        if (currentStatus == UserStatus.searching)
          const PropertySearchCriteria(),

        /// IF USER WANT TO SELL OR RENT HIS PROPERTY
        if (currentStatus == UserStatus.selling)
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
        if (currentStatus == UserStatus.finishing ||
            currentStatus == UserStatus.planning ||
            currentStatus == UserStatus.building)
          StatusButtons(
            status: status,
            stateIndex: 1,
            onSelectStatus: onSelectStatus,
            currentUserStatus: currentStatus,
          ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
